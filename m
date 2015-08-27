From: Vineet Gupta <vgupta@synopsys.com>
Subject: Re: [PATCH 04/11] ARCv2: mm: THP support
Date: Thu, 27 Aug 2015 22:26:44 +0530
Message-ID: <55DF414C.6070601@synopsys.com>
References: <1440666194-21478-1-git-send-email-vgupta@synopsys.com>
 <1440666194-21478-5-git-send-email-vgupta@synopsys.com>
 <20150827153254.GA21103@node.dhcp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20150827153254.GA21103@node.dhcp.inet.fi>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Mel Gorman <mgorman@suse.de>, Matthew Wilcox <matthew.r.wilcox@intel.com>, Minchan Kim <minchan@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, arc-linux-dev@synopsys.com
List-Id: linux-arch.vger.kernel.org

On Thursday 27 August 2015 09:02 PM, Kirill A. Shutemov wrote:
> On Thu, Aug 27, 2015 at 02:33:07PM +0530, Vineet Gupta wrote:
>> > +pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
>> > +{
>> > +	struct list_head *lh;
>> > +	pgtable_t pgtable;
>> > +	pte_t *ptep;
>> > +
>> > +	assert_spin_locked(&mm->page_table_lock);
>> > +
>> > +	pgtable = pmd_huge_pte(mm, pmdp);
>> > +	lh = (struct list_head *) pgtable;
>> > +	if (list_empty(lh))
>> > +		pmd_huge_pte(mm, pmdp) = (pgtable_t) NULL;
>> > +	else {
>> > +		pmd_huge_pte(mm, pmdp) = (pgtable_t) lh->next;
>> > +		list_del(lh);
>> > +	}
> Side question: why pgtable_t is unsigned long on ARC and not struct page *
> or pte_t *, like on other archs? We could avoid these casts.

This goes back how I did this for ARC long back to avoid page_address() calls in
general case. e.g. pte_alloc_one(), pmd_populate(), pte_free()... all needed to
convert struct page to unsigned long. It was micro-optimization of sorts, but
served us well.

I could perhaps see try making it pte *, that will certainly remove a bunch of
other casts as well.

-Vineet


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
