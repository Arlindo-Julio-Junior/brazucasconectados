from django.urls import path
from app_brazucas_conectados import views

urlpatterns = [
    #path('admin/', admin.site.urls),
    path('', views.noticiasBrazucasConectados,name='noticiasBrazucasConectados'),
]
