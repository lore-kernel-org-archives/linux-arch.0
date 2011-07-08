From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 33/39] UAPI: Set up UAPI Kbuild files
Date: Fri, 08 Jul 2011 15:28:17 +0100
Message-ID: <20110708142817.31344.89389.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47695 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab1GHO3C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:29:02 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Set up empty UAPI Kbuild files to be populated by the header splitter using
scripts/uapi-disintegrate/set-up-Kbuild.pl

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/alpha/include/uapi/asm/Kbuild          |    2 ++
 arch/arm/include/uapi/asm/Kbuild            |    2 ++
 arch/avr32/include/uapi/asm/Kbuild          |    2 ++
 arch/blackfin/include/uapi/asm/Kbuild       |    2 ++
 arch/cris/include/uapi/arch-v10/arch/Kbuild |    0 
 arch/cris/include/uapi/arch-v32/arch/Kbuild |    0 
 arch/cris/include/uapi/asm/Kbuild           |    4 ++++
 arch/frv/include/uapi/asm/Kbuild            |    2 ++
 arch/h8300/include/uapi/asm/Kbuild          |    2 ++
 arch/ia64/include/uapi/asm/Kbuild           |    2 ++
 arch/m32r/include/uapi/asm/Kbuild           |    2 ++
 arch/m68k/include/uapi/asm/Kbuild           |    2 ++
 arch/microblaze/include/uapi/asm/Kbuild     |    2 ++
 arch/mips/include/uapi/asm/Kbuild           |    2 ++
 arch/mn10300/include/uapi/asm/Kbuild        |    2 ++
 arch/parisc/include/uapi/asm/Kbuild         |    2 ++
 arch/powerpc/include/uapi/asm/Kbuild        |    2 ++
 arch/s390/include/uapi/asm/Kbuild           |    2 ++
 arch/score/include/uapi/asm/Kbuild          |    2 ++
 arch/sh/include/uapi/asm/Kbuild             |    2 ++
 arch/sparc/include/uapi/asm/Kbuild          |    4 ++++
 arch/tile/include/uapi/asm/Kbuild           |    2 ++
 arch/unicore32/include/uapi/asm/Kbuild      |    2 ++
 arch/x86/include/uapi/asm/Kbuild            |    2 ++
 arch/xtensa/include/uapi/asm/Kbuild         |    2 ++
 include/uapi/Kbuild                         |   13 +++++++++++++
 include/uapi/asm-generic/Kbuild             |    0 
 include/uapi/drm/Kbuild                     |    0 
 include/uapi/linux/Kbuild                   |   14 ++++++++++++++
 include/uapi/linux/byteorder/Kbuild         |    0 
 include/uapi/linux/caif/Kbuild              |    0 
 include/uapi/linux/can/Kbuild               |    0 
 include/uapi/linux/dvb/Kbuild               |    0 
 include/uapi/linux/hdlc/Kbuild              |    0 
 include/uapi/linux/isdn/Kbuild              |    0 
 include/uapi/linux/mmc/Kbuild               |    0 
 include/uapi/linux/netfilter/Kbuild         |    1 +
 include/uapi/linux/netfilter/ipset/Kbuild   |    0 
 include/uapi/linux/netfilter_arp/Kbuild     |    0 
 include/uapi/linux/netfilter_bridge/Kbuild  |    0 
 include/uapi/linux/netfilter_ipv4/Kbuild    |    0 
 include/uapi/linux/netfilter_ipv6/Kbuild    |    0 
 include/uapi/linux/nfsd/Kbuild              |    0 
 include/uapi/linux/raid/Kbuild              |    0 
 include/uapi/linux/spi/Kbuild               |    0 
 include/uapi/linux/sunrpc/Kbuild            |    0 
 include/uapi/linux/tc_act/Kbuild            |    0 
 include/uapi/linux/tc_ematch/Kbuild         |    0 
 include/uapi/linux/usb/Kbuild               |    0 
 include/uapi/linux/wimax/Kbuild             |    0 
 include/uapi/mtd/Kbuild                     |    0 
 include/uapi/rdma/Kbuild                    |    0 
 include/uapi/scsi/Kbuild                    |    1 +
 include/uapi/scsi/fc/Kbuild                 |    0 
 include/uapi/sound/Kbuild                   |    0 
 include/uapi/video/Kbuild                   |    0 
 include/uapi/xen/Kbuild                     |    0 
 57 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100644 arch/alpha/include/uapi/asm/Kbuild
 create mode 100644 arch/arm/include/uapi/asm/Kbuild
 create mode 100644 arch/avr32/include/uapi/asm/Kbuild
 create mode 100644 arch/blackfin/include/uapi/asm/Kbuild
 create mode 100644 arch/cris/include/uapi/arch-v10/arch/Kbuild
 create mode 100644 arch/cris/include/uapi/arch-v32/arch/Kbuild
 create mode 100644 arch/cris/include/uapi/asm/Kbuild
 create mode 100644 arch/frv/include/uapi/asm/Kbuild
 create mode 100644 arch/h8300/include/uapi/asm/Kbuild
 create mode 100644 arch/ia64/include/uapi/asm/Kbuild
 create mode 100644 arch/m32r/include/uapi/asm/Kbuild
 create mode 100644 arch/m68k/include/uapi/asm/Kbuild
 create mode 100644 arch/microblaze/include/uapi/asm/Kbuild
 create mode 100644 arch/mips/include/uapi/asm/Kbuild
 create mode 100644 arch/mn10300/include/uapi/asm/Kbuild
 create mode 100644 arch/parisc/include/uapi/asm/Kbuild
 create mode 100644 arch/powerpc/include/uapi/asm/Kbuild
 create mode 100644 arch/s390/include/uapi/asm/Kbuild
 create mode 100644 arch/score/include/uapi/asm/Kbuild
 create mode 100644 arch/sh/include/uapi/asm/Kbuild
 create mode 100644 arch/sparc/include/uapi/asm/Kbuild
 create mode 100644 arch/tile/include/uapi/asm/Kbuild
 create mode 100644 arch/unicore32/include/uapi/asm/Kbuild
 create mode 100644 arch/x86/include/uapi/asm/Kbuild
 create mode 100644 arch/xtensa/include/uapi/asm/Kbuild
 create mode 100644 include/uapi/Kbuild
 create mode 100644 include/uapi/asm-generic/Kbuild
 create mode 100644 include/uapi/drm/Kbuild
 create mode 100644 include/uapi/linux/Kbuild
 create mode 100644 include/uapi/linux/byteorder/Kbuild
 create mode 100644 include/uapi/linux/caif/Kbuild
 create mode 100644 include/uapi/linux/can/Kbuild
 create mode 100644 include/uapi/linux/dvb/Kbuild
 create mode 100644 include/uapi/linux/hdlc/Kbuild
 create mode 100644 include/uapi/linux/isdn/Kbuild
 create mode 100644 include/uapi/linux/mmc/Kbuild
 create mode 100644 include/uapi/linux/netfilter/Kbuild
 create mode 100644 include/uapi/linux/netfilter/ipset/Kbuild
 create mode 100644 include/uapi/linux/netfilter_arp/Kbuild
 create mode 100644 include/uapi/linux/netfilter_bridge/Kbuild
 create mode 100644 include/uapi/linux/netfilter_ipv4/Kbuild
 create mode 100644 include/uapi/linux/netfilter_ipv6/Kbuild
 create mode 100644 include/uapi/linux/nfsd/Kbuild
 create mode 100644 include/uapi/linux/raid/Kbuild
 create mode 100644 include/uapi/linux/spi/Kbuild
 create mode 100644 include/uapi/linux/sunrpc/Kbuild
 create mode 100644 include/uapi/linux/tc_act/Kbuild
 create mode 100644 include/uapi/linux/tc_ematch/Kbuild
 create mode 100644 include/uapi/linux/usb/Kbuild
 create mode 100644 include/uapi/linux/wimax/Kbuild
 create mode 100644 include/uapi/mtd/Kbuild
 create mode 100644 include/uapi/rdma/Kbuild
 create mode 100644 include/uapi/scsi/Kbuild
 create mode 100644 include/uapi/scsi/fc/Kbuild
 create mode 100644 include/uapi/sound/Kbuild
 create mode 100644 include/uapi/video/Kbuild
 create mode 100644 include/uapi/xen/Kbuild

