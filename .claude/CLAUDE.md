## figma cli

if a referenced figma design with a url like this

    https://www.figma.com/design/FILE_ID/DESIGN_NAME?node-id=NODE_ID&t=HASH

you can get a png of that node with these commands:

# export a figma node to a file
figma node export "https://www.figma.com/design/FILE_ID/DESIGN_NAME?node-id=NODE_ID&t=HASH"

# get the direct image URL for a figma node
figma node url "https://www.figma.com/design/FILE_ID/DESIGN_NAME?node-id=NODE_ID&t=HASH"
