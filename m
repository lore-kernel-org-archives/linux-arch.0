From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: slub: fix panic with DISCONTIGMEM
Date: Tue, 19 Apr 2011 16:29:36 -0500
Message-ID: <1303248576.11237.23.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-mm@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>
Cc: Christoph Lameter <cl@linux.com>
List-Id: linux-arch.vger.kernel.org

Slub makes assumptions about page_to_nid() which are violated by
DISCONTIGMEM and !NUMA.  This violation results in a panic because
page_to_nid() can be non-zero for pages in the discontiguous ranges and
this leads to a null return by get_node().  The assertion by the
maintainer is that DISCONTIGMEM should only be allowed when NUMA is also
defined.  However, at least six architectures: alpha, ia64, m32r, m68k,
mips, parisc violate this.  The panic is a regression against slab, so
just mark slub broken in the problem configuration to prevent users
reporting these panics.

Cc: stable@kernel.org
Signed-off-by: James Bottomley <James.Bottomley@suse.de>

---

diff --git a/init/Kconfig b/init/Kconfig
index 56240e7..a7ad8fb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1226,6 +1226,7 @@ config SLAB
 	  per cpu and per node queues.
 
 config SLUB
+	depends on BROKEN || NUMA || !DISCONTIGMEM
 	bool "SLUB (Unqueued Allocator)"
 	help
 	   SLUB is a slab allocator that minimizes cache line usage


