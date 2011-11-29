From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH-RFC 1/2] tile: don't panic on iomap
Date: Tue, 29 Nov 2011 20:54:15 +0200
Message-ID: <a3bc9cb56040258dabc7b466ea217f4515b68b7d.1322592495.git.mst@redhat.com>
References: <cover.1322592494.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1322592494.git.mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Chris Metcalf <cmetcalf@tilera.com>, "Michael S. Tsirkin" <mst@redhat.com>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Paul Mundt <lethal@linux-sh.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

I think panic on iomap is there just for debugging.
If we return NULL instead, the generic pci_iomap will
DTRT so we don't need to roll our own.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/tile/include/asm/io.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/tile/include/asm/io.h b/arch/tile/include/asm/io.h
index c9ea165..be6090d 100644
--- a/arch/tile/include/asm/io.h
+++ b/arch/tile/include/asm/io.h
@@ -204,7 +204,8 @@ static inline long ioport_panic(void)
 
 static inline void __iomem *ioport_map(unsigned long port, unsigned int len)
 {
-	return (void __iomem *) ioport_panic();
+	pr_info("Trying to map an IO resource - it does not exit on tile.\n");
+	return NULL;
 }
 
 static inline void ioport_unmap(void __iomem *addr)
-- 
1.7.5.53.gc233e
