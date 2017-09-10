#~/bin/bash

file_size="64K"

time docker run -td --name ct1 cow/ssh:${file_size}1 /bin/bash &
time docker run -td --name ct2 cow/ssh:${file_size}2 /bin/bash &
time docker run -td --name ct3 cow/ssh:${file_size}3 /bin/bash &
time docker run -td --name ct4 cow/ssh:${file_size}4 /bin/bash &
time docker run -td --name ct5 cow/ssh:${file_size}5 /bin/bash &
time docker run -td --name ct6 cow/ssh:${file_size}6 /bin/bash &
time docker run -td --name ct7 cow/ssh:${file_size}7 /bin/bash &
time docker run -td --name ct8 cow/ssh:${file_size}8 /bin/bash &
time docker run -td --name ct9 cow/ssh:${file_size}9 /bin/bash &
time docker run -td --name ct10 cow/ssh:${file_size}10 /bin/bash &
time docker run -td --name ct11 cow/ssh:${file_size}11 /bin/bash &
time docker run -td --name ct12 cow/ssh:${file_size}12 /bin/bash &
time docker run -td --name ct13 cow/ssh:${file_size}13 /bin/bash &
time docker run -td --name ct14 cow/ssh:${file_size}14 /bin/bash &
time docker run -td --name ct15 cow/ssh:${file_size}15 /bin/bash &
time docker run -td --name ct16 cow/ssh:${file_size}16 /bin/bash &
time docker run -td --name ct17 cow/ssh:${file_size}17 /bin/bash &
time docker run -td --name ct18 cow/ssh:${file_size}18 /bin/bash &
time docker run -td --name ct19 cow/ssh:${file_size}19 /bin/bash &
time docker run -td --name ct20 cow/ssh:${file_size}20 /bin/bash &
