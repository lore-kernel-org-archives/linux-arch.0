From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v5 04/11] powerpc/mce_power: Applies counting method to
 monitor lockless pgtbl walks
Date: Wed,  2 Oct 2019 22:33:18 -0300
Message-ID: <20191003013325.2614-5-leonardo@linux.ibm.com>
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

Applies the counting-based method for monitoring lockless pgtable walks on
addr_to_pfn().

local_irq_{save,restore} is already inside {begin,end}_lockless_pgtbl_walk,
so there is no need to repeat it here.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/kernel/mce_power.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 1cbf7f1a4e3d..7f888fb6f65c 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -29,7 +29,7 @@ unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
 {
 	pte_t *ptep;
 	unsigned int shift;
-	unsigned long pfn, flags;
+	unsigned long pfn, irq_mask;
 	struct mm_struct *mm;
 
 	if (user_mode(regs))
@@ -37,7 +37,7 @@ unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
 	else
 		mm = &init_mm;
 
-	local_irq_save(flags);
+	irq_mask = begin_lockless_pgtbl_walk(mm);
 	ptep = __find_linux_pte(mm->pgd, addr, NULL, &shift);
 
 	if (!ptep || pte_special(*ptep)) {
@@ -53,7 +53,7 @@ unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
 	}
 
 out:
-	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(mm, irq_mask);
 	return pfn;
 }
 
-- 
2.20.1
