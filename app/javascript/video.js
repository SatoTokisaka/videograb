// app/assets/javascripts/video.js
function initializeVideoPlayers() {
    const playButtons = document.querySelectorAll('.play-button');
    console.log('Found play buttons:', playButtons.length);
  
    playButtons.forEach(button => {
      const videoContainer = button.closest('.video-container');
      const video = videoContainer ? videoContainer.querySelector('.video-player') : null;
  
      if (!video) {
        console.error('Video element not found for button:', button);
        return;
      }
  
      button.removeEventListener('click', handlePlayClick);
      button.addEventListener('click', handlePlayClick);
  
      function handlePlayClick() {
        console.log('Play button clicked for video:', videoContainer.dataset.videoId);
        video.play().then(() => {
          videoContainer.classList.add('video-playing');
          console.log('Video started playing');
        }).catch(error => {
          console.error('Error playing video:', error);
        });
      }
    });
  }
  
  function initializeVideoPolling() {
    const videoContent = document.querySelector('#video-content');
    if (!videoContent) {
      console.log('No video content found, skipping polling');
      return;
    }
  
    const videoId = videoContent.dataset.videoId;
    const isProcessing = videoContent.querySelector('.processing') !== null;
  
    if (!isProcessing) {
      console.log('Video is not processing, no polling needed');
      return;
    }
  
    console.log('Starting polling for video:', videoId);
  
    const pollInterval = setInterval(() => {
      fetch(`/videos/${videoId}/status`, {
        headers: {
          'Accept': 'application/json'
        }
      })
        .then(response => response.json())
        .then(data => {
          console.log('Video status:', data.status);
          if (data.status !== 'processing') {
            clearInterval(pollInterval);
            console.log('Status changed to', data.status, 'reloading page');
            window.location.reload(); // Reload the page to render the new content
          }
        })
        .catch(error => {
          console.error('Error polling video status:', error);
          clearInterval(pollInterval);
        });
    }, 5000); // Poll every 5 seconds
  }
  
  // Run on initial page load
  document.addEventListener('DOMContentLoaded', () => {
    initializeVideoPlayers();
    initializeVideoPolling();
  });
  
  // Re-run on Turbo page loads
  document.addEventListener('turbo:load', () => {
    initializeVideoPlayers();
    initializeVideoPolling();
  });