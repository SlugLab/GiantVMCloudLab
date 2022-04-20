"""###Ubuntu 20.04 image (will be customized) to use with GiantVM
See https://github.com/GiantVM/giantvm.github.io for more details on the GiantVM project

Instructions:
[Add additional details to configure and run GiantVM in the future]"""

#
# NOTE: This code was machine converted. An actual human would not
#       write code like this!
#

# Import the Portal object.
import geni.portal as portal
# Import the ProtoGENI library.
import geni.rspec.pg as pg
# Import the Emulab specific extensions.
import geni.rspec.emulab as emulab

# Create a portal object,
pc = portal.Context()

# Create a Request object to start building the RSpec.
request = pc.makeRequestRSpec()

# Node node-0
node_0 = request.RawPC('node-0')
node_1 = request.RawPC('node-1')
node1.hardware_type = "m510"
node2.hardware_type = "m510"
#node_0.hardware_type = 'c4130'  It's important that we're in the wisc datacenter, but otherwise we can use any available host I think?
node_0.disk_image = 'urn:publicid:IDN+wisc.cloudlab.us+image+DVM-PG0:GiantVM-Single-Node'
node_1.disk_image = 'urn:publicid:IDN+wisc.cloudlab.us+image+DVM-PG0:GiantVM-Single-Node'

node_0.addService(pg.Execute(shell="sh", command="/local/repository/scripts/setup_privkey.sh"))
node_0.addService(pg.Execute(shell="sh", command="/local/repository/scripts/setup_localdisk.sh"))
node_0.addService(pg.Execute(shell="sh", command="/local/repository/scripts/setup_giantvm.sh"))

node_1.addService(pg.Execute(shell="sh", command="/local/repository/scripts/setup_privkey.sh"))
node_1.addService(pg.Execute(shell="sh", command="/local/repository/scripts/setup_localdisk.sh"))
node_1.addService(pg.Execute(shell="sh", command="/local/repository/scripts/setup_giantvm.sh"))

# Create a link between them
link1 = request.Link(members = [node_0,node_1])

# Print the generated rspec
pc.printRequestRSpec(request)
