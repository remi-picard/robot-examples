#!/bin/sh

# Start one or more robot framework test and allow to select them in a fuzzy finder.
# You can start multiple applications by selecting them with <tab>.

usage() {
  cat <<EOF

Usage : ./robot_start.sh [-f] [-a] [-d] [-h] ["search"]

Arguments :
   -f : Allows to start an entire .robot file.
   -a : Start all .robot files. (Can't be used with -f)
   -d : Start tests in dryrun mode
   -h : Display this help
   "search" : Will add this text in the search bar.

Examples :

$> ./robot_start.sh
> Test
  Quick Get Request With Parameters Test
  Teste Evaluate Autre Syntaxe
  Teste Classes Et Dataclasses
  Quick Get A JSON Body Test
  Teste List Comprehension
  Quick Get Request Test
  Mon Test Avec Groupes
  Teste Les Tuples
  Mon Premier Test
  Teste Variables
  Teste Evaluate
  Mon Test Bdd
▌ Test Ok
  13/35 (0) ────────────────────────────────────────────────

$> ./robot_start.sh -f
> 2
  tests/02-mon_premier_test.robot
  tests/12-wait_until.robot
  tests/21-list_comprehension.robot
▌ tests/20-class_dataclass.robot
  4/21 (0) ──────────────────────────────────────────────────────────────────────────────────────────────────────────────

EOF
}

while getopts "fadh" opt; do
    case $opt in
        f) file_mode=true ;;
        a) all_mode=true ;;
        d) dry_run=true ;;
        h) usage; exit 0 ;;
        *) usage; exit 1
    esac
done

shift "$(( OPTIND - 1 ))"

if [[ -n $file_mode && -n $all_mode ]]; then
  echo "\033[91mOptions -f and -a can't be used at the same time"
  exit 1
fi

if [[ $# -ge 1 ]]; then
    query="-q $1"
fi

source venv/bin/activate


start_tests() {
    local dry_run="$1"

    selected_tests=$(python3 resources/list_tests.py | fzf -m $query)

    if [[ -n "$selected_tests" ]]; then
        while IFS= read -r tests; do
            file=$(echo "$tests" | cut -d '|' -f 1)
            test_name=$(echo "$tests" | cut -d '|' -f 2)
            args+=" -t \"$test_name\""
        done <<< "$selected_tests"
        local args="$(add_dryrun_option $dry_run) $args"
        eval "robot $args -P. tests"
    fi
}

start_file() {
    local dry_run="$1"
    selected_files=$(ls tests/*.robot | fzf -m $query)
    for file in $selected_files; do
        echo "\033[94mRobot file : \033[0m $file"
        local args=$(add_dryrun_option $dry_run)
        robot $args -P. $file
    done
}

add_dryrun_option() {
    local dry_run="$1"
    local args=""
    [ -n "$dry_run" ] && args+=" --dryrun"
    echo "$args"
}

if [ -n "$file_mode" ]; then
    start_file $dry_run
elif [ -n "$all_mode" ]; then
    args=$(add_dryrun_option $dry_run)
    robot $args -P. tests
else
    start_tests "$dry_run" "$tag_mode" "$tagand_mode"
fi
