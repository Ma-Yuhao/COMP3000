from django.template import Library

register = Library()


@register.filter
def order_status(status):
    status_dict =  {
        1:"Completed",
        2:"Completed",
        3:"Completed",
        4:"Completed",
        5:"Completed",
    }
    return status_dict[status]
