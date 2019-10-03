From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v5 03/11] mm/gup: Applies counting method to monitor
 gup_pgd_range
Date: Wed,  2 Oct 2019 22:33:17 -0300
Message-ID: <20191003013325.2614-4-leonardo@linux.ibm.com>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20191003013325.2614-1-leonardo@linux.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Allison Randal <allison@lohutok.net>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Leonardo Bras <leonardo@linux.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, Ralph Campbell <rcampbe>
List-Id: linux-arch.vger.kernel.org

As described, gup_pgd_range is a lockless pagetable walk. So, in order to
monitor against THP split/collapse with the counting method, it's necessary
to bound it with {begin,end}_lockless_pgtbl_walk.

local_irq_{save,restore} is already inside {begin,end}_lockless_pgtbl_walk,
so there is no need to repeat it here.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 mm/gup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 23a9f9c9d377..52e53b4f39d8 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2319,7 +2319,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			  struct page **pages)
 {
 	unsigned long len, end;
-	unsigned long flags;
+	unsigned long irq_mask;
 	int nr = 0;
 
 	start = untagged_addr(start) & PAGE_MASK;
@@ -2345,9 +2345,9 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
 	    gup_fast_permitted(start, end)) {
-		local_irq_save(flags);
+		irq_mask = begin_lockless_pgtbl_walk(current->mm);
 		gup_pgd_range(start, end, write ? FOLL_WRITE : 0, pages, &nr);
-		local_irq_restore(flags);
+		end_lockless_pgtbl_walk(current->mm, irq_mask);
 	}
 
 	return nr;
@@ -2414,9 +2414,9 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
 	    gup_fast_permitted(start, end)) {
-		local_irq_disable();
+		begin_lockless_pgtbl_walk(current->mm);
 		gup_pgd_range(addr, end, gup_flags, pages, &nr);
-		local_irq_enable();
+		end_lockless_pgtbl_walk(current->mm, IRQS_ENABLED);
 		ret = nr;
 	}
 
-- 
2.20.1
