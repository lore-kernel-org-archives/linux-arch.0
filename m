From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 3/3] powerpc/64s/radix: optimise TLB flush with
 precise TLB ranges in mmu_gather
Date: Wed, 13 Jun 2018 09:53:59 +1000
Message-ID: <20180613095359.1892b26d@roar.ozlabs.ibm.com>
References: <20180612071621.26775-1-npiggin@gmail.com>
 <20180612071621.26775-4-npiggin@gmail.com>
 <CA+55aFzKBieD0Y3sgFQzt+x5esqb9vT6SEQ28xyCz5UWegfFVg@mail.gmail.com>
 <20180613083131.139a3c34@roar.ozlabs.ibm.com>
 <CA+55aFyk9VBLUk8VYhfEUR55x0TXY9_QX1dE4wE0A_ias9tMNQ@mail.gmail.com>
 <20180613090950.50566245@roar.ozlabs.ibm.com>
 <CA+55aFxd97-29qi-JMxyPPoZMxw=eObQHB5XXGiLj7SNV8B-oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <CA+55aFxd97-29qi-JMxyPPoZMxw=eObQHB5XXGiLj7SNV8B-oQ@mail.gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>, Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, linux-mm <linux-mm@kvack.org>, "Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-arch.vger.kernel.org

On Tue, 12 Jun 2018 16:26:33 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Jun 12, 2018 at 4:09 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Sorry I mean Intel needs the existing behaviour of range flush expanded
> > to cover page table pages.... right?  
> 
> Right.  Intel depends on the current thing, ie if a page table
> *itself* is freed, we will will need to do a flush, but it's the exact
> same flush as if there had been a regular page there.
> 
> That's already handled by (for example) pud_free_tlb() doing the
> __tlb_adjust_range().

Agreed.

> 
> Again, I may be missing entirely what you're talking about, because it
> feels like we're talking across each other.
> 
> My argument is that your new patches in (2-3 in the series - patch #1
> looks ok) seem to be fundamentally specific to things that have a
> *different* tlb invalidation for the directory entries than for the
> leaf entries.

Yes I think I confused myself a bit. You're right these patches are
only useful if there is no page structure cache, or if it's managed
separately from TLB invalidation.

> 
> But that's not what at least x86 has, and not what the generic code has done.
> 
> I think it might be fine to introduce a few new helpers that end up
> being no-ops for the traditional cases.
> 
> I just don't think it makes sense to maintain a set of range values
> that then aren't actually used in the general case.

Sure, I'll make it optional. That would probably give a better result
for powerpc too because it doesn't need to maintain two ranges either.

Thanks,
Nick
