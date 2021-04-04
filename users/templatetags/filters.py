from django.template import Library

register = Library()


@register.filter
def order_status(status):
    status_dict =  {
        1:"To be paid",
        2:"To be delivered",
        3:"To be received",
        4:"To be evaluated",
        5:"Completed",
    }
    return status_dict[status]
