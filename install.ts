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
async function main (filePath: string = './configure.yml') {
  const configure = yaml.safeLoad(await fs.readFile(filePath, 'utf8')).list as Array<{ from: string, to: string }>

  await forEachAsync(configure, async (value) => {
    await fs.symlink(value.from, value.to)
  })
}

// Entry Point
main().then(() => {
  console.log('Install Success.')
}).catch(error => {
  console.log('Failure to install: ')
  console.error(error)
})
