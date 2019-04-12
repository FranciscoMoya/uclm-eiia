from flask_wtf import FlaskForm
from flask_wtf.file import FileField, FileAllowed, FileRequired
from wtforms import SubmitField
from crud.data_layer import get_db
from werkzeug import secure_filename
import os, datetime

class JustificantesForm(FlaskForm):
    justificante = FileField('Nuevo justificante',
                             validators = [
                                 FileRequired,
                                 FileAllowed(['pdf','txt'], 'Solo archivos PDF')
                             ])
    submit = SubmitField('Añadir')

    def store(self, uid):
        if not self.justificante.data: return
        filename = secure_filename(os.path.basename(self.justificante.data.filename))
        dirname = f'html/static/justificantes/{uid}'
        os.makedirs(dirname, exist_ok = True)
        filename = filename_fix_existing(f'{dirname}/{filename}')
        self.justificante.data.save(filename)

    def to_list(self):
        return [ getattr(self, k).data for k in ['justificante'] ]

    def list_files_for(self, uid):
        try:
            dirname = f'html/static/justificantes/{uid}/'
            files = os.listdir(dirname)
            return [ (f, datetime.datetime.fromtimestamp(os.path.getmtime(dirname + f))) for f in files]
        except:
            return []

# Taken from https://github.com/steveeJ/python-wget/blob/master/wget.py#L72
def filename_fix_existing(filename):
    """Expands name portion of filename with numeric ' (x)' suffix to
    return filename that doesn't exist already.
    """
    if not os.path.exists(filename): return filename
    dirname = os.path.dirname(filename)
    filename = os.path.basename(filename)
    name, ext = filename.rsplit('.', 1)
    names = [x for x in os.listdir(dirname) if x.startswith(name)]
    names = [x.rsplit('.', 1)[0] for x in names]
    suffixes = [x.replace(name, '') for x in names]
    # filter suffixes that match ' (x)' pattern
    suffixes = [x[2:-1] for x in suffixes
                   if x.startswith(' (') and x.endswith(')')]
    indexes  = [int(x) for x in suffixes
                   if set(x) <= set('0123456789')]
    idx = 1
    if indexes:
        idx += sorted(indexes)[-1]
    return f'{dirname}/{name} ({idx}).{ext}'