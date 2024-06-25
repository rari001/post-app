import "@hotwired/turbo-rails";
import axios from 'axios';
import 'jquery';

const csrfToken = document.querySelector('[name=csrf-token]').content;
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken;

const appendNewComment = (sanitizedComment, comment) => {
  $('.comments-container').append(`
    <div class="article_comment">
      <img src="${comment.user.avatar_image_url}" alt="Avatar" class="comment__image-img">
      <p>${sanitizedComment}</p>
    </div>
  `)
}

document.addEventListener('turbo:load', () => {
  const dataset = $('#article-show').data()
  const articleId = dataset.articleId

  $('.inactive-heart').on('click', () => {
    axios.post(`/articles/${articleId}/like`)
      .then((response) => {
        if (response.data) {
          $('.active-heart').removeClass('hidden')
          $('.inactive-heart').addClass('hidden')
        }
      })
  })

  $('.active-heart').on('click', () => {
    axios.delete(`/articles/${articleId}/like`)
      .then((response) => {
        if (response.data) {
          $('.active-heart').addClass('hidden')
          $('.inactive-heart').removeClass('hidden')
        }
      })
  })

  axios.get(`/articles/${articleId}/like`)
    .then((response) => {
      if (response.data) {
        $('.active-heart').removeClass('hidden')
      } else {
        $('.inactive-heart').removeClass('hidden')
      }
    })

  $('.add-comment-button').on('click', () => {
    const content = $('#comment_content').val()
    if (!content) {
      window.alert('コメントを入力してください')
    } else {
      axios.post(`/articles/${articleId}/comments`, {
        comment: {content: content}
      })
        .then((response) => {
          const comment = response.data
          const sanitizedComment = $('<div>').text(comment.content).html()
          appendNewComment(sanitizedComment, comment)
          $('#comment_content').val('')
        })
    }
  })

  $('.show-comment-button').on('click', () => {
    $('.add-comment-area').removeClass('hidden')
    $('.show-comment-button').addClass('hidden')
  })

  $('.article').on('click', () => {
    $('.add-comment-area').addClass('hidden')
    $('.show-comment-button').removeClass('hidden')
  })

  axios.get(`/articles/${articleId}/comments`)
    .then((response) => {
      const comments = response.data
      comments.forEach((comment) => {
        const sanitizedComment = $('<div>').text(comment.content).html()
        appendNewComment(sanitizedComment, comment)
      })
    })
})