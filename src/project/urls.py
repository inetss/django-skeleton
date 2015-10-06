import pathlib
import re

from django.conf import settings
from django.conf.urls import url, include
from django.conf.urls.static import static
from django.contrib import admin


admin.autodiscover()

# robots.txt and friends
root_files = [p.name for p in pathlib.Path(settings.STATICFILES_ROOT).iterdir() if p.is_file()]

urlpatterns = [
	url(r'^(%s)$' % '|'.join(map(re.escape, root_files)), 'django.views.static.serve', {'document_root': settings.STATICFILES_ROOT}),
	url(r'^admin/', include(admin.site.urls)),
	url(r'', include('project.app.urls')),
]

if settings.DEBUG:
	urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT, show_indexes=True)
