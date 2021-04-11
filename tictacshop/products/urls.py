# Django
from django.urls import path

# Views
from tictacshop.products.views import ProductListView, ProductDetailView


urlpatterns = [
    path('', ProductListView.as_view()),
    path(
        route='product/<int:pk>',
        view=ProductDetailView.as_view(),
        name='detail'
    ),
]