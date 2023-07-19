from django.contrib import admin
from django.urls import path
from app_brazucas_conectados import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path("noticias/",views.noticias, name="noticias_brazucas_conectados"),
]