diff --git a/arch/alpha/include/uapi/asm/Kbuild b/arch/alpha/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/alpha/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/arm/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/avr32/include/uapi/asm/Kbuild b/arch/avr32/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/avr32/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/blackfin/include/uapi/asm/Kbuild b/arch/blackfin/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/blackfin/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/cris/include/uapi/arch-v10/arch/Kbuild b/arch/cris/include/uapi/arch-v10/arch/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/arch/cris/include/uapi/arch-v32/arch/Kbuild b/arch/cris/include/uapi/arch-v32/arch/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/arch/cris/include/uapi/asm/Kbuild b/arch/cris/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..e5a54fe
--- /dev/null
+++ b/arch/cris/include/uapi/asm/Kbuild
@@ -0,0 +1,4 @@
+include include/uapi/asm-generic/Kbuild.asm
+
+header-y += arch-v10/
+header-y += arch-v32/
diff --git a/arch/frv/include/uapi/asm/Kbuild b/arch/frv/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/frv/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/h8300/include/uapi/asm/Kbuild b/arch/h8300/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/h8300/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/ia64/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/m32r/include/uapi/asm/Kbuild b/arch/m32r/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/m32r/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/microblaze/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/mips/include/uapi/asm/Kbuild b/arch/mips/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/mips/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/mn10300/include/uapi/asm/Kbuild b/arch/mn10300/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/mn10300/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/parisc/include/uapi/asm/Kbuild b/arch/parisc/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/parisc/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/score/include/uapi/asm/Kbuild b/arch/score/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/score/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/sh/include/uapi/asm/Kbuild b/arch/sh/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/sh/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/sparc/include/uapi/asm/Kbuild b/arch/sparc/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..c27001d
--- /dev/null
+++ b/arch/sparc/include/uapi/asm/Kbuild
@@ -0,0 +1,4 @@
+# User exported sparc header files
+
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/tile/include/uapi/asm/Kbuild b/arch/tile/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/tile/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/unicore32/include/uapi/asm/Kbuild b/arch/unicore32/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/unicore32/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/x86/include/uapi/asm/Kbuild b/arch/x86/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/x86/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..f44fd2e
--- /dev/null
+++ b/arch/xtensa/include/uapi/asm/Kbuild
@@ -0,0 +1,2 @@
+include include/uapi/asm-generic/Kbuild.asm
+
diff --git a/include/uapi/Kbuild b/include/uapi/Kbuild
new file mode 100644
index 0000000..796249d
--- /dev/null
+++ b/include/uapi/Kbuild
@@ -0,0 +1,13 @@
+# Top-level Makefile calls into asm-$(ARCH)
+# List only non-arch directories below
+
+
+header-y += asm-generic/
+header-y += linux/
+header-y += sound/
+header-y += mtd/
+header-y += rdma/
+header-y += video/
+header-y += drm/
+header-y += xen/
+header-y += scsi/
diff --git a/include/uapi/asm-generic/Kbuild b/include/uapi/asm-generic/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/drm/Kbuild b/include/uapi/drm/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
new file mode 100644
index 0000000..b29b895
--- /dev/null
+++ b/include/uapi/linux/Kbuild
@@ -0,0 +1,14 @@
+header-y += byteorder/
+header-y += can/
+header-y += caif/
+header-y += dvb/
+header-y += hdlc/
+header-y += isdn/
+header-y += mmc/
+header-y += nfsd/
+header-y += raid/
+header-y += spi/
+header-y += sunrpc/
+header-y += netfilter/
+header-y += usb/
+header-y += wimax/
diff --git a/include/uapi/linux/byteorder/Kbuild b/include/uapi/linux/byteorder/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/caif/Kbuild b/include/uapi/linux/caif/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/can/Kbuild b/include/uapi/linux/can/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/dvb/Kbuild b/include/uapi/linux/dvb/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/hdlc/Kbuild b/include/uapi/linux/hdlc/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/isdn/Kbuild b/include/uapi/linux/isdn/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/mmc/Kbuild b/include/uapi/linux/mmc/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/netfilter/Kbuild b/include/uapi/linux/netfilter/Kbuild
new file mode 100644
index 0000000..b332202
--- /dev/null
+++ b/include/uapi/linux/netfilter/Kbuild
@@ -0,0 +1 @@
+header-y += ipset/
diff --git a/include/uapi/linux/netfilter/ipset/Kbuild b/include/uapi/linux/netfilter/ipset/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/netfilter_arp/Kbuild b/include/uapi/linux/netfilter_arp/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/netfilter_bridge/Kbuild b/include/uapi/linux/netfilter_bridge/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/netfilter_ipv4/Kbuild b/include/uapi/linux/netfilter_ipv4/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/netfilter_ipv6/Kbuild b/include/uapi/linux/netfilter_ipv6/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/nfsd/Kbuild b/include/uapi/linux/nfsd/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/raid/Kbuild b/include/uapi/linux/raid/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/spi/Kbuild b/include/uapi/linux/spi/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/sunrpc/Kbuild b/include/uapi/linux/sunrpc/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/tc_act/Kbuild b/include/uapi/linux/tc_act/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/tc_ematch/Kbuild b/include/uapi/linux/tc_ematch/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/usb/Kbuild b/include/uapi/linux/usb/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/linux/wimax/Kbuild b/include/uapi/linux/wimax/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/mtd/Kbuild b/include/uapi/mtd/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/rdma/Kbuild b/include/uapi/rdma/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/scsi/Kbuild b/include/uapi/scsi/Kbuild
new file mode 100644
index 0000000..562ff9d
--- /dev/null
+++ b/include/uapi/scsi/Kbuild
@@ -0,0 +1 @@
+header-y += fc/
diff --git a/include/uapi/scsi/fc/Kbuild b/include/uapi/scsi/fc/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/sound/Kbuild b/include/uapi/sound/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/video/Kbuild b/include/uapi/video/Kbuild
new file mode 100644
index 0000000..e69de29
diff --git a/include/uapi/xen/Kbuild b/include/uapi/xen/Kbuild
new file mode 100644
index 0000000..e69de29
