import re
from ..base import Base

class Filter(Base):
    def __init__(self, vim):
        super(Filter, self).__init__(vim)

        self.name = 'converter/project_name'
        self.description = 'add project name prefix'

    def filter(self, context):
        def f(path):
            info = self.vim.call('current_project#file_info', path)
            if info['name'] == '':
                return path
            return '[' + info['name'] + '] ' + info['file_path']
        for candidate in context['candidates']:
            if not candidate.get('project_name__done'):
                candidate['abbr'] = f(candidate['word'])
                candidate['project_name__done'] = True
        return context['candidates']
