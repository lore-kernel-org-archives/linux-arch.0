Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 8 Jul 2005 00:43:18 +0000
From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 2/2] net: move config options out to individual protocols
Message-ID: <20050708004318.GC9883@mars.ravnborg.org>
References: <20050708003831.GB9883@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708003831.GB9883@mars.ravnborg.org>
To: linux-arch@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-arch.vger.kernel.org>

Move the protocol specific config options out to the specific protocols.
With this change net/Kconfig now starts to become readable and serve as a
good basis for further re-structuring.

The menu structure is left almost intact, except that indention is
fixed in most cases. Most visible are the INET changes where several
"depends on INET" are replaced with a single ifdef INET / endif pair.

Several new files were created to accomplish this change - they are
small but serve the purpose that config options are now distributed
out where they belongs.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

This patch is equal to the one posted previously only to netdev.
It is posted again for completeness.

	Sam

 drivers/net/appletalk/Kconfig |   27 ++
 net/8021q/Kconfig             |   19 ++
 net/Kconfig                   |  446 ++---------------------------------------
 net/atm/Kconfig               |   74 +++++++
 net/bridge/Kconfig            |   31 +++
 net/decnet/Kconfig            |   23 ++
 net/econet/Kconfig            |   36 +++
 net/ipv4/Kconfig              |   25 --
 net/ipv4/ipvs/Kconfig         |    4 
 net/ipv6/Kconfig              |   22 ++
 net/ipx/Kconfig               |   33 +++
 net/lapb/Kconfig              |   22 ++
 net/packet/Kconfig            |   26 ++
 net/sched/Kconfig             |   37 +++
 net/unix/Kconfig              |   21 ++
 net/wanrouter/Kconfig         |   29 +++
 net/x25/Kconfig               |   36 +++
 net/xfrm/Kconfig              |   15 +
 18 files changed, 474 insertions(+), 452 deletions(-)

diff --git a/drivers/net/appletalk/Kconfig b/drivers/net/appletalk/Kconfig
--- a/drivers/net/appletalk/Kconfig
+++ b/drivers/net/appletalk/Kconfig
@@ -1,6 +1,33 @@
 #
 # Appletalk driver configuration
 #
+config ATALK
+	tristate "Appletalk protocol support"
+	select LLC
+	---help---
+	  AppleTalk is the protocol that Apple computers can use to communicate
+	  on a network.  If your Linux box is connected to such a network and you
+	  wish to connect to it, say Y.  You will need to use the netatalk package
+	  so that your Linux box can act as a print and file server for Macs as
+	  well as access AppleTalk printers.  Check out
+	  <http://www.zettabyte.net/netatalk/> on the WWW for details.
+	  EtherTalk is the name used for AppleTalk over Ethernet and the
+	  cheaper and slower LocalTalk is AppleTalk over a proprietary Apple
+	  network using serial links.  EtherTalk and LocalTalk are fully
+	  supported by Linux.
+
+	  General information about how to connect Linux, Windows machines and
+	  Macs is on the WWW at <http://www.eats.com/linux_mac_win.html>.  The
+	  NET-3-HOWTO, available from
+	  <http://www.tldp.org/docs.html#howto>, contains valuable
+	  information as well.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called appletalk. You almost certainly want to compile it as a
+	  module so you can restart your AppleTalk stack without rebooting
+	  your machine. I hear that the GNU boycott of Apple is over, so
+	  even politically correct people are allowed to say Y here.
+
 config DEV_APPLETALK
 	bool "Appletalk interfaces support"
 	depends on ATALK
diff --git a/net/8021q/Kconfig b/net/8021q/Kconfig
new file mode 100644
--- /dev/null
+++ b/net/8021q/Kconfig
@@ -0,0 +1,19 @@
+#
+# Configuration for 802.1Q VLAN support
+#
+
+config VLAN_8021Q
+	tristate "802.1Q VLAN Support"
+	---help---
+	  Select this and you will be able to create 802.1Q VLAN interfaces
+	  on your ethernet interfaces.  802.1Q VLAN supports almost
+	  everything a regular ethernet interface does, including
+	  firewalling, bridging, and of course IP traffic.  You will need
+	  the 'vconfig' tool from the VLAN project in order to effectively
+	  use VLANs.  See the VLAN web page for more information:
+	  <http://www.candelatech.com/~greear/vlan.html>
+
+	  To compile this code as a module, choose M here: the module
+	  will be called 8021q.
+
+	  If unsure, say N.
diff --git a/net/Kconfig b/net/Kconfig
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -22,57 +22,14 @@ config NET
 	  recommended to read the NET-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>.
 
-menu "Networking options"
-	depends on NET
-
-config PACKET
-	tristate "Packet socket"
-	---help---
-	  The Packet protocol is used by applications which communicate
-	  directly with network devices without an intermediate network
-	  protocol implemented in the kernel, e.g. tcpdump.  If you want them
-	  to work, choose Y.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called af_packet.
-
-	  If unsure, say Y.
-
-config PACKET_MMAP
-	bool "Packet socket: mmapped IO"
-	depends on PACKET
-	help
-	  If you say Y here, the Packet protocol driver will use an IO
-	  mechanism that results in faster communication.
-
-	  If unsure, say N.
+# Make sure that all config symbols are dependent on NET
+if NET
 
-config UNIX
-	tristate "Unix domain sockets"
-	---help---
-	  If you say Y here, you will include support for Unix domain sockets;
-	  sockets are the standard Unix mechanism for establishing and
-	  accessing network connections.  Many commonly used programs such as
-	  the X Window system and syslog use these sockets even if your
-	  machine is not connected to any network.  Unless you are working on
-	  an embedded system or something similar, you therefore definitely
-	  want to say Y here.
-
-	  To compile this driver as a module, choose M here: the module will be
-	  called unix.  Note that several important services won't work
-	  correctly if you say M here and then neglect to load the module.
-
-	  Say Y unless you know what you are doing.
-
-config NET_KEY
-	tristate "PF_KEY sockets"
-	select XFRM
-	---help---
-	  PF_KEYv2 socket family, compatible to KAME ones.
-	  They are required if you are going to use IPsec tools ported
-	  from KAME.
+menu "Networking options"
 
