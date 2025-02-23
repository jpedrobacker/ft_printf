SRC_DIR		=	src/
FIND_SRC	=	$(shell find $(SRC_DIR))
SRC			=	$(filter %.c, $(FIND_SRC))
OBJ			=	$(SRC:.c=.o)
CC			=	gcc
CFLAGS		=	-Wall -Wextra -Werror -I ./inc
NAME		=	myprintf.a
LIBNAME		=	mylib.a
MYLIBDIR	=	lib

.c.o:
	$(CC) $(CFLAGS) -c $< -o $(<:.c=.o)

all: $(NAME)

makelib:
		make -C lib
		cp lib/$(LIBNAME) .
		mv $(LIBNAME) $(NAME)

$(NAME): $(OBJ)
		make makelib
		mkdir -p obj
		ar -rcs $(NAME) $(OBJ)
		mv $(OBJ) obj/
		clear

clean:
		rm -rf obj/
		make -C $(MYLIBDIR) clean
		clear

fclean: clean
		rm -rf $(NAME)
		make -C lib fclean
		clear

re: fclean all
