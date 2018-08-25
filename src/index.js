import React from 'react';
import ReactDOM from 'react-dom';
import Searchbar from './components/search_bar'
import VideoDetail from './components/video_detail'
import VideoListItem from './components/video_list_item'
import VideoList from './components/video_list'

//Create a new componet. This component shoul produce some html


const API_KEY = 'AIzaSyDE44PiXLcWPOe_kFk_PJxnx299HxLtvs8';

const App = () => {
  return (
    <div>
      <Searchbar />
   </div>
 );
}


//Take this component's generate HTML and put it on the page (DOM)
ReactDOM.render(<App />, document.querySelector('.container')) //Instance component
