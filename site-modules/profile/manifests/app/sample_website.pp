# @summary This profile installs a sample website
class profile::app::sample_website {

  case $::kernel {
<<<<<<< HEAD
    'windows': { include profile::app::sample_website::windows }
    'Linux':   { include profile::app::sample_website::linux }
=======
    'windows': {
      include profile::app::sample_website::windows
    }
    'Linux':   {
      include profile::app::sample_website::linux
    }
>>>>>>> 027b7d0bde7e5e0cbf536511248582f2f130c0f0
    default:   {
      fail('Unsupported kernel detected')
    }
  }

}
