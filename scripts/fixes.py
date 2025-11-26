####################################################################################################

from pathlib import Path
import os

LINESEP = os.linesep

####################################################################################################

source_path = Path('./docs')

for root, _, filenames in source_path.walk():
    for filename in filenames:
        filename = root.joinpath(filename)
        if filename.suffix == '.md':
            content = filename.read_text()
            new_content = ''
            for line in content.splitlines():
                if line.startswith('<<<'):
                    # print(line)
                    line = line.replace('<<< @/docs/', '')
                    if '#' in line:
                        path, region = line.split('#')
                        region = '#' + region
                    else:
                        path = line
                        region = ''
                    path = source_path.joinpath(path).relative_to(root)
                    # print(path, region)
                    new_content += '```qml' + LINESEP
                    new_content += f'<!-- @include: {path}{region} -->' + LINESEP
                    new_content += '```' + LINESEP
                else:
                    new_content += line + LINESEP
            if new_content != content:
                print('-'*100)
                print(filename)
                # print('~'*50)
                # print(content)
                # print('~'*50)
                # print(new_content)
                filename.rename(filename.parent.joinpath(filename.name + '~~'))
                filename.write_text(new_content)
