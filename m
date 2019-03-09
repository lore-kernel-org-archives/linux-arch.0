From: Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Date: Fri, 8 Mar 2019 21:01:53 -0700
Message-ID: <20190309040153.GB214016@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <20190226151230.GA20230@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190226151230.GA20230@lakrids.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arch@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Nick Piggin <npiggin@gmail.com>, Jun Yao <yaojun8558363@gmail.com>, linux-mm@kvack.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Chintan Pandya <cpandya@codeaurora.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Andrew Morton <akpm@linux-foundation.org>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 26, 2019 at 03:12:31PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Mon, Feb 18, 2019 at 04:13:17PM -0700, Yu Zhao wrote:
> > For pte page, use pgtable_page_ctor(); for pmd page, use
> > pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
> > p4d and pgd), don't use any.
> > 
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  arch/arm64/mm/mmu.c | 33 +++++++++++++++++++++------------
> >  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> [...]
> 
> > -static phys_addr_t pgd_pgtable_alloc(void)
> > +static phys_addr_t pgd_pgtable_alloc(int shift)
> >  {
> >  	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
> > -	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
> > -		BUG();
> > +	BUG_ON(!ptr);
> > +
> > +	/*
> > +	 * Initialize page table locks in case later we need to
> > +	 * call core mm functions like apply_to_page_range() on
> > +	 * this pre-allocated page table.
> > +	 */
> > +	if (shift == PAGE_SHIFT)
> > +		BUG_ON(!pgtable_page_ctor(virt_to_page(ptr)));
> > +	else if (shift == PMD_SHIFT && PMD_SHIFT != PUD_SHIFT)
> > +		BUG_ON(!pgtable_pmd_page_ctor(virt_to_page(ptr)));
> 
> IIUC, this is for nopmd kernels, where we only have real PGD and PTE
> levels of table. From my PoV, that would be clearer if we did:
> 
> 	else if (shift == PMD_SHIFT && !is_defined(__PAGETABLE_PMD_FOLDED))
> 
> ... though IMO it would be a bit nicer if the generic
> pgtable_pmd_page_ctor() were nop'd out for __PAGETABLE_PMD_FOLDED
> builds, so that callers don't have to be aware of folding.

Agreed. Will make pgtable_pmd_page_ctor() nop when pmd is folded.

> I couldn't think of a nicer way of distinguishing levels of table, and
> having separate function pointers for each level seems over-the-top, so
> otehr than that this looks good to me.
> 
> Assuming you're happy with the above change:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks,
> Mark.
