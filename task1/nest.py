import sys
import json
import traceback
from typing import List, Dict, Any


def __usage():
    print(
        'Specify keys to format result in command line\n'
        'Send json input to stdin\n'
        'Example: cat input.json | python nest.py key1 key2\n'
        'Errors:\n\t'
        '1 - bad json\n\t'
        '64 - other runtime errors e.g. wrong input data, missing keys, etc'
    )


def main(data: List[Dict[Any, Any]], args: List[str]) -> Dict[str, Any]:
    args_len = len(args)
    result = {}

    for item in data:
        current_dict = result
        for i, key in enumerate(args, 1):
            new_key = item.pop(key)
            if i != args_len:
                current_dict.setdefault(new_key, {})
                current_dict = current_dict[new_key]
            else:
                current_dict.setdefault(new_key, [])
                current_dict[new_key].append(item)
                # possible upgrade: don't append empty lists to result
    return result


if __name__ == '__main__':
    args = sys.argv[1:]
    if not args or '-h' in args or '--help' in args:
        __usage()
        sys.exit(0)

    data = sys.stdin.read().strip()
    try:
        j_data = json.loads(data)
        res = main(j_data, args)
        print(res)
        sys.exit(0)
    except json.JSONDecodeError as e:
        tb = traceback.format_exc()
        print(f'Invalid input data; error: {tb}')
        sys.exit(1)
    except Exception as e:
        # I think there is no point to handle any possible exceptions separately for this task
        tb = traceback.format_exc()
        print(f'Runtime error: {tb}')
        sys.exit(64)
