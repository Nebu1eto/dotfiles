import * as os from 'os'
import * as fs from 'mz/fs'
import * as yaml from 'js-yaml'

type OptionalNumber = number | undefined
type OptionalArray<T> = Array<T> | undefined

/**
 * Asynchronous ForEach Loop
 *
 * @param array     array to iterate
 * @param callback  callback function
 */
async function forEachAsync<T> (array: Array<T>, callback: (T, OptionalNumber, OptionalArray) => void) {
  for (let index = 0; index < array.length; index++) {
    await callback(array[index], index, array)
  }
}

/**
 * Linking Symlinks for Installation
 *
 * @param filePath declare configure yaml's path
 */
async function main (filePath: string = './configuration.yml') {
  const configure = yaml.safeLoad(await fs.readFile(filePath, 'utf8')).list as Array<{ from: string, to: string }>

  await forEachAsync(configure, async (value) => {
    const replaceDir = origin => origin
        .split('./')
        .join(__dirname + '/')
        .split('~/')
        .join(os.homedir() + '/')

    const from = replaceDir(value.from)
    const to = replaceDir(value.to)

    if (await fs.exists(to)) {
      throw new Error(`File already exists: [${to}]`)
    }

    console.log(`Symbolic link: from: ${from}, to: ${to}`)
    await fs.symlink(from, to)
  })
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
