import React, {useState, useEffect} from 'react';
import {
  TouchableOpacity,
  StyleSheet,
  Text,
  View,
  ScrollView,
  Button,
  TextInput,
  Alert,
} from 'react-native';
import * as watch from 'react-native-watch-connectivity';
import axios from 'axios';

const CommunityTest = () => {
  const [userData, setUserData] = useState('');
  const [errorText, setErrorText] = useState('');

  // useEffect(()=>{
  //   watch.subscribeToMessages((err, message, replyHandler) =>{
  //     if(err) return
  //     if(message){
  //       setCurrentWorkout(message['message'])
  //       replyHandler({ message: 'Response from the app'});
  //     }
  //   })
  // }, [])

  sendMessageTowatch = () => {
    try {
      console.log('hello');
      // const messageData = {
      //   weight: '벤치프레스',
      //   reps: '스쿼트',
      // };

      // 데이터 보내는 방법
      // 1. {} 객체 하나로
      // 2. { a: JSON.stringify([ { b: 'c', d: 'e'} ]) }
      const messageData = {
        name1: '벤치프레스',
        name2: '스쿼트',
        name3: '데드리프트',
      };
      // let messageData = JSON.stringify(message)
      // let messageData = {name: '벤치프레스', setRep: '100kg x 10'}
      console.log(typeof messageData);
      
      watch.sendMessage(messageData, reply => {
        console.log(reply);
      });
    } catch (error) {
      console.log(error);
    }
  };

  // setCurrentWorkout = (id) => {
  //   const newWorkOuts = workOuts.map((workout) => {
  //     return {
  //       id: workout.id,
  //       name: workout.name,
  //       setReps: workout.setReps
  //     }
  //   })
  // }
  sendMessageTowatch();

  receiveMessageFromwatch = () => {
    try {
      const unsubscribe = watch.watchEvents.on('message', (message) => {
        console.log('received message from watch', message);
      });
    } catch (error) {
      console.log(error);
    }
  };

  receiveMessageFromwatch();

  const watchBtn = async id => {
    sendMessageTowatch();
  };

  const getTestBtn = async () => {
    try {
      console.log('hi');
      const userId = 3;
      const result = await axios.get(
        `http://localhost:4000/community/users/${userId}`,
      );
      console.log(result.data.result.eu.uniquename);
      console.log('axios result', result.data.result.eu);
      let res = JSON.stringify(result.data.result.eu.uniquename);
      setUserData(res);
      // console.log(userData);
    } catch (error) {
      console.log('error', error.response);
      // console.warn('axios get FAILED', error.response);
      // setErrorText(error);
    }
    // try {
    //   const response = await fetch('http://localhost:4000/community/users/3');
    //   const json = await response.json();
    //   console.log(json.data);
    //   setUserData(json);
    //   console.log('result data', json);
    // } catch (error) {
    //   setErrorText(error);
    //   console.error(error);
    // }
  };

  return (
    <View>
      <Text>CommunityTest</Text>
      <TextInput onChangeText={text => setText(text)} />
        <Button title={'테스트버튼'} onPress={watchBtn} />
      <ScrollView contentContainerStyle={styles.listContainer}>
        <Text>유저 : {userData}</Text>
        <Text>에러 : {errorText}</Text>
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  listContainer: {
    alignItems: 'center',
  },
  title: {
    alignContent: 'center',
  },
});

export default CommunityTest;
