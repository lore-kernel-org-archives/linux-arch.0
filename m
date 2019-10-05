From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v5 01/11] asm-generic/pgtable: Adds generic functions to
 monitor lockless pgtable walks
Date: Sat, 5 Oct 2019 14:05:29 +0530
Message-ID: <651856af-30de-15ad-2312-158f3ad5292e@linux.ibm.com>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
 <20191003013325.2614-2-leonardo@linux.ibm.com>
 <20191003071145.GM4536@hirez.programming.kicks-ass.net>
 <20191003115141.GJ4581@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20191003115141.GJ4581@hirez.programming.kicks-ass.net>
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
To: Peter Zijlstra <peterz@infradead.org>, Leonardo Bras <leonardo@linux.ibm.com>
Cc: Song Liu <songliubraving@fb.com>, Michal Hocko <mhocko@suse.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Keith Busch <keith.busch@intel.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, Christoph Lameter <cl@linux.com>, Ira Weiny <ira.weiny@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, linux-arch@vger.kernel.org, Santosh Sivaraj <santosh@fossix.org>, Davidlohr Bueso <dave@stgolabs.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Mike Rapoport <rppt@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexey Dobriyan <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Jann
List-Id: linux-arch.vger.kernel.org

On 10/3/19 5:21 PM, Peter Zijlstra wrote:
> On Thu, Oct 03, 2019 at 09:11:45AM +0200, Peter Zijlstra wrote:
>> On Wed, Oct 02, 2019 at 10:33:15PM -0300, Leonardo Bras wrote:


....


> 
> And I still think all that wrong, you really shouldn't need to wait on
> munmap().
> 

I do have a patch that does something like that.


+#define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR_FULL
+static inline pmd_t pmdp_huge_get_and_clear_full(struct mm_struct *mm,
+						 unsigned long address, pmd_t *pmdp,
+						 int full)
+{
+	bool serialize = true;
+	/*
+	 * We don't need to serialze against a lockless page table walk if
+	 * we are clearing the pmd due to task exit. For regular mnumap, we
+	 * still need to serialize due the possibility of MADV_DONTNEED running
+	 * parallel to a page fault which can convert a THP pte entry to a
+	 * pointer to level 4 table.
+	 * Here MADV_DONTNEED is removing the THP entry and the fault is filling
+	 * a level 4 pte.
+	 */
+	if (full == 1)
+		serialize = false;
+	return __pmdp_huge_get_and_clear(mm, address, pmdp, serialize);
  }


if it is a fullmm flush we can skip that serialize, But for everything 
else we need to serialize. MADV_DONTNEED is another case. I haven't sent 
this yet, because I was trying to look at what it takes to switch that 
MADV variant to take mmap_sem in write mode.

MADV_DONTNEED has caused us multiple issues due to the fact that it can 
run in parallel to page fault. I am not sure whether we have a 
known/noticeable performance gain in allowing that with mmap_sem held in 
read mode.




-aneesh
