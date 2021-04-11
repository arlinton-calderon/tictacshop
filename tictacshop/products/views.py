# Django
from django.views.generic import ListView, DetailView

# Models
from tictacshop.products.models import Product


class ProductListView(ListView):
    template_name = 'products/product_list.html'
    model = Product
    ordering = ('-created', )
    paginate_by = 5
    context_object_name = 'products'


class ProductDetailView(DetailView):
    template_name = 'products/product_detail.html'
    slug_field = 'pk'
    slug_url_kwarg = 'pk'
    context_object_name = 'product'
    queryset = Product.objects.all()