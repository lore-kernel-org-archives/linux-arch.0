From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v6 02/11] mm/gup: Use functions to track lockless pgtbl walks on gup_pgd_range
Date: Thu,  6 Feb 2020 00:08:51 -0300
Message-ID: <20200206030900.147032-3-leonardo@linux.ibm.com>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200206030900.147032-1-leonardo@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Leonardo Bras <leonardo@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@su>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

As described, gup_pgd_range is a lockless pagetable walk. So, in order to
track against THP split/collapse, it disables/enables irq around it.

To make use of the new tracking functions, it replaces irq disable/enable
by {begin,end}_lockless_pgtbl_walk().

As local_irq_{save,restore} is present inside
{begin,end}_lockless_pgtbl_walk, there should be no change in the
workings.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 mm/gup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1b521e0ac1de..04e6f46993b6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2369,7 +2369,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			  struct page **pages)
 {
 	unsigned long len, end;
-	unsigned long flags;
+	unsigned long irq_mask;
 	int nr = 0;
 
 	start = untagged_addr(start) & PAGE_MASK;
@@ -2395,9 +2395,9 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
 	    gup_fast_permitted(start, end)) {
-		local_irq_save(flags);
+		irq_mask = begin_lockless_pgtbl_walk();
 		gup_pgd_range(start, end, write ? FOLL_WRITE : 0, pages, &nr);
-		local_irq_restore(flags);
+		end_lockless_pgtbl_walk(irq_mask);
 	}
 
 	return nr;
@@ -2450,9 +2450,9 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
 
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
 	    gup_fast_permitted(start, end)) {
-		local_irq_disable();
+		begin_lockless_pgtbl_walk();
 		gup_pgd_range(addr, end, gup_flags, pages, &nr);
-		local_irq_enable();
+		end_lockless_pgtbl_walk(IRQS_ENABLED);
 		ret = nr;
 	}
 
-- 
2.24.1
