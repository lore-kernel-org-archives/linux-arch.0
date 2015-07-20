From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 03/10] mm: Fix bugs in region_is_ram()
Date: Sun, 19 Jul 2015 20:17:49 -0400
Message-ID: <20150720001749.30857.97562.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
Cc: linux-arch@vger.kernel.org, tony.luck@intel.com, linux@arm.linux.org.uk, arnd@arndb.de, benh@kernel.crashing.org, mcgrof@suse.com, x86@kernel.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, Mike Travis <travis@sgi.com>, geert@linux-m68k.org, ross.zwisler@linux.intel.com, toshi.kani@hp.com, Andrew Morton <akpm@linux-foundation.org>, hch@lst.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

From: Toshi Kani <toshi.kani@hp.com>

region_is_ram() looks up the iomem_resource table to check if
a target range is in RAM.  However, it always returns with -1
due to invalid range checks.  It always breaks the loop at the
first entry of the table.

Another issue is that it compares p->flags and flags, but it
always fails.  The flags is declared as int, which makes it as
a negative value with IORESOURCE_BUSY (0x80000000) set while
p->flags is unsigned long.

Fix the range check and flags so that region_is_ram() works as
advertised.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
Cc: Mike Travis <travis@sgi.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/resource.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 90552aab5f2d..fed052a1bc9f 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -504,13 +504,13 @@ int region_is_ram(resource_size_t start, unsigned long size)
 {
 	struct resource *p;
 	resource_size_t end = start + size - 1;
-	int flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 	const char *name = "System RAM";
 	int ret = -1;
 
 	read_lock(&resource_lock);
 	for (p = iomem_resource.child; p ; p = p->sibling) {
-		if (end < p->start)
+		if (p->end < start)
 			continue;
 
 		if (p->start <= start && end <= p->end) {
@@ -521,7 +521,7 @@ int region_is_ram(resource_size_t start, unsigned long size)
 				ret = 1;
 			break;
 		}
-		if (p->end < start)
+		if (end < p->start)
 			break;	/* not found */
 	}
 	read_unlock(&resource_lock);
