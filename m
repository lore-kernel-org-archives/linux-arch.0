From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH-RFC 09/10] sh: switch to GENERIC_PCI_IOMAP
Date: Thu, 24 Nov 2011 22:20:37 +0200
Message-ID: <28d52b292971f1bc6dab66ad6f27a0dbce35a9c0.1322163031.git.mst@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <cover.1322163031.git.mst@redhat.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Jonas Bonn <jonas@southpole.se>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Chen Liqin <liqin.chen@sunplusct.com>, Lennox Wu <lennox.wu@gmail.com>
List-Id: linux-arch.vger.kernel.org

sh copied pci_iomap from generic code, probably to avoid
pulling the rest of iomap.c in.  Since that's in
a separate file now, we can reuse the common implementation.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/sh/Kconfig           |    1 +
 arch/sh/drivers/pci/pci.c |   23 -----------------------
 2 files changed, 1 insertions(+), 23 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5aeab58..ead1640 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -857,6 +857,7 @@ config PCI
 	bool "PCI support"
 	depends on SYS_SUPPORTS_PCI
 	select PCI_DOMAINS
+	select GENERIC_PCI_IOMAP
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index c2691af..11aaf2f 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -393,29 +393,6 @@ static void __iomem *ioport_map_pci(struct pci_dev *dev,
 	return (void __iomem *)(chan->io_map_base + port);
 }
 
-void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
-{
-	resource_size_t start = pci_resource_start(dev, bar);
-	resource_size_t len = pci_resource_len(dev, bar);
-	unsigned long flags = pci_resource_flags(dev, bar);
-
-	if (unlikely(!len || !start))
-		return NULL;
-	if (maxlen && len > maxlen)
-		len = maxlen;
-
-	if (flags & IORESOURCE_IO)
-		return ioport_map_pci(dev, start, len);
-	if (flags & IORESOURCE_MEM) {
-		if (flags & IORESOURCE_CACHEABLE)
-			return ioremap(start, len);
-		return ioremap_nocache(start, len);
-	}
-
-	return NULL;
-}
-EXPORT_SYMBOL(pci_iomap);
-
 void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 {
 	iounmap(addr);
-- 
1.7.5.53.gc233e
