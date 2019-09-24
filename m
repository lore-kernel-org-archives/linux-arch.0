From: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 00/11] Introduces new count-based method for monitoring
 lockless pagetable walks
Date: Tue, 24 Sep 2019 15:58:51 -0700
Message-ID: <8635e9b3-45a3-803f-5c91-a7aa4c4e7ce3@nvidia.com>
References: <20190924212427.7734-1-leonardo@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20190924212427.7734-1-leonardo@linux.ibm.com>
Content-Language: en-US
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
To: Leonardo Bras <leonardo@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Keith Busch <keith.busch@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, YueHaibing <yuehaibing@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Paul Mackerras <paulus@samba.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Allison Randal <allison@lohutok.net>
List-Id: linux-arch.vger.kernel.org

On 9/24/19 2:24 PM, Leonardo Bras wrote:
> If a process (qemu) with a lot of CPUs (128) try to munmap() a large
> chunk of memory (496GB) mapped with THP, it takes an average of 275
> seconds, which can cause a lot of problems to the load (in qemu case,
> the guest will lock for this time).
> 
> Trying to find the source of this bug, I found out most of this time is
> spent on serialize_against_pte_lookup(). This function will take a lot
> of time in smp_call_function_many() if there is more than a couple CPUs
> running the user process. Since it has to happen to all THP mapped, it
> will take a very long time for large amounts of memory.
> 
> By the docs, serialize_against_pte_lookup() is needed in order to avoid
> pmd_t to pte_t casting inside find_current_mm_pte(), or any lockless
> pagetable walk, to happen concurrently with THP splitting/collapsing.
> 
> It does so by calling a do_nothing() on each CPU in mm->cpu_bitmap[],
> after interrupts are re-enabled.
> Since, interrupts are (usually) disabled during lockless pagetable
> walk, and serialize_against_pte_lookup will only return after
> interrupts are enabled, it is protected.
> 
> So, by what I could understand, if there is no lockless pagetable walk
> running, there is no need to call serialize_against_pte_lookup().
> 
> So, to avoid the cost of running serialize_against_pte_lookup(), I
> propose a counter that keeps track of how many find_current_mm_pte()
> are currently running, and if there is none, just skip
> smp_call_function_many().
> 
> The related functions are:
> start_lockless_pgtbl_walk(mm)
> 	Insert before starting any lockless pgtable walk
> end_lockless_pgtbl_walk(mm)
> 	Insert after the end of any lockless pgtable walk
> 	(Mostly after the ptep is last used)
> running_lockless_pgtbl_walk(mm)
> 	Returns the number of lockless pgtable walks running
> 
> On my workload (qemu), I could see munmap's time reduction from 275
> seconds to 418ms.
> 
> Changes since v2:
>  Rebased to v5.3
>  Adds support on __get_user_pages_fast
>  Adds usage decription to *_lockless_pgtbl_walk()
>  Better style to dummy functions
>  Link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=131839

Hi Leonardo,

Thanks for adding linux-mm to CC for this next round of reviews. For the benefit
of any new reviewers, I'd like to add that there are some issues that were discovered
while reviewing the v2 patchset, that are not (yet) addressed in this v3 series.

Since those issues are not listed in the cover letter above, I'll list them here:

1. The locking model requires a combination of disabling interrupts and
atomic counting and memory barriers, but

	a) some memory barriers are missing (start/end_lockless_pgtbl_walk), and
	b) some cases (patch #8) fail to disable interrupts

...so the synchronization appears to be inadequate. (And if it *is* adequate, then
definitely we need the next item, to explain it.)

2. Documentation of the synchronization/locking model needs to exist, once we
figure out the exact details of (1).

3. Related to (1), I've asked to change things so that interrupt controls and 
atomic inc/dec are in the same start/end calls--assuming, of course, that the
caller can tolerate that. 

4. Please see the v2 series for any other details I've missed.

thanks,
-- 
John Hubbard
NVIDIA

>  
> Changes since v1:
>  Isolated atomic operations in functions *_lockless_pgtbl_walk()
>  Fixed behavior of decrementing before last ptep was used
>  Link: http://patchwork.ozlabs.org/patch/1163093/
>  
> Leonardo Bras (11):
>   powerpc/mm: Adds counting method to monitor lockless pgtable walks
>   asm-generic/pgtable: Adds dummy functions to monitor lockless pgtable
>     walks
>   mm/gup: Applies counting method to monitor gup_pgd_range
>   powerpc/mce_power: Applies counting method to monitor lockless pgtbl
>     walks
>   powerpc/perf: Applies counting method to monitor lockless pgtbl walks
>   powerpc/mm/book3s64/hash: Applies counting method to monitor lockless
>     pgtbl walks
>   powerpc/kvm/e500: Applies counting method to monitor lockless pgtbl
>     walks
>   powerpc/kvm/book3s_hv: Applies counting method to monitor lockless
>     pgtbl walks
>   powerpc/kvm/book3s_64: Applies counting method to monitor lockless
>     pgtbl walks
>   powerpc/book3s_64: Enables counting method to monitor lockless pgtbl
>     walk
>   powerpc/mm/book3s64/pgtable: Uses counting method to skip serializing
> 
>  arch/powerpc/include/asm/book3s/64/mmu.h     |  3 ++
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  5 +++
>  arch/powerpc/kernel/mce_power.c              | 13 +++++--
>  arch/powerpc/kvm/book3s_64_mmu_hv.c          |  2 +
>  arch/powerpc/kvm/book3s_64_mmu_radix.c       | 20 +++++++++-
>  arch/powerpc/kvm/book3s_64_vio_hv.c          |  4 ++
>  arch/powerpc/kvm/book3s_hv_nested.c          |  8 ++++
>  arch/powerpc/kvm/book3s_hv_rm_mmu.c          |  9 ++++-
>  arch/powerpc/kvm/e500_mmu_host.c             |  4 ++
>  arch/powerpc/mm/book3s64/hash_tlb.c          |  2 +
>  arch/powerpc/mm/book3s64/hash_utils.c        |  7 ++++
>  arch/powerpc/mm/book3s64/mmu_context.c       |  1 +
>  arch/powerpc/mm/book3s64/pgtable.c           | 40 +++++++++++++++++++-
>  arch/powerpc/perf/callchain.c                |  5 ++-
>  include/asm-generic/pgtable.h                | 15 ++++++++
>  mm/gup.c                                     |  8 ++++
>  16 files changed, 138 insertions(+), 8 deletions(-)
> 
