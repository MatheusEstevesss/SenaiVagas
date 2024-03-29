import React, { useState }  from 'react';
import { Text, View, TextInput, TouchableOpacity, Button } from 'react-native';
import styles from './style'
import Header from '../../components/header/index';

export default function Login({ navigation }) {

  const [email, setEmail] = useState('');
  const [senha, setSenha] = useState('');
  const [erroMensagem, setMessagemErro] = useState('');
  const [isLoading, setIsloading] = useState(false);

  const login = () => {
    setIsloading(true);

    const login = {
      Email: email.email,
      Senha: senha.senha
    }

    fetch('http://localhost:5000/api/login', {
      method: 'POST',
      body: JSON.stringify(login),
      headers: {
        'content-type': 'application/json'
      }
    })
      .then(response => response.json())
      .then(dados => {
        console.log(dados);
        if (dados.token !== undefined || dados.token !== null) {
          console.log('entrou')

          sessionStorage.setItem('token-SenaiVagas', dados.token);
          
          // Define a variável base64 que vai receber o payload do token
          var base64 = dados.token.split('.')[1];
          
          // convert o token em uma string
          var tokenstring =  window.atob(base64);
          // busca o campo "Role" na string e devolve seu valor
          var tipoUser = tokenstring.split(',')[2].split(':')[2];
          //retira as aspas duplas da string
          tipoUser = tipoUser.slice(1, -1);
          
          sessionStorage.setItem('permissao', tipoUser);
          sessionStorage.setItem('logado', '1');

          setIsloading(false);
          
          switch(tipoUser){
            case '1':
              navigation.navigate('Home')
              console.log('candidato')
              break;
            case '2' :
              navigation.navigate('Home')
              console.log('empresa')
              break;
            case '3':
              navigation.navigate('Home') 
              console.log('adm')
              
              break;
          }
        } else {
          setIsloading(false);
          setMessagemErro('Senha ou Email incorretos!')
        }
      })
      .catch(erro => {
        console.log(erro);
        setMessagemErro('Senha ou Email incorretos!');
        setIsloading(false);
      });
  }
  return (
    <View  style={styles.containerGeral}>
      <Header/>
      <View style={styles.container}>
        
        <Text style={styles.titulo}>Login</Text>
        <TextInput style={styles.input} 
        placeholder="Digite seu email" 
        autoCompleteType="email"
        textContentType='emailAddress'
        keyboardType='email-address'
        onChangeText={(email) => setEmail({ email })}
        /> 
        <TextInput style={styles.input} 
        placeholder="Digite sua senha"
        secureTextEntry={true} 
        autoCompleteType="password"
        onChangeText={(senha) => setSenha({ senha })}
        />  
        {
          erroMensagem != '' &&
          <Text style={styles.messageError}>{erroMensagem}</Text>
        }
        <TouchableOpacity style={styles.botao} onPress={()  => login()}>
          <Text style={styles.textBotao}>Entrar</Text>
        </TouchableOpacity> 
      </View>
    </View>
  );
}