From: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 03/11] mm/gup: Applies counting method to monitor
 gup_pgd_range
Date: Mon, 30 Sep 2019 14:51:34 -0700
Message-ID: <ce0a4110-9f83-36db-dc85-6a727d30d030@nvidia.com>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
 <20190927234008.11513-4-leonardo@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20190927234008.11513-4-leonardo@linux.ibm.com>
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

On 9/27/19 4:40 PM, Leonardo Bras wrote:
> As decribed, gup_pgd_range is a lockless pagetable walk. So, in order to
> monitor against THP split/collapse with the couting method, it's necessary

s/couting/counting/

> to bound it with {start,end}_lockless_pgtbl_walk.
> 
> There are dummy functions, so it is not going to add any overhead on archs
> that don't use this method.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>  mm/gup.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 98f13ab37bac..7105c829cf44 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2325,6 +2325,7 @@ static bool gup_fast_permitted(unsigned long start, unsigned long end)
>  int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  			  struct page **pages)
>  {
> +	struct mm_struct *mm;

I don't think that this local variable adds any value, so let's not use it.
Similar point in a few other patches too.

>  	unsigned long len, end;
>  	unsigned long flags;
>  	int nr = 0;
> @@ -2352,9 +2353,12 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  
>  	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
>  	    gup_fast_permitted(start, end)) {
> +		mm = current->mm;
> +		start_lockless_pgtbl_walk(mm);
>  		local_irq_save(flags);
>  		gup_pgd_range(start, end, write ? FOLL_WRITE : 0, pages, &nr);
>  		local_irq_restore(flags);
> +		end_lockless_pgtbl_walk(mm);
>  	}
>  
>  	return nr;
> @@ -2404,6 +2408,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>  			unsigned int gup_flags, struct page **pages)
>  {
>  	unsigned long addr, len, end;
> +	struct mm_struct *mm;

Same here.

>  	int nr = 0, ret = 0;
>  
>  	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM)))
> @@ -2421,9 +2426,12 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>  
>  	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
>  	    gup_fast_permitted(start, end)) {
> +		mm = current->mm;
> +		start_lockless_pgtbl_walk(mm);

Minor: I'd like to rename this register_lockless_pgtable_walker().

>  		local_irq_disable();
>  		gup_pgd_range(addr, end, gup_flags, pages, &nr);
>  		local_irq_enable();
> +		end_lockless_pgtbl_walk(mm);

...and deregister_lockless_pgtable_walker().


thanks,
-- 
John Hubbard
NVIDIA
