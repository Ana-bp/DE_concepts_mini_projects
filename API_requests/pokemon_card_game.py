#POKEMON CARD GAME 
#Your opponent is the code itself. Each one receives 3 random pokemon cards, playing one card in each round. The card with the pokemon with the higher "base_experience" wins.
#Wins the match the one that wins at least 2 rounds.


import requests, random

#Function that generates 3 random numbers (within 1 and 1025), that will be used to request the pokemons from the API
def choose_random():
    random_no =[]
    for i in range(0,3):
        random_no.append(random.randint(1,1025)) #The upper limit is 1025 because it's the largest number that follows the sequence starting at 1 on the API database.
    return random_no

#Function that request the pokemons from the API, based on the randomly generated numbers
def pokemon_info(numbers):
    pokemon=[]
    for i in numbers:
        api_url = "https://pokeapi.co/api/v2/pokemon/" + str(i) + "/"
        pokemon_api = requests.get(api_url)
        pokemon_details= pokemon_api.json()
        pokemon.append([pokemon_details['name'],pokemon_details['base_experience']])
    return pokemon #Returns a list with the 3 "pokemon cards"

def text_to_file(file,content):
    file.writelines(content)


#main
results_file = open("Results.txt","a")

while True: #The code will only stop if the user decides not to play another match
    my_cards=pokemon_info(choose_random())
    pc_cards=pokemon_info(choose_random())
    victories=0
    rounds= 1

    while my_cards != []:
        text = []

        text.append(f'\nROUND {rounds}')
        print (text[0])

        if len(my_cards) ==1:
            print(f'\nYou have {len(my_cards)} card:')
        else:
            print(f'\nYou have {len(my_cards)} cards:')
        for i in range(len(my_cards)):
            print(f'Card {i+1}:\npokemon: {my_cards[i][0]}\nexperience: {my_cards[i][1]}')
        
        no_mycard = int(input('Choose a card to play: '))-1
        no_pccard = random.randint(0,len(pc_cards)-1)
        
                
        text.append(f'\nYour card: pokemon: {my_cards[no_mycard][0]}, experience: {my_cards[no_mycard][1]}')
        print(text[1])
        
        text.append(f'\nOpponent\'s card: pokemon: {pc_cards[no_pccard][0]}, experience: {pc_cards[no_pccard][1]}')
        print(text[2])
        
        if my_cards[no_mycard][1] > pc_cards[no_pccard][1]:
            text.append('\nYou won the round!')
            print(text[3])
            victories = victories+1
        elif my_cards[no_mycard][1] == pc_cards[no_pccard][1]:
            text.append('\nIt\'s a draw!')
            print(text[3])
        else:
            text.append('\nThe opponent won the round!')
            print(text[3])
            victories -= 1

        my_cards.pop(no_mycard)
        pc_cards.pop(no_pccard)

        rounds += 1
        results_file.writelines(text)

    if victories >0:
        text.append('\n\nCongrats, you won the match!\n')
        print(text[4])
    elif victories ==0:
        text.append('\n\nYou and your opponent tied.\n')
        print(text[4])
    else:
        text.append('\n\nThe opponent won the match. Better luck next time!\n')
        print(text[4])

    results_file.write(text[4])

    play_again = input('Do you wanna play again? (YES or NO)\n')

    if play_again.lower() == "no":
        break

results_file.close()



























