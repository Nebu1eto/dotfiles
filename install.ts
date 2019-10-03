import * as os from 'os'
import * as fs from 'mz/fs'
import * as yaml from 'js-yaml'

type TryCatchResult<T> = [Error?, T?]

/**
 * Linking Symlinks for Installation
 *
 * @param filePath declare configure yaml's path
 */
async function main (filePath: string = './configuration.yml') {
  const configure = yaml.safeLoad(await fs.readFile(filePath, 'utf8'))
  const mkdirs = configure.mkdirs as Array<string>
  const symlinks = configure.symlinks as Array<{ from: string, to: string }>

  const replaceDir = (_: string) => _
    .split('./')
    .join(__dirname + '/')
    .split('~/')
    .join(os.homedir() + '/')

  async function tryCatch<T> (promise: Promise<T>): Promise<TryCatchResult<T>> {
    try {
      return [undefined, await promise]
    } catch (err) {
      return [err]
    }
  }

  const mkdirJobs = mkdirs.map(async (folder) => {
    const path = replaceDir(folder)

    if (await fs.exists(path)) {
      console.log(`File or Folder already exists: [${folder}]`)
      return
    }

    console.log(`Create Folder: ${folder}`)
    const [err] = await tryCatch(fs.mkdir(folder))

    if (err) {
      console.log(`Failure to create folder: ${folder}`)
      console.error(err)
    }
  })

  const symlinkJobs = symlinks.map(async (value) => {
    const from = replaceDir(value.from)
    const to = replaceDir(value.to)

    if (await fs.exists(to)) {
      console.log(`File already exists: [${to}]`)
      return
    }

    console.log(`Symbolic link: from: ${from}, to: ${to}`)
    const [err] = await tryCatch(fs.symlink(from, to))

    if (err) {
      console.log(`Failure to create symbolic link: ${to}`)
      console.error(err)
    }
  })

  await Promise.all(mkdirJobs).then(() => Promise.all(symlinkJobs))
}

// Entry Point
console.log('--------------------------------')
console.log('Starting Install...')
console.log('--------------------------------')
main().then(() => {
  console.log('--------------------------------')
  console.log('Install Success.')
  console.log('--------------------------------')
}).catch(error => {
  console.log('--------------------------------')
  console.log('Failure to install: ')
  console.error(error)
  console.log('--------------------------------')
})
