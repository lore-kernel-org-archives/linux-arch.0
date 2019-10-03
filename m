From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 10/11] mm/Kconfig: Adds config option to track
 lockless pagetable walks
Date: Thu, 3 Oct 2019 09:44:32 +0200
Message-ID: <20191003074432.GO4536@hirez.programming.kicks-ass.net>
References: <20191003013325.2614-1-leonardo@linux.ibm.com>
 <20191003013325.2614-11-leonardo@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20191003013325.2614-11-leonardo@linux.ibm.com>
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

On Wed, Oct 02, 2019 at 10:33:24PM -0300, Leonardo Bras wrote:
> Adds config option LOCKLESS_PAGE_TABLE_WALK_TRACKING to make possible
> enabling tracking lockless pagetable walks directly from kernel config.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>  mm/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index a5dae9a7eb51..00f487a0122f 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -736,4 +736,15 @@ config ARCH_HAS_PTE_SPECIAL
>  config ARCH_HAS_HUGEPD
>  	bool
>  
> +config LOCKLESS_PAGE_TABLE_WALK_TRACKING
> +	bool "Track (and optimize) lockless page table walks"
> +	default n
> +
> +	help
> +	  Maintain a reference count of active lockless page table
> +	  walkers. This adds 4 bytes to struct mm size, and two atomic
> +	  operations to calls such as get_user_pages_fast(). Some
> +	  architectures can optimize lockless page table operations if
> +	  this is enabled.

This shouldn't be a user visible option at all. Either the arch needs
it and selects it or not.
