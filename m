From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] proc: mm: export PTE sizes directly in smaps (v3)
Date: Fri, 02 Dec 2016 21:44:57 +0530
Message-ID: <874m2me29q.fsf@linux.vnet.ibm.com>
References: <20161129201703.CE9D5054@viggo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20161129201703.CE9D5054@viggo.jf.intel.com>
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave@sr71.net>, hch@lst.de, akpm@linux-foundation.org, dan.j.williams@intel.com, khandual@linux.vnet.ibm.com, vbabka@suse.cz, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Dave Hansen <dave@sr71.net> writes:

  
>  #ifdef CONFIG_HUGETLB_PAGE
> +/*
> + * Most architectures have a 1:1 mapping of PTEs to hugetlb page
> + * sizes, but there are some outliers like arm64 that use
> + * multiple hardware PTEs to make a hugetlb "page".  Do not
> + * assume that all 'hpage_size's are not exactly at a page table
> + * size boundary.  Instead, accept arbitrary 'hpage_size's and
> + * assume they are made up of the next-smallest size.  We do not
> + * handle PGD-sized hpages and hugetlb_add_hstate() will WARN()
> + * if it sees one.
> + *
> + * Note also that the page walker code only calls us once per
> + * huge 'struct page', *not* once per PTE in the page tables.
> + */
> +static void smaps_hugetlb_present_hpage(struct mem_size_stats *mss,
> +					unsigned long hpage_size)
> +{
> +	if (hpage_size >= PUD_SIZE)
> +		mss->rss_pud += hpage_size;
> +	else if (hpage_size >= PMD_SIZE)
> +		mss->rss_pmd += hpage_size;
> +	else
> +		mss->rss_pte += hpage_size;
> +}

some powerpc platforms have multiple page table entries mapping the same
hugepage and on other, we have a page table entry pointing to something
called hugepaeg directory mapping a set of hugepage. So I am not sure
the above will work for all those ?

Also do we derive pte@<size value> correctly there ?

-aneesh

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
