From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Subject: Re: [PATCH] [ARM] force dcache flush if dcache_dirty bit set
Date: Mon, 12 Oct 2009 17:09:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0910121634170.7327@sister.anvils>
References: <1255337423-3158-1-git-send-email-ngupta@vflare.org>
	<20091012090710.GA29310@n2100.arm.linux.org.uk>
	<20091012.023744.157085851.davem@davemloft.net>
	<20091012100023.GC29310@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091012100023.GC29310@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nick Piggin <npiggin@suse.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, David Miller <davem@davemloft.net>, Nitin Gupta <ngupta@vflare.org>
List-Id: linux-arch.vger.kernel.org

On Mon, 12 Oct 2009, Russell King - ARM Linux wrote:
> On Mon, Oct 12, 2009 at 02:37:44AM -0700, David Miller wrote:
> > From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> > Date: Mon, 12 Oct 2009 10:07:10 +0100
> > 
> > > On Mon, Oct 12, 2009 at 02:20:23PM +0530, Nitin Gupta wrote:
> > >> Same problem exists on mips too.
> > > 
> > > Nice catch.  This logic came from sparc64, so I think you'd want to talk
> > > to davem about it as well.
> > > 
> > > In the mean time, submitting your fix to the patch system would be great,
> > > thanks.
> > 
> > Sparc64 flushes unconditionally when there is no page mapping.
> > So, it should be fine here.
> 
> Are you sure - I checked the sparc64 code before posting, and we're doing
> the same thing.
> 
> Sparc64 update_mmu_cache:
>         page = pfn_to_page(pfn);
>         if (page && page_mapping(page)) {
>                 pg_flags = page->flags;
>                 if (pg_flags & (1UL << PG_dcache_dirty)) {
> 			/* do lazy flush */
> 		}
> 	}
> 
> Sparc64 flush_dcache_page:
>         mapping = page_mapping(page);
>         if (mapping && !mapping_mapped(mapping)) {
>                 set_dcache_dirty(page, this_cpu);
> 	}
> 
> ARM update_mmu_cache:
>         page = pfn_to_page(pfn);
>         mapping = page_mapping(page);
>         if (mapping) {
>                 int dirty = test_and_clear_bit(PG_dcache_dirty, &page->flags);
>                 if (dirty)
>                         /* do lazy flush */
> 
> ARM flush_dcache_page:
>         struct address_space *mapping = page_mapping(page);
>         if (!PageHighMem(page) && mapping && !mapping_mapped(mapping))
>                 set_bit(PG_dcache_dirty, &page->flags);
> 
> It looks identical to me.
> 
> The problem which has been identified is that when flush_dcache_page() is
> called, there is a mapping, and so the page is marked for lazy flushing.
> However, by the time update_mmu_cache() gets called, the mapping has gone
> and so update_mmu_cache() does nothing.

Sorry to muddy the waters on this, if you and Dave are sure that
you have the right fix, down in your architectures, and that fix
isn't going to hurt your performance significantly.

But this issue would affect other architectures too, wouldn't it?
I think not just mips, which was mentioned, but others too, parisc
for example: linux-arch Cc'ed.

And I'm not certain that down in the arch is the right place:
it may well turn out to be right, but that's not obvious.  

How much is this issue peculiar to swap?  Where Nitin discovered it
in do_swap_page(), due to swap cache being freed before reaching the
update_mmu_cache().

If it is peculiar to swap, then I'd suggest perhaps one of two very
different solutions.  One would be to rearrange do_swap_page() so we
do not remove the page from swap cache before the update_mmu_cache()
(that would need care, and might turn out to be harder than I think).
The alternative solution might be to stop page_mapping(page) returning
the pseudo-address_space swapper_space when PageSwapCache - I always
hated that, but had to give in at the time.

(Aside: I don't think it affects this issue, but just be aware
that mapping_mapped(page) returns false on a swapcache page,
no matter whether it's mapped in anywhere or not.)

But if it is not peculiar to swap, fixes down in the architecture
may be inevitable.  I think this depends on what happens when
truncating or unmapping a file.  It used to be the case that pages
were unmapped first, then truncated (clearing page->mapping) after:
in which case, Nitin's issue would appear to be peculiar to swap.

But around 2.6.23 Nick found a second unmap_mapping_range() necessary
after the truncation (just for the invalidation case? or because of
inadequate serialization, now I think fixed with the page lock?).
And I think he has that area under reconstruction again at present,
so Cc'ed for his opinion on this issue - thanks.

Hugh