-	  Say Y unless you know what you are doing.
+source "net/packet/Kconfig"
+source "net/unix/Kconfig"
+source "net/xfrm/Kconfig"
 
 config INET
 	bool "TCP/IP networking"
@@ -96,30 +53,12 @@ config INET
 
 	  Short answer: say Y.
 
+if INET
 source "net/ipv4/Kconfig"
-
-#   IPv6 as module will cause a CRASH if you try to unload it
-config IPV6
-	tristate "The IPv6 protocol"
-	depends on INET
-	default m
-	select CRYPTO if IPV6_PRIVACY
-	select CRYPTO_MD5 if IPV6_PRIVACY
-	---help---
-	  This is complemental support for the IP version 6.
-	  You will still be able to do traditional IPv4 networking as well.
-
-	  For general information about IPv6, see
-	  <http://playground.sun.com/pub/ipng/html/ipng-main.html>.
-	  For Linux IPv6 development information, see <http://www.linux-ipv6.org>.
-	  For specific information about IPv6 under Linux, read the HOWTO at
-	  <http://www.bieringer.de/linux/IPv6/>.
-
-	  To compile this protocol support as a module, choose M here: the 
-	  module will be called ipv6.
-
 source "net/ipv6/Kconfig"
 
+endif # if INET
+
 menuconfig NETFILTER
 	bool "Network packet filtering (replaces ipchains)"
 	---help---
@@ -208,269 +147,16 @@ source "net/bridge/netfilter/Kconfig"
 
 endif
 
-config XFRM
-       bool
-       depends on NET
-
-source "net/xfrm/Kconfig"
-
 source "net/sctp/Kconfig"
-
-config ATM
-	tristate "Asynchronous Transfer Mode (ATM) (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	---help---
-	  ATM is a high-speed networking technology for Local Area Networks
-	  and Wide Area Networks.  It uses a fixed packet size and is
-	  connection oriented, allowing for the negotiation of minimum
-	  bandwidth requirements.
-
-	  In order to participate in an ATM network, your Linux box needs an
-	  ATM networking card. If you have that, say Y here and to the driver
-	  of your ATM card below.
-
-	  Note that you need a set of user-space programs to actually make use
-	  of ATM.  See the file <file:Documentation/networking/atm.txt> for
-	  further details.
-
-config ATM_CLIP
-	tristate "Classical IP over ATM (EXPERIMENTAL)"
-	depends on ATM && INET
-	help
-	  Classical IP over ATM for PVCs and SVCs, supporting InARP and
-	  ATMARP. If you want to communication with other IP hosts on your ATM
-	  network, you will typically either say Y here or to "LAN Emulation
-	  (LANE)" below.
-
-config ATM_CLIP_NO_ICMP
-	bool "Do NOT send ICMP if no neighbour (EXPERIMENTAL)"
-	depends on ATM_CLIP
-	help
-	  Normally, an "ICMP host unreachable" message is sent if a neighbour
-	  cannot be reached because there is no VC to it in the kernel's
-	  ATMARP table. This may cause problems when ATMARP table entries are
-	  briefly removed during revalidation. If you say Y here, packets to
-	  such neighbours are silently discarded instead.
-
-config ATM_LANE
-	tristate "LAN Emulation (LANE) support (EXPERIMENTAL)"
-	depends on ATM
-	help
-	  LAN Emulation emulates services of existing LANs across an ATM
-	  network. Besides operating as a normal ATM end station client, Linux
-	  LANE client can also act as an proxy client bridging packets between
-	  ELAN and Ethernet segments. You need LANE if you want to try MPOA.
-
-config ATM_MPOA
-	tristate "Multi-Protocol Over ATM (MPOA) support (EXPERIMENTAL)"
-	depends on ATM && INET && ATM_LANE!=n
-	help
-	  Multi-Protocol Over ATM allows ATM edge devices such as routers,
-	  bridges and ATM attached hosts establish direct ATM VCs across
-	  subnetwork boundaries. These shortcut connections bypass routers
-	  enhancing overall network performance.
-
-config ATM_BR2684
-	tristate "RFC1483/2684 Bridged protocols"
-	depends on ATM && INET
-	help
-	  ATM PVCs can carry ethernet PDUs according to rfc2684 (formerly 1483)
-	  This device will act like an ethernet from the kernels point of view,
-	  with the traffic being carried by ATM PVCs (currently 1 PVC/device).
-	  This is sometimes used over DSL lines.  If in doubt, say N.
-
-config ATM_BR2684_IPFILTER
-	bool "Per-VC IP filter kludge"
-	depends on ATM_BR2684
-	help
-	  This is an experimental mechanism for users who need to terminating a
-	  large number of IP-only vcc's.  Do not enable this unless you are sure
-	  you know what you are doing.
-
-config BRIDGE
-	tristate "802.1d Ethernet Bridging"
-	---help---
-	  If you say Y here, then your Linux box will be able to act as an
-	  Ethernet bridge, which means that the different Ethernet segments it
-	  is connected to will appear as one Ethernet to the participants.
-	  Several such bridges can work together to create even larger
-	  networks of Ethernets using the IEEE 802.1 spanning tree algorithm.
-	  As this is a standard, Linux bridges will cooperate properly with
-	  other third party bridge products.
-
-	  In order to use the Ethernet bridge, you'll need the bridge
-	  configuration tools; see <file:Documentation/networking/bridge.txt>
-	  for location. Please read the Bridge mini-HOWTO for more
-	  information.
-
-	  If you enable iptables support along with the bridge support then you
-	  turn your bridge into a bridging IP firewall.
-	  iptables will then see the IP packets being bridged, so you need to
-	  take this into account when setting up your firewall rules.
-	  Enabling arptables support when bridging will let arptables see
-	  bridged ARP traffic in the arptables FORWARD chain.
-
-	  To compile this code as a module, choose M here: the module
-	  will be called bridge.
-
-	  If unsure, say N.
-
-config VLAN_8021Q
-	tristate "802.1Q VLAN Support"
-	---help---
-	  Select this and you will be able to create 802.1Q VLAN interfaces
-	  on your ethernet interfaces.  802.1Q VLAN supports almost
-	  everything a regular ethernet interface does, including
-	  firewalling, bridging, and of course IP traffic.  You will need
-	  the 'vconfig' tool from the VLAN project in order to effectively
-	  use VLANs.  See the VLAN web page for more information:
-	  <http://www.candelatech.com/~greear/vlan.html>
-
-	  To compile this code as a module, choose M here: the module
-	  will be called 8021q.
-
-	  If unsure, say N.
-
-config DECNET
-	tristate "DECnet Support"
-	---help---
-	  The DECnet networking protocol was used in many products made by
-	  Digital (now Compaq).  It provides reliable stream and sequenced
-	  packet communications over which run a variety of services similar
-	  to those which run over TCP/IP.
-
-	  To find some tools to use with the kernel layer support, please
-	  look at Patrick Caulfield's web site:
-	  <http://linux-decnet.sourceforge.net/>.
-
-	  More detailed documentation is available in
-	  <file:Documentation/networking/decnet.txt>.
-
-	  Be sure to say Y to "/proc file system support" and "Sysctl support"
-	  below when using DECnet, since you will need sysctl support to aid
-	  in configuration at run time.
-
-	  The DECnet code is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module is called decnet.
-
+source "net/atm/Kconfig"
+source "net/bridge/Kconfig"
+source "net/8021q/Kconfig"
 source "net/decnet/Kconfig"
