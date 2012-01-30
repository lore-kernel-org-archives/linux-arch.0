From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH] fix compile break caused by iomap: make IOPORT/PCI mapping
 functions conditional
Date: Mon, 30 Jan 2012 10:40:47 -0600
Message-ID: <1327941647.21193.53.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51788 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753744Ab2A3Qkt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 30 Jan 2012 11:40:49 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Randy Dunlap <rdunlap@xenotime.net>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, Rolf Eike Beer <eike@sf-mail.de>

The problem in

commit fea80311a939a746533a6d7e7c3183729d6a3faf
Author: Randy Dunlap <rdunlap@xenotime.net>
Date:   Sun Jul 24 11:39:14 2011 -0700

    iomap: make IOPORT/PCI mapping functions conditional


is that if your architecture supplies pci_iomap/pci_iounmap, it expects
always to supply them.  Adding empty body defitions in the !CONFIG_PCI
case, which is what this patch does, breaks the parisc compile because
the functions become doubly defined.  It took us a while to spot this,
because we don't actually build !CONFIG_PCI very often (only if someone
is brave enough to test the snake/asp machines).

Since the note in the commit log says this is to fix a
CONFIG_GENERIC_IOMAP issue (which it does because CONFIG_GENERIC_IOMAP
supplies pci_iounmap only if CONFIG_PCI is set), there should actually
have been a condition upon this.  This should make sure no other
architecture's !CONFIG_PCI compile breaks in the same way as parisc.

The fix had to be updated to take account of the GENERIC_PCI_IOMAP
separation.

Reported-by: Rolf Eike Beer <eike@sf-mail.de>
Signed-off-by: James Bottomley <JBottomley@Parallels.com>

---

diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 8a3d4fd..6afd7d6 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -70,7 +70,7 @@ extern void ioport_unmap(void __iomem *);
 /* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
 struct pci_dev;
 extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
-#else
+#elif defined(CONFIG_GENERIC_IOMAP)
 struct pci_dev;
 static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 { }
diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
index 8de4b73..217eb3d 100644
--- a/include/asm-generic/pci_iomap.h
+++ b/include/asm-generic/pci_iomap.h
@@ -15,7 +15,7 @@ struct pci_dev;
 #ifdef CONFIG_PCI
 /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
 extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
-#else
+#elif defined(CONFIG_GENERIC_PCI_IOMAP)
 static inline void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max)
 {
 	return NULL;
