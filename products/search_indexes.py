from haystack import indexes
from products.models import Products



class ProductsIndex(indexes.SearchIndex, indexes.Indexable):

    text = indexes.CharField(document=True, use_template=True)

    def get_model(self):
        return Products

    def index_queryset(self, using=None):
        return self.get_model().objects.all()
