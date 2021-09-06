"""
{{cookiecutter.project_name}} URL Configuration

For more information on this file, see
https://docs.djangoproject.com/en/3.2/topics/http/urls/
"""
from django.contrib import admin
from django.urls import (
    include,
    path
)
from drf_spectacular.views import (
    SpectacularAPIView,
    SpectacularSwaggerView
)


urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('accounts.urls')),
]

if settings.DEBUG:
    urlpatterns.extend([
        path('schema/', SpectacularAPIView.as_view(), name='schema'),
        path('swagger/', SpectacularSwaggerView.as_view(), name='swagger'),
    ])

    for el in [
        static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT),
        static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
    ]: urlpatterns += el  # noqa: E701
