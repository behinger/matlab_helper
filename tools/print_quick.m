function [] = p2_print_quick
str = get(gcf,'name');
print(gcf,sprintf('%s_%s.jpg',datestr(now),str),'-djpeg','-r400')


