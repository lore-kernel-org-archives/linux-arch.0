From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: [PATCH v1 05/15] mips: kmap_coherent relies on disabled preemption
Date: Mon, 11 May 2015 17:52:10 +0200
Message-ID: <1431359540-32227-6-git-send-email-dahi@linux.vnet.ibm.com>
References: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, peterz@infradead.org, dahi@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

k(un)map_coherent relies on pagefault_disable() to also disable
preemption.

Let's make this explicit, to prepare for pagefault_disable() not
touching preemption anymore.

This patch is based on a patch by Yang Shi on the -rt tree:
"k{un}map_coherent are just called when cpu_has_dc_aliases == 1 with VIPT
cache. However, actually, the most modern MIPS processors have PIPT dcache
without dcache alias issue. In such case, k{un}map_atomic will be called
with preempt enabled."

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 arch/mips/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index faa5c98..198a314 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -90,6 +90,7 @@ static void *__kmap_pgprot(struct page *page, unsigned long addr, pgprot_t prot)
 
 	BUG_ON(Page_dcache_dirty(page));
 
+	preempt_disable();
 	pagefault_disable();
 	idx = (addr >> PAGE_SHIFT) & (FIX_N_COLOURS - 1);
 	idx += in_interrupt() ? FIX_N_COLOURS : 0;
@@ -152,6 +153,7 @@ void kunmap_coherent(void)
 	write_c0_entryhi(old_ctx);
 	local_irq_restore(flags);
 	pagefault_enable();
+	preempt_enable();
 }
 
 void copy_user_highpage(struct page *to, struct page *from,
-- 
2.1.4

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