-
 source "net/llc/Kconfig"
-
-config IPX
-	tristate "The IPX protocol"
-	select LLC
-	---help---
-	  This is support for the Novell networking protocol, IPX, commonly
-	  used for local networks of Windows machines.  You need it if you
-	  want to access Novell NetWare file or print servers using the Linux
-	  Novell client ncpfs (available from
-	  <ftp://platan.vc.cvut.cz/pub/linux/ncpfs/>) or from
-	  within the Linux DOS emulator DOSEMU (read the DOSEMU-HOWTO,
-	  available from <http://www.tldp.org/docs.html#howto>).  In order
-	  to do the former, you'll also have to say Y to "NCP file system
-	  support", below.
-
-	  IPX is similar in scope to IP, while SPX, which runs on top of IPX,
-	  is similar to TCP. There is also experimental support for SPX in
-	  Linux (see "SPX networking", below).
-
-	  To turn your Linux box into a fully featured NetWare file server and
-	  IPX router, say Y here and fetch either lwared from
-	  <ftp://ibiblio.org/pub/Linux/system/network/daemons/> or
-	  mars_nwe from <ftp://www.compu-art.de/mars_nwe/>. For more
-	  information, read the IPX-HOWTO available from
-	  <http://www.tldp.org/docs.html#howto>.
-
-	  General information about how to connect Linux, Windows machines and
-	  Macs is on the WWW at <http://www.eats.com/linux_mac_win.html>.
-
-	  The IPX driver would enlarge your kernel by about 16 KB. To compile
-	  this driver as a module, choose M here: the module will be called ipx.
-	  Unless you want to integrate your Linux box with a local Novell
-	  network, say N.
-
 source "net/ipx/Kconfig"
-
-config ATALK
-	tristate "Appletalk protocol support"
-	select LLC
-	---help---
-	  AppleTalk is the protocol that Apple computers can use to communicate
-	  on a network.  If your Linux box is connected to such a network and you
-	  wish to connect to it, say Y.  You will need to use the netatalk package
-	  so that your Linux box can act as a print and file server for Macs as
-	  well as access AppleTalk printers.  Check out
-	  <http://www.zettabyte.net/netatalk/> on the WWW for details.
-	  EtherTalk is the name used for AppleTalk over Ethernet and the
-	  cheaper and slower LocalTalk is AppleTalk over a proprietary Apple
-	  network using serial links.  EtherTalk and LocalTalk are fully
-	  supported by Linux.
-
-	  General information about how to connect Linux, Windows machines and
-	  Macs is on the WWW at <http://www.eats.com/linux_mac_win.html>.  The
-	  NET-3-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>, contains valuable
-	  information as well.
-
-	  To compile this driver as a module, choose M here: the module will be
-	  called appletalk. You almost certainly want to compile it as a
-	  module so you can restart your AppleTalk stack without rebooting
-	  your machine. I hear that the GNU boycott of Apple is over, so
-	  even politically correct people are allowed to say Y here.
-
 source "drivers/net/appletalk/Kconfig"
-
-config X25
-	tristate "CCITT X.25 Packet Layer (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	---help---
-	  X.25 is a set of standardized network protocols, similar in scope to
-	  frame relay; the one physical line from your box to the X.25 network
-	  entry point can carry several logical point-to-point connections
-	  (called "virtual circuits") to other computers connected to the X.25
-	  network. Governments, banks, and other organizations tend to use it
-	  to connect to each other or to form Wide Area Networks (WANs). Many
-	  countries have public X.25 networks. X.25 consists of two
-	  protocols: the higher level Packet Layer Protocol (PLP) (say Y here
-	  if you want that) and the lower level data link layer protocol LAPB
-	  (say Y to "LAPB Data Link Driver" below if you want that).
-
-	  You can read more about X.25 at <http://www.sangoma.com/x25.htm> and
-	  <http://www.cisco.com/univercd/cc/td/doc/product/software/ios11/cbook/cx25.htm>.
-	  Information about X.25 for Linux is contained in the files
-	  <file:Documentation/networking/x25.txt> and
-	  <file:Documentation/networking/x25-iface.txt>.
-
-	  One connects to an X.25 network either with a dedicated network card
-	  using the X.21 protocol (not yet supported by Linux) or one can do
-	  X.25 over a standard telephone line using an ordinary modem (say Y
-	  to "X.25 async driver" below) or over Ethernet using an ordinary
-	  Ethernet card and the LAPB over Ethernet (say Y to "LAPB Data Link
-	  Driver" and "LAPB over Ethernet driver" below).
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called x25. If unsure, say N.
-
-config LAPB
-	tristate "LAPB Data Link Driver (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	---help---
-	  Link Access Procedure, Balanced (LAPB) is the data link layer (i.e.
-	  the lower) part of the X.25 protocol. It offers a reliable
-	  connection service to exchange data frames with one other host, and
-	  it is used to transport higher level protocols (mostly X.25 Packet
-	  Layer, the higher part of X.25, but others are possible as well).
-	  Usually, LAPB is used with specialized X.21 network cards, but Linux
-	  currently supports LAPB only over Ethernet connections. If you want
-	  to use LAPB connections over Ethernet, say Y here and to "LAPB over
-	  Ethernet driver" below. Read
-	  <file:Documentation/networking/lapb-module.txt> for technical
-	  details.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called lapb.  If unsure, say N.
+source "net/x25/Kconfig"
+source "net/lapb/Kconfig"
 
 config NET_DIVERT
 	bool "Frame Diverter (EXPERIMENTAL)"
@@ -498,107 +184,10 @@ config NET_DIVERT
 
 	  If unsure, say N.
 
-config ECONET
-	tristate "Acorn Econet/AUN protocols (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && INET
-	---help---
-	  Econet is a fairly old and slow networking protocol mainly used by
-	  Acorn computers to access file and print servers. It uses native
-	  Econet network cards. AUN is an implementation of the higher level
-	  parts of Econet that runs over ordinary Ethernet connections, on
-	  top of the UDP packet protocol, which in turn runs on top of the
-	  Internet protocol IP.
-
-	  If you say Y here, you can choose with the next two options whether
-	  to send Econet/AUN traffic over a UDP Ethernet connection or over
-	  a native Econet network card.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called econet.
-
-config ECONET_AUNUDP
-	bool "AUN over UDP"
-	depends on ECONET
-	help
-	  Say Y here if you want to send Econet/AUN traffic over a UDP
-	  connection (UDP is a packet based protocol that runs on top of the
-	  Internet protocol IP) using an ordinary Ethernet network card.
-
-config ECONET_NATIVE
-	bool "Native Econet"
-	depends on ECONET
-	help
-	  Say Y here if you have a native Econet network card installed in
-	  your computer.
-
-config WAN_ROUTER
-	tristate "WAN router"
-	depends on EXPERIMENTAL
-	---help---
-	  Wide Area Networks (WANs), such as X.25, frame relay and leased
-	  lines, are used to interconnect Local Area Networks (LANs) over vast
-	  distances with data transfer rates significantly higher than those
-	  achievable with commonly used asynchronous modem connections.
-	  Usually, a quite expensive external device called a `WAN router' is
-	  needed to connect to a WAN.
-
-	  As an alternative, WAN routing can be built into the Linux kernel.
-	  With relatively inexpensive WAN interface cards available on the
-	  market, a perfectly usable router can be built for less than half
-	  the price of an external router.  If you have one of those cards and
-	  wish to use your Linux box as a WAN router, say Y here and also to
-	  the WAN driver for your card, below.  You will then need the
-	  wan-tools package which is available from <ftp://ftp.sangoma.com/>.
-	  Read <file:Documentation/networking/wan-router.txt> for more
-	  information.
-
-	  To compile WAN routing support as a module, choose M here: the
-	  module will be called wanrouter.
-
-	  If unsure, say N.
-
-menu "QoS and/or fair queueing"
-
-config NET_SCHED
-	bool "QoS and/or fair queueing"
-	---help---
-	  When the kernel has several packets to send out over a network
-	  device, it has to decide which ones to send first, which ones to
-	  delay, and which ones to drop. This is the job of the packet
-	  scheduler, and several different algorithms for how to do this
-	  "fairly" have been proposed.
-
-	  If you say N here, you will get the standard packet scheduler, which
-	  is a FIFO (first come, first served). If you say Y here, you will be
-	  able to choose from among several alternative algorithms which can
-	  then be attached to different network devices. This is useful for
-	  example if some of your network devices are real time devices that
-	  need a certain minimum data flow rate, or if you need to limit the
-	  maximum data flow rate for traffic which matches specified criteria.
-	  This code is considered to be experimental.
-
-	  To administer these schedulers, you'll need the user-level utilities
-	  from the package iproute2+tc at <ftp://ftp.tux.org/pub/net/ip-routing/>.
-	  That package also contains some documentation; for more, check out
-	  <http://snafu.freedom.org/linux2.2/iproute-notes.html>.
-
-	  This Quality of Service (QoS) support will enable you to use
-	  Differentiated Services (diffserv) and Resource Reservation Protocol
-	  (RSVP) on your Linux router if you also say Y to "QoS support",
-	  "Packet classifier API" and to some classifiers below. Documentation
-	  and software is at <http://diffserv.sourceforge.net/>.
-
-	  If you say Y here and to "/proc file system" below, you will be able
-	  to read status information about packet schedulers from the file
-	  /proc/net/psched.
-
-	  The available schedulers are listed in the following questions; you
-	  can say Y to as many as you like. If unsure, say N now.
-
+source "net/econet/Kconfig"
+source "net/wanrouter/Kconfig"
 source "net/sched/Kconfig"
 
-endmenu
-
 menu "Network testing"
 
 config NET_PKTGEN
@@ -637,10 +226,9 @@ config NET_POLL_CONTROLLER
 	def_bool NETPOLL
 
 source "net/ax25/Kconfig"
-
 source "net/irda/Kconfig"
-
 source "net/bluetooth/Kconfig"
 
+endif   # if NET
 endmenu # Networking
 
diff --git a/net/atm/Kconfig b/net/atm/Kconfig
new file mode 100644
--- /dev/null
+++ b/net/atm/Kconfig
@@ -0,0 +1,74 @@
+#
+# Asynchronous Transfer Mode (ATM) (EXPERIMENTAL)
+#
+
+config ATM
+	tristate "Asynchronous Transfer Mode (ATM) (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	---help---
+	  ATM is a high-speed networking technology for Local Area Networks
+	  and Wide Area Networks.  It uses a fixed packet size and is
+	  connection oriented, allowing for the negotiation of minimum
+	  bandwidth requirements.
+
+	  In order to participate in an ATM network, your Linux box needs an
+	  ATM networking card. If you have that, say Y here and to the driver
+	  of your ATM card below.
+
+	  Note that you need a set of user-space programs to actually make use
+	  of ATM.  See the file <file:Documentation/networking/atm.txt> for
+	  further details.
+
+config ATM_CLIP
+	tristate "Classical IP over ATM (EXPERIMENTAL)"
+	depends on ATM && INET
+	help
+	  Classical IP over ATM for PVCs and SVCs, supporting InARP and
+	  ATMARP. If you want to communication with other IP hosts on your ATM
+	  network, you will typically either say Y here or to "LAN Emulation
+	  (LANE)" below.
+
+config ATM_CLIP_NO_ICMP
+	bool "Do NOT send ICMP if no neighbour (EXPERIMENTAL)"
+	depends on ATM_CLIP
+	help
+	  Normally, an "ICMP host unreachable" message is sent if a neighbour
+	  cannot be reached because there is no VC to it in the kernel's
+	  ATMARP table. This may cause problems when ATMARP table entries are
+	  briefly removed during revalidation. If you say Y here, packets to
+	  such neighbours are silently discarded instead.
+
+config ATM_LANE
+	tristate "LAN Emulation (LANE) support (EXPERIMENTAL)"
+	depends on ATM
+	help
+	  LAN Emulation emulates services of existing LANs across an ATM
+	  network. Besides operating as a normal ATM end station client, Linux
+	  LANE client can also act as an proxy client bridging packets between
+	  ELAN and Ethernet segments. You need LANE if you want to try MPOA.
+
+config ATM_MPOA
+	tristate "Multi-Protocol Over ATM (MPOA) support (EXPERIMENTAL)"
+	depends on ATM && INET && ATM_LANE!=n
+	help
+	  Multi-Protocol Over ATM allows ATM edge devices such as routers,
+	  bridges and ATM attached hosts establish direct ATM VCs across
+	  subnetwork boundaries. These shortcut connections bypass routers
+	  enhancing overall network performance.
+
+config ATM_BR2684
+	tristate "RFC1483/2684 Bridged protocols"
+	depends on ATM && INET
+	help
+	  ATM PVCs can carry ethernet PDUs according to rfc2684 (formerly 1483)
+	  This device will act like an ethernet from the kernels point of view,
+	  with the traffic being carried by ATM PVCs (currently 1 PVC/device).
+	  This is sometimes used over DSL lines.  If in doubt, say N.
+
+config ATM_BR2684_IPFILTER
+	bool "Per-VC IP filter kludge"
+	depends on ATM_BR2684
+	help
+	  This is an experimental mechanism for users who need to terminating a
+	  large number of IP-only vcc's.  Do not enable this unless you are sure
+	  you know what you are doing.
diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
new file mode 100644
--- /dev/null
+++ b/net/bridge/Kconfig
@@ -0,0 +1,31 @@
+#
+# 802.1d Ethernet Bridging
+#
+
+config BRIDGE
+	tristate "802.1d Ethernet Bridging"
+	---help---
+	  If you say Y here, then your Linux box will be able to act as an
+	  Ethernet bridge, which means that the different Ethernet segments it
+	  is connected to will appear as one Ethernet to the participants.
+	  Several such bridges can work together to create even larger
+	  networks of Ethernets using the IEEE 802.1 spanning tree algorithm.
+	  As this is a standard, Linux bridges will cooperate properly with
+	  other third party bridge products.
+
+	  In order to use the Ethernet bridge, you'll need the bridge
+	  configuration tools; see <file:Documentation/networking/bridge.txt>
+	  for location. Please read the Bridge mini-HOWTO for more
+	  information.
+
+	  If you enable iptables support along with the bridge support then you
+	  turn your bridge into a bridging IP firewall.
+	  iptables will then see the IP packets being bridged, so you need to
+	  take this into account when setting up your firewall rules.
+	  Enabling arptables support when bridging will let arptables see
+	  bridged ARP traffic in the arptables FORWARD chain.
+
+	  To compile this code as a module, choose M here: the module
+	  will be called bridge.
+
+	  If unsure, say N.
diff --git a/net/decnet/Kconfig b/net/decnet/Kconfig
--- a/net/decnet/Kconfig
+++ b/net/decnet/Kconfig
@@ -1,6 +1,29 @@
 #
 # DECnet configuration
 #
+config DECNET
+	tristate "DECnet Support"
+	---help---
+	  The DECnet networking protocol was used in many products made by
+	  Digital (now Compaq).  It provides reliable stream and sequenced
+	  packet communications over which run a variety of services similar
+	  to those which run over TCP/IP.
+
+	  To find some tools to use with the kernel layer support, please
+	  look at Patrick Caulfield's web site:
+	  <http://linux-decnet.sourceforge.net/>.
+
+	  More detailed documentation is available in
+	  <file:Documentation/networking/decnet.txt>.
+
+	  Be sure to say Y to "/proc file system support" and "Sysctl support"
+	  below when using DECnet, since you will need sysctl support to aid
+	  in configuration at run time.
+
+	  The DECnet code is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module is called decnet.
+
 config DECNET_ROUTER
 	bool "DECnet: router support (EXPERIMENTAL)"
 	depends on DECNET && EXPERIMENTAL
diff --git a/net/econet/Kconfig b/net/econet/Kconfig
new file mode 100644
--- /dev/null
+++ b/net/econet/Kconfig
@@ -0,0 +1,36 @@
+#
+# Acorn Econet/AUN protocols 
+#
+
+config ECONET
+	tristate "Acorn Econet/AUN protocols (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && INET
+	---help---
+	  Econet is a fairly old and slow networking protocol mainly used by
+	  Acorn computers to access file and print servers. It uses native
+	  Econet network cards. AUN is an implementation of the higher level
+	  parts of Econet that runs over ordinary Ethernet connections, on
+	  top of the UDP packet protocol, which in turn runs on top of the
+	  Internet protocol IP.
+
+	  If you say Y here, you can choose with the next two options whether
+	  to send Econet/AUN traffic over a UDP Ethernet connection or over
+	  a native Econet network card.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called econet.
+
+config ECONET_AUNUDP
+	bool "AUN over UDP"
+	depends on ECONET
+	help
+	  Say Y here if you want to send Econet/AUN traffic over a UDP
+	  connection (UDP is a packet based protocol that runs on top of the
+	  Internet protocol IP) using an ordinary Ethernet network card.
+
+config ECONET_NATIVE
+	bool "Native Econet"
+	depends on ECONET
+	help
+	  Say Y here if you have a native Econet network card installed in
+	  your computer.
diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -3,7 +3,6 @@
 #
 config IP_MULTICAST
 	bool "IP: multicasting"
-	depends on INET
 	help
 	  This is code for addressing several networked computers at once,
 	  enlarging your kernel by about 2 KB. You need multicasting if you
@@ -17,7 +16,6 @@ config IP_MULTICAST
 
 config IP_ADVANCED_ROUTER
 	bool "IP: advanced router"
-	depends on INET
 	---help---
 	  If you intend to run your Linux box mostly as a router, i.e. as a
 	  computer that forwards and redistributes network packets, say Y; you
@@ -183,7 +181,6 @@ config IP_ROUTE_VERBOSE
 
 config IP_PNP
 	bool "IP: kernel level autoconfiguration"
-	depends on INET
 	help
 	  This enables automatic configuration of IP addresses of devices and
 	  of the routing table during kernel boot, based on either information
@@ -242,7 +239,6 @@ config IP_PNP_RARP
 #   bool '    IP: ARP support' CONFIG_IP_PNP_ARP		
 config NET_IPIP
 	tristate "IP: tunneling"
-	depends on INET
 	select INET_TUNNEL
 	---help---
 	  Tunneling means encapsulating data of one protocol type within
@@ -260,7 +256,6 @@ config NET_IPIP
 
 config NET_IPGRE
 	tristate "IP: GRE tunnels over IP"
-	depends on INET
 	select XFRM
 	help
 	  Tunneling means encapsulating data of one protocol type within
@@ -319,7 +314,7 @@ config IP_PIMSM_V2
 
 config ARPD
 	bool "IP: ARP daemon support (EXPERIMENTAL)"
-	depends on INET && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	---help---
 	  Normally, the kernel maintains an internal cache which maps IP
 	  addresses to hardware addresses on the local network, so that
@@ -344,7 +339,6 @@ config ARPD
 
 config SYN_COOKIES
 	bool "IP: TCP syncookie support (disabled per default)"
-	depends on INET
 	---help---
 	  Normal TCP/IP networking is open to an attack known as "SYN
 	  flooding". This denial-of-service attack prevents legitimate remote
@@ -381,7 +375,6 @@ config SYN_COOKIES
 
 config INET_AH
 	tristate "IP: AH transformation"
-	depends on INET
 	select XFRM
 	select CRYPTO
 	select CRYPTO_HMAC
@@ -394,7 +387,6 @@ config INET_AH
 
 config INET_ESP
 	tristate "IP: ESP transformation"
-	depends on INET
 	select XFRM
 	select CRYPTO
 	select CRYPTO_HMAC
@@ -408,7 +400,6 @@ config INET_ESP
 
 config INET_IPCOMP
 	tristate "IP: IPComp transformation"
-	depends on INET
 	select XFRM
 	select INET_TUNNEL
 	select CRYPTO
@@ -421,7 +412,6 @@ config INET_IPCOMP
 
 config INET_TUNNEL
 	tristate "IP: tunnel transformation"
-	depends on INET
 	select XFRM
 	---help---
 	  Support for generic IP tunnel transformation, which is required by
@@ -431,7 +421,6 @@ config INET_TUNNEL
 
 config IP_TCPDIAG
 	tristate "IP: TCP socket monitoring interface"
-	depends on INET
 	default y
 	---help---
 	  Support for TCP socket monitoring interface used by native Linux
@@ -447,7 +436,6 @@ config IP_TCPDIAG_IPV6
 
 config TCP_CONG_ADVANCED
 	bool "TCP: advanced congestion control"
-	depends on INET
 	---help---
 	  Support for selection of various TCP congestion control
 	  modules.
@@ -463,7 +451,6 @@ menu "TCP congestion control"
 
 config TCP_CONG_BIC
 	tristate "Binary Increase Congestion (BIC) control"
-	depends on INET
 	default y
 	---help---
 	BIC-TCP is a sender-side only change that ensures a linear RTT
@@ -478,7 +465,6 @@ config TCP_CONG_BIC
 
 config TCP_CONG_WESTWOOD
 	tristate "TCP Westwood+"
-	depends on INET
 	default m
 	---help---
 	TCP Westwood+ is a sender-side only modification of the TCP Reno
@@ -493,7 +479,6 @@ config TCP_CONG_WESTWOOD
 
 config TCP_CONG_HTCP
         tristate "H-TCP"
-	depends on INET
         default m
 	---help---
 	H-TCP is a send-side only modifications of the TCP Reno
@@ -505,7 +490,7 @@ config TCP_CONG_HTCP
 
 config TCP_CONG_HSTCP
 	tristate "High Speed TCP"
-	depends on INET && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	default n
 	---help---
 	Sally Floyd's High Speed TCP (RFC 3649) congestion control.
@@ -516,7 +501,7 @@ config TCP_CONG_HSTCP
 
 config TCP_CONG_HYBLA
 	tristate "TCP-Hybla congestion control algorithm"
-	depends on INET && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	default n
 	---help---
 	TCP-Hybla is a sender-side only change that eliminates penalization of
@@ -526,7 +511,7 @@ config TCP_CONG_HYBLA
 
 config TCP_CONG_VEGAS
 	tristate "TCP Vegas"
-	depends on INET && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	default n
 	---help---
 	TCP Vegas is a sender-side only change to TCP that anticipates
@@ -537,7 +522,7 @@ config TCP_CONG_VEGAS
 
 config TCP_CONG_SCALABLE
 	tristate "Scalable TCP"
-	depends on INET && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	default n
 	---help---
 	Scalable TCP is a sender-side only change to TCP which uses a
diff --git a/net/ipv4/ipvs/Kconfig b/net/ipv4/ipvs/Kconfig
--- a/net/ipv4/ipvs/Kconfig
+++ b/net/ipv4/ipvs/Kconfig
@@ -2,11 +2,11 @@
 # IP Virtual Server configuration
 #
 menu	"IP: Virtual Server Configuration"
-	depends on INET && NETFILTER
+	depends on NETFILTER
 
 config	IP_VS
 	tristate "IP virtual server support (EXPERIMENTAL)"
-	depends on INET && NETFILTER
+	depends on NETFILTER
 	---help---
 	  IP Virtual Server support will let you build a high-performance
 	  virtual server based on cluster of two or more real servers. This
diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -1,6 +1,26 @@
 #
 # IPv6 configuration
-# 
+#
+
+#   IPv6 as module will cause a CRASH if you try to unload it
+config IPV6
+	tristate "The IPv6 protocol"
+	default m
+	select CRYPTO if IPV6_PRIVACY
+	select CRYPTO_MD5 if IPV6_PRIVACY
+	---help---
+	  This is complemental support for the IP version 6.
+	  You will still be able to do traditional IPv4 networking as well.
+
+	  For general information about IPv6, see
+	  <http://playground.sun.com/pub/ipng/html/ipng-main.html>.
+	  For Linux IPv6 development information, see <http://www.linux-ipv6.org>.
+	  For specific information about IPv6 under Linux, read the HOWTO at
+	  <http://www.bieringer.de/linux/IPv6/>.
+
+	  To compile this protocol support as a module, choose M here: the 
+	  module will be called ipv6.
+
 config IPV6_PRIVACY
 	bool "IPv6: Privacy Extensions (RFC 3041) support"
 	depends on IPV6
diff --git a/net/ipx/Kconfig b/net/ipx/Kconfig
--- a/net/ipx/Kconfig
+++ b/net/ipx/Kconfig
@@ -1,6 +1,39 @@
 #
 # IPX configuration
 #
+config IPX
+	tristate "The IPX protocol"
+	select LLC
+	---help---
+	  This is support for the Novell networking protocol, IPX, commonly
+	  used for local networks of Windows machines.  You need it if you
+	  want to access Novell NetWare file or print servers using the Linux
+	  Novell client ncpfs (available from
+	  <ftp://platan.vc.cvut.cz/pub/linux/ncpfs/>) or from
+	  within the Linux DOS emulator DOSEMU (read the DOSEMU-HOWTO,
+	  available from <http://www.tldp.org/docs.html#howto>).  In order
+	  to do the former, you'll also have to say Y to "NCP file system
+	  support", below.
+
+	  IPX is similar in scope to IP, while SPX, which runs on top of IPX,
+	  is similar to TCP. There is also experimental support for SPX in
+	  Linux (see "SPX networking", below).
+
+	  To turn your Linux box into a fully featured NetWare file server and
+	  IPX router, say Y here and fetch either lwared from
+	  <ftp://ibiblio.org/pub/Linux/system/network/daemons/> or
+	  mars_nwe from <ftp://www.compu-art.de/mars_nwe/>. For more
+	  information, read the IPX-HOWTO available from
+	  <http://www.tldp.org/docs.html#howto>.
+
+	  General information about how to connect Linux, Windows machines and
+	  Macs is on the WWW at <http://www.eats.com/linux_mac_win.html>.
+
+	  The IPX driver would enlarge your kernel by about 16 KB. To compile
+	  this driver as a module, choose M here: the module will be called ipx.
+	  Unless you want to integrate your Linux box with a local Novell
+	  network, say N.
+
 config IPX_INTERN
 	bool "IPX: Full internal IPX network"
 	depends on IPX
diff --git a/net/lapb/Kconfig b/net/lapb/Kconfig
new file mode 100644
--- /dev/null
+++ b/net/lapb/Kconfig
@@ -0,0 +1,22 @@
+#
+# LAPB Data Link Drive
+#
+
+config LAPB
+	tristate "LAPB Data Link Driver (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	---help---
+	  Link Access Procedure, Balanced (LAPB) is the data link layer (i.e.
+	  the lower) part of the X.25 protocol. It offers a reliable
+	  connection service to exchange data frames with one other host, and
+	  it is used to transport higher level protocols (mostly X.25 Packet
+	  Layer, the higher part of X.25, but others are possible as well).
+	  Usually, LAPB is used with specialized X.21 network cards, but Linux
+	  currently supports LAPB only over Ethernet connections. If you want
+	  to use LAPB connections over Ethernet, say Y here and to "LAPB over
+	  Ethernet driver" below. Read
+	  <file:Documentation/networking/lapb-module.txt> for technical
+	  details.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called lapb.  If unsure, say N.
diff --git a/net/packet/Kconfig b/net/packet/Kconfig
new file mode 100644
--- /dev/null
+++ b/net/packet/Kconfig
@@ -0,0 +1,26 @@
+#
+# Packet configuration
+#
+
+config PACKET
+	tristate "Packet socket"
+	---help---
+	  The Packet protocol is used by applications which communicate
+	  directly with network devices without an intermediate network
+	  protocol implemented in the kernel, e.g. tcpdump.  If you want them
+	  to work, choose Y.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called af_packet.
+
+	  If unsure, say Y.
+
+config PACKET_MMAP
+	bool "Packet socket: mmapped IO"
+	depends on PACKET
+	help
+	  If you say Y here, the Packet protocol driver will use an IO
+	  mechanism that results in faster communication.
+
+	  If unsure, say N.
+
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -1,6 +1,43 @@
 #
 # Traffic control configuration.
 # 
+
+menuconfig NET_SCHED
+	bool "QoS and/or fair queueing"
+	---help---
+	  When the kernel has several packets to send out over a network
+	  device, it has to decide which ones to send first, which ones to
+	  delay, and which ones to drop. This is the job of the packet
+	  scheduler, and several different algorithms for how to do this
+	  "fairly" have been proposed.
+
+	  If you say N here, you will get the standard packet scheduler, which
+	  is a FIFO (first come, first served). If you say Y here, you will be
+	  able to choose from among several alternative algorithms which can
+	  then be attached to different network devices. This is useful for
+	  example if some of your network devices are real time devices that
+	  need a certain minimum data flow rate, or if you need to limit the
+	  maximum data flow rate for traffic which matches specified criteria.
+	  This code is considered to be experimental.
+
+	  To administer these schedulers, you'll need the user-level utilities
+	  from the package iproute2+tc at <ftp://ftp.tux.org/pub/net/ip-routing/>.
+	  That package also contains some documentation; for more, check out
+	  <http://snafu.freedom.org/linux2.2/iproute-notes.html>.
+
+	  This Quality of Service (QoS) support will enable you to use
+	  Differentiated Services (diffserv) and Resource Reservation Protocol
+	  (RSVP) on your Linux router if you also say Y to "QoS support",
+	  "Packet classifier API" and to some classifiers below. Documentation
+	  and software is at <http://diffserv.sourceforge.net/>.
+
+	  If you say Y here and to "/proc file system" below, you will be able
+	  to read status information about packet schedulers from the file
+	  /proc/net/psched.
+
+	  The available schedulers are listed in the following questions; you
+	  can say Y to as many as you like. If unsure, say N now.
+
 choice
 	prompt "Packet scheduler clock source"
 	depends on NET_SCHED
diff --git a/net/unix/Kconfig b/net/unix/Kconfig
new file mode 100644
--- /dev/null
+++ b/net/unix/Kconfig
@@ -0,0 +1,21 @@
+#
+# Unix Domain Sockets
+#
+
+config UNIX
+	tristate "Unix domain sockets"
+	---help---
+	  If you say Y here, you will include support for Unix domain sockets;
+	  sockets are the standard Unix mechanism for establishing and
+	  accessing network connections.  Many commonly used programs such as
+	  the X Window system and syslog use these sockets even if your
+	  machine is not connected to any network.  Unless you are working on
+	  an embedded system or something similar, you therefore definitely
+	  want to say Y here.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called unix.  Note that several important services won't work
+	  correctly if you say M here and then neglect to load the module.
+
+	  Say Y unless you know what you are doing.
+
diff --git a/net/wanrouter/Kconfig b/net/wanrouter/Kconfig
new file mode 100644
--- /dev/null
+++ b/net/wanrouter/Kconfig
@@ -0,0 +1,29 @@
+#
+# Configuration for WAN router
+#
+
+config WAN_ROUTER
+	tristate "WAN router"
+	depends on EXPERIMENTAL
+	---help---
+	  Wide Area Networks (WANs), such as X.25, frame relay and leased
+	  lines, are used to interconnect Local Area Networks (LANs) over vast
+	  distances with data transfer rates significantly higher than those
+	  achievable with commonly used asynchronous modem connections.
+	  Usually, a quite expensive external device called a `WAN router' is
+	  needed to connect to a WAN.
+
+	  As an alternative, WAN routing can be built into the Linux kernel.
+	  With relatively inexpensive WAN interface cards available on the
+	  market, a perfectly usable router can be built for less than half
+	  the price of an external router.  If you have one of those cards and
+	  wish to use your Linux box as a WAN router, say Y here and also to
+	  the WAN driver for your card, below.  You will then need the
+	  wan-tools package which is available from <ftp://ftp.sangoma.com/>.
+	  Read <file:Documentation/networking/wan-router.txt> for more
+	  information.
+
+	  To compile WAN routing support as a module, choose M here: the
+	  module will be called wanrouter.
+
+	  If unsure, say N.
diff --git a/net/x25/Kconfig b/net/x25/Kconfig
new file mode 100644
--- /dev/null
+++ b/net/x25/Kconfig
@@ -0,0 +1,36 @@
+#
+# CCITT X.25 Packet Layer
+#
+
+config X25
+	tristate "CCITT X.25 Packet Layer (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	---help---
+	  X.25 is a set of standardized network protocols, similar in scope to
+	  frame relay; the one physical line from your box to the X.25 network
+	  entry point can carry several logical point-to-point connections
+	  (called "virtual circuits") to other computers connected to the X.25
+	  network. Governments, banks, and other organizations tend to use it
+	  to connect to each other or to form Wide Area Networks (WANs). Many
+	  countries have public X.25 networks. X.25 consists of two
+	  protocols: the higher level Packet Layer Protocol (PLP) (say Y here
+	  if you want that) and the lower level data link layer protocol LAPB
+	  (say Y to "LAPB Data Link Driver" below if you want that).
+
+	  You can read more about X.25 at <http://www.sangoma.com/x25.htm> and
+	  <http://www.cisco.com/univercd/cc/td/doc/product/software/ios11/cbook/cx25.htm>.
+	  Information about X.25 for Linux is contained in the files
+	  <file:Documentation/networking/x25.txt> and
+	  <file:Documentation/networking/x25-iface.txt>.
+
+	  One connects to an X.25 network either with a dedicated network card
+	  using the X.21 protocol (not yet supported by Linux) or one can do
+	  X.25 over a standard telephone line using an ordinary modem (say Y
+	  to "X.25 async driver" below) or over Ethernet using an ordinary
+	  Ethernet card and the LAPB over Ethernet (say Y to "LAPB Data Link
+	  Driver" and "LAPB over Ethernet driver" below).
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called x25. If unsure, say N.
+
+
diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
--- a/net/xfrm/Kconfig
+++ b/net/xfrm/Kconfig
@@ -1,6 +1,10 @@
 #
 # XFRM configuration
 #
+config XFRM
+       bool
+       depends on NET
+
 config XFRM_USER
 	tristate "IPsec user configuration interface"
 	depends on INET && XFRM
@@ -10,3 +14,14 @@ config XFRM_USER
 
 	  If unsure, say Y.
 
+config NET_KEY
+	tristate "PF_KEY sockets"
+	select XFRM
+	---help---
+	  PF_KEYv2 socket family, compatible to KAME ones.
+	  They are required if you are going to use IPsec tools ported
+	  from KAME.
+
+	  Say Y unless you know what you are doing.
+
+
