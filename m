From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: [PATCH v5 00/11] Introduces new count-based method for tracking
 lockless pagetable walks
Date: Wed,  2 Oct 2019 22:33:14 -0300
Message-ID: <20191003013325.2614-1-leonardo@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
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

If a process (qemu) with a lot of CPUs (128) try to munmap() a large
chunk of memory (496GB) mapped with THP, it takes an average of 275
seconds, which can cause a lot of problems to the load (in qemu case,
the guest will lock for this time).

Trying to find the source of this bug, I found out most of this time is
spent on serialize_against_pte_lookup(). This function will take a lot
of time in smp_call_function_many() if there is more than a couple CPUs
running the user process. Since it has to happen to all THP mapped, it
will take a very long time for large amounts of memory.

By the docs, serialize_against_pte_lookup() is needed in order to avoid
pmd_t to pte_t casting inside find_current_mm_pte(), or any lockless
pagetable walk, to happen concurrently with THP splitting/collapsing.

It does so by calling a do_nothing() on each CPU in mm->cpu_bitmap[],
after interrupts are re-enabled.
Since, interrupts are (usually) disabled during lockless pagetable
walk, and serialize_against_pte_lookup will only return after
interrupts are enabled, it is protected.

So, by what I could understand, if there is no lockless pagetable walk
running, there is no need to call serialize_against_pte_lookup().

So, to avoid the cost of running serialize_against_pte_lookup(), I
propose a counter that keeps track of how many find_current_mm_pte()
are currently running, and if there is none, just skip
smp_call_function_many().

The related functions are:
begin_lockless_pgtbl_walk()
        Insert before starting any lockless pgtable walk
end_lockless_pgtbl_walk()
        Insert after the end of any lockless pgtable walk
        (Mostly after the ptep is last used)
running_lockless_pgtbl_walk()
        Returns the number of lockless pgtable walks running

On my workload (qemu), I could see munmap's time reduction from 275
seconds to 418ms.

Also, I documented some lockless pagetable walks in which it's not
necessary to keep track, given they work on init_mm or guest pgd.

The patchset works by focusing all steps needed to begin/end lockless
pagetable walks on the above functions, and then adding the config option
to enable the tracking of these functions using the counting method.

Changes since v4:
 Rebased on top of v5.4-rc1
 Declared real generic functions instead of dummies
 start_lockless_pgtbl_walk renamed to begin_lockless_pgtbl_walk
 Interrupt {dis,en}able is now inside of {begin,end}_lockless_pgtbl_walk
 Power implementation has option to not {dis,en}able interrupt
 More documentation inside the funtions.
 Some irq maks variables renamed
 Removed some proxy mm_structs
 Few typos fixed

Changes since v3:
 Explain (comments) why some lockless pgtbl walks don't need
	local_irq_disable (real mode + MSR_EE=0)
 Explain (comments) places where counting method is not needed (guest pgd,
	which is not touched by THP)
 Fixes some misplaced local_irq_restore()
 Link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=132417

Changes since v2:
 Rebased to v5.3
 Adds support on __get_user_pages_fast
 Adds usage decription to *_lockless_pgtbl_walk()
 Better style to dummy functions
 Link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=131839

Changes since v1:
 Isolated atomic operations in functions *_lockless_pgtbl_walk()
 Fixed behavior of decrementing before last ptep was used
 Link: http://patchwork.ozlabs.org/patch/1163093/


Leonardo Bras (11):
  asm-generic/pgtable: Adds generic functions to monitor lockless
    pgtable walks
  powerpc/mm: Adds counting method to monitor lockless pgtable walks
  mm/gup: Applies counting method to monitor gup_pgd_range
  powerpc/mce_power: Applies counting method to monitor lockless pgtbl
    walks
  powerpc/perf: Applies counting method to monitor lockless pgtbl walks
  powerpc/mm/book3s64/hash: Applies counting method to monitor lockless
    pgtbl walks
  powerpc/kvm/e500: Applies counting method to monitor lockless pgtbl
    walks
  powerpc/kvm/book3s_hv: Applies counting method to monitor lockless
    pgtbl walks
  powerpc/kvm/book3s_64: Applies counting method to monitor lockless
    pgtbl walks
  mm/Kconfig: Adds config option to track lockless pagetable walks
  powerpc/mm/book3s64/pgtable: Uses counting method to skip serializing

 arch/powerpc/include/asm/book3s/64/pgtable.h |   9 ++
 arch/powerpc/kernel/mce_power.c              |   6 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c          |   6 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c       |  34 +++++-
 arch/powerpc/kvm/book3s_64_vio_hv.c          |   7 +-
 arch/powerpc/kvm/book3s_hv_nested.c          |  22 +++-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c          |  32 ++---
 arch/powerpc/kvm/e500_mmu_host.c             |   9 +-
 arch/powerpc/mm/book3s64/hash_tlb.c          |   6 +-
 arch/powerpc/mm/book3s64/hash_utils.c        |  27 +++--
 arch/powerpc/mm/book3s64/pgtable.c           | 120 ++++++++++++++++++-
 arch/powerpc/perf/callchain.c                |   6 +-
 include/asm-generic/pgtable.h                |  58 +++++++++
 include/linux/mm_types.h                     |  11 ++
 kernel/fork.c                                |   3 +
 mm/Kconfig                                   |  11 ++
 mm/gup.c                                     |  10 +-
 17 files changed, 325 insertions(+), 52 deletions(-)

-- 
2.20.1
