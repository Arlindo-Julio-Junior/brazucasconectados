from django.shortcuts import render

def noticiasBrazucasConectados(request):
    return render(request, 'noticias/noticiasBrazucasConectados.html')