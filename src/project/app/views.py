from django.shortcuts import render

from .models import Foo


def index(request):
	return render(request, "app/index.html", {'count': Foo.objects.count()})
