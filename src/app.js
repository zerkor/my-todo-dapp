App = {
  loading: false,
  contracts: {},

  load: async () => {
    await App.loadWeb3()
    await App.loadAccount()
    await App.loadContract()
    await App.render()
  },

  // Charge Web3
  loadWeb3: async () => {
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider
      web3 = new Web3(web3.currentProvider)
    } else {
      window.alert("Veuillez vous connecter à MetaMask.")
    }
    if (window.ethereum) {
      window.web3 = new Web3(ethereum)
      try {
        await ethereum.enable()
      } catch (error) {
        console.log("Accès au compte refusé.")
      }
    } else if (window.web3) {
      App.web3Provider = web3.currentProvider
      window.web3 = new Web3(web3.currentProvider)
    } else {
      console.log('Navigateur non compatible avec Ethereum détecté. Essayez MetaMask !')
    }
  },

  // Charge le compte connecté
  loadAccount: async () => {
    App.account = web3.eth.accounts[0]
  },

  // Charge le contrat intelligent
  loadContract: async () => {
    const todoList = await $.getJSON('TodoList.json')
    App.contracts.TodoList = TruffleContract(todoList)
    App.contracts.TodoList.setProvider(App.web3Provider)

    App.todoList = await App.contracts.TodoList.deployed()
  },

  // Rend le contenu à l'écran
  render: async () => {
    if (App.loading) return

    App.setLoading(true)

    $('#account').html(App.account)

    await App.renderTasks()

    App.setLoading(false)
  },

  // Nouvelle version de la fonction renderTasks utilisant getAllTasks()
  renderTasks: async () => {
    // Récupère toutes les tâches depuis le contrat en un seul appel
    const result = await App.todoList.getAllTasks()
    const taskIds = result[0]
    const taskContents = result[1]
    const taskCompleted = result[2]

    const $taskTemplate = $('.taskTemplate')

    // Boucle sur les tâches récupérées
    for (let i = 0; i < taskIds.length; i++) {
      const taskId = taskIds[i].toNumber()
      const taskContent = taskContents[i]
      const taskIsCompleted = taskCompleted[i]

      const $newTaskTemplate = $taskTemplate.clone()
      $newTaskTemplate.find('.content').html(taskContent)
      $newTaskTemplate.find('input')
                      .prop('name', taskId)
                      .prop('checked', taskIsCompleted)
                      .on('click', App.toggleCompleted)

      if (taskIsCompleted) {
        $('#completedTaskList').append($newTaskTemplate)
      } else {
        $('#taskList').append($newTaskTemplate)
      }

      $newTaskTemplate.show()
    }
  },

  createTask: async () => {
    App.setLoading(true)
    const content = $('#newTask').val()
    await App.todoList.createTask(content)
    window.location.reload()
  },

  toggleCompleted: async (e) => {
    App.setLoading(true)
    const taskId = e.target.name
    await App.todoList.toggleCompleted(taskId)
    window.location.reload()
  },

  setLoading: (boolean) => {
    App.loading = boolean
    const loader = $('#loader')
    const content = $('#content')
    if (boolean) {
      loader.show()
      content.hide()
    } else {
      loader.hide()
      content.show()
    }
  }
}

$(() => {
  $(window).load(() => {
    App.load()
  })
})
