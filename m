From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 00/11] Introduces new count-based method for tracking
 lockless pagetable walks
Date: Thu, 3 Oct 2019 09:29:52 +0200
Message-ID: <20191003072952.GN4536@hirez.programming.kicks-ass.net>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
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
To: Leonardo Bras <leonardo@linux.ibm.com>
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Ralph Campbell <rcampbel>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 02, 2019 at 10:33:14PM -0300, Leonardo Bras wrote:
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

This is something entirely specific to Power, you shouldn't be touching
generic code at all.

Also, I'm not sure I understand things properly.

So serialize_against_pte_lookup() wants to wait for all currently
out-standing __find_linux_pte() instances (which are very similar to
gup_fast).

It seems to want to do this before flushing the THP TLB for some reason;
why? Should not THP observe the normal page table freeing rules which
includes a RCU-like grace period like this already.

Why is THP special here? This doesn't seem adequately explained.

Also, specifically to munmap(), this seems entirely superfluous,
munmap() uses the normal page-table freeing code and should be entirely
fine without additional waiting.

Furthermore, Power never accurately tracks mm_cpumask(), so using that
makes the whole thing more expensive than it needs to be. Also, I
suppose that is buggered vs file backed THP.
