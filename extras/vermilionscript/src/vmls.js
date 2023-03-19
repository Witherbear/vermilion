const fs = require('fs');
const peg = require('pegjs');

const grammar = fs.readFileSync('./src/Vermilion.pegjs', 'utf8');
const parser = peg.generate(grammar);

const args = process.argv.slice(2);

if (args.length === 0) {
  console.log('Usage: vmls <input-file>');
  process.exit(1);
}

const inputPath = args[0];

try {
  const input = fs.readFileSync(inputPath, 'utf8');
  const output = parser.parse(input);
  const outputPath = inputPath.replace(/\.vmls$/, '.js');
  fs.writeFileSync(outputPath, output, 'utf8');
  console.log(`Compiled ${inputPath} to ${outputPath}`);
} catch (err) {
  console.error(`Error compiling ${inputPath}: ${err.message}`);
  process.exit(1);
}
