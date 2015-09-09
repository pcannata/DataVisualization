require(extrafont)
require(ggplot2)
ggplot() + 
coord_cartesian() + 
#scale_x_continuous() +
scale_x_discrete() +
scale_y_continuous() +
scale_color_hue() +
#facet_wrap(~cut) +
facet_grid(clarity~cut) +
labs(title='Diamonds') +
labs(x="Cut", y="Price") +
theme_grey() +
theme(plot.background = element_rect(fill="green", colour=NA)) +
theme(plot.title=element_text(size=30, face="bold", vjust=1, family="Bauhaus93")) +
theme(axis.ticks.y=element_blank(), axis.text.y=element_blank()) +
theme(axis.text.x=element_text(angle=50, size=20, vjust=0.5)) +
theme(
    axis.title.x=element_text(color="forestgreen", vjust=0.35),
    axis.title.y=element_text(color="cadetblue", vjust=0.35)
  ) +
layer(data=diamonds, 
  mapping=aes(x=cut, y=price, color=color), 
  stat="identity", 
  stat_params=list(), 
  geom="point",
  geom_params=list(), 
  #position=position_identity()
  position=position_jitter(width=0.3, height=0)
  #position=position_dodge()
) + 
layer(data=diamonds, 
  mapping=aes(x=cut, y=price), 
  stat="boxplot", 
  stat_params=list(), 
  geom="boxplot",
  geom_params=list(color="red", fill="red", alpha=0), 
  position=position_identity()
) + layer(
  data=diamonds,
  mapping=aes(x=cut, y=price),
  stat="smooth", stat_params=list(),
  geom="smooth", geom_params=list(),
  position=position_identity()
) +
layer(
  data=diamonds,
  mapping=aes(x=color),
  stat="bin",
  stat_params=list(),
  geom="bar",
  geom_params=list(),
  position=position_identity()
)
