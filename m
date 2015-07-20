From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 01/10] mm, x86: Fix warning in ioremap RAM check
Date: Sun, 19 Jul 2015 20:17:38 -0400
Message-ID: <20150720001738.30857.72850.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
Cc: linux-arch@vger.kernel.org, tony.luck@intel.com, toshi.kani@hp.com, arnd@arndb.de, benh@kernel.crashing.org, mcgrof@suse.com, x86@kernel.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, geert@linux-m68k.org, Roland Dreier <roland@purestorage.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, linux@arm.linux.org.uk, ross.zwisler@linux.intel.com, kbuild test robot <fengguang.wu@intel.com>, hch@lst.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

From: Toshi Kani <toshi.kani@hp.com>

__ioremap_caller() calls __ioremap_check_ram() through
walk_system_ram_range() to check if a target range is in RAM.
__ioremap_check_ram() has WARN_ONCE() in a wrong place where it warns
when the given range is not RAM.  This misplaced warning is not exposed
since walk_system_ram_range() only calls __ioremap_check_ram() for RAM
ranges.

Move the WARN_ONCE() to __ioremap_caller(), fix up __ioremap_caller to
use the %pa format specifier, and update the message to include the
address range.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
Cc: Roland Dreier <roland@purestorage.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
[djbw: fix format specifier warnings]
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/ioremap.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index cc5ccc415cc0..63da79114fe9 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -63,8 +63,6 @@ static int __ioremap_check_ram(unsigned long start_pfn, unsigned long nr_pages,
 		    !PageReserved(pfn_to_page(start_pfn + i)))
 			return 1;
 
-	WARN_ONCE(1, "ioremap on RAM pfn 0x%lx\n", start_pfn);
-
 	return 0;
 }
 
@@ -102,8 +100,8 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 		return NULL;
 
 	if (!phys_addr_valid(phys_addr)) {
-		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
-		       (unsigned long long)phys_addr);
+		printk(KERN_WARNING "ioremap: invalid physical address %pa\n",
+				&phys_addr);
 		WARN_ON_ONCE(1);
 		return NULL;
 	}
@@ -131,8 +129,11 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 		pfn      = phys_addr >> PAGE_SHIFT;
 		last_pfn = last_addr >> PAGE_SHIFT;
 		if (walk_system_ram_range(pfn, last_pfn - pfn + 1, NULL,
-					  __ioremap_check_ram) == 1)
+					  __ioremap_check_ram) == 1) {
+			WARN_ONCE(1, "ioremap on RAM at %pa - %pa\n",
+					&phys_addr, &last_addr);
 			return NULL;
+		}
 	}
 	/*
 	 * Mappings have to be page-aligned
@@ -151,10 +152,8 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 	if (pcm != new_pcm) {
 		if (!is_new_memtype_allowed(phys_addr, size, pcm, new_pcm)) {
 			printk(KERN_ERR
-		"ioremap error for 0x%llx-0x%llx, requested 0x%x, got 0x%x\n",
-				(unsigned long long)phys_addr,
-				(unsigned long long)(phys_addr + size),
-				pcm, new_pcm);
+		"ioremap error for %pa - %pa, requested 0x%x, got 0x%x\n",
+				&phys_addr, &last_addr, pcm, new_pcm);
 			goto err_free_memtype;
 		}
 		pcm = new_pcm;
