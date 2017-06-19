From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv2 1/3] x86/mm: Provide pmdp_establish() helper
Date: Mon, 19 Jun 2017 15:46:49 +0300
Message-ID: <20170619124649.jy7m4ig3clln3pcw@node.shutemov.name>
References: <20170615145224.66200-1-kirill.shutemov@linux.intel.com>
 <20170615145224.66200-2-kirill.shutemov@linux.intel.com>
 <20170616133600.GE11676@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170616133600.GE11676@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Fri, Jun 16, 2017 at 03:36:00PM +0200, Andrea Arcangeli wrote:
> Hello Krill,
> 
> On Thu, Jun 15, 2017 at 05:52:22PM +0300, Kirill A. Shutemov wrote:
> > +static inline pmd_t pmdp_establish(pmd_t *pmdp, pmd_t pmd)
> > +{
> > +	pmd_t old;
> > +
> > +	/*
> > +	 * We cannot assume what is value of pmd here, so there's no easy way
> > +	 * to set if half by half. We have to fall back to cmpxchg64.
> > +	 */
> > +	{
> > +		old = *pmdp;
> > +	} while (cmpxchg64(&pmdp->pmd, old.pmd, pmd.pmd) != old.pmd);
> > +
> > +	return old;
> > +}
> 
> I see further margin for optimization here (although it's only for PAE
> x32..).
> 
> pmd is stable so we could do:
> 
> if (!(pmd & _PAGE_PRESENT)) {
>    cast to split_pmd and use xchg on pmd_low like
>    native_pmdp_get_and_clear and copy pmd_high non atomically
> } else {
>   the above cmpxchg64 loop
> }
> 
> Now thinking about the above I had a second thought if pmdp_establish
> is the right interface and if we shouldn't replace pmdp_establish with
> pmdp_mknotpresent instead to skip the pmd & _PAGE_PRESENT check that
> will always be true in practice, so pmdp_mknotpresent will call
> internally pmd_mknotpresent and it won't have to check for pmd &
> _PAGE_PRESENT and it would have no cons on x86-64.

With your proposed optimization, compiler is in good position to eliminate
cmpxchg loop for trivial cases as we have in pmdp_invalidate() case.
It can see that pmd is always has the present bit cleared.

I'll keep more flexible interface for now. Will see if anybody would see
more problems with it.

-- 
 Kirill A. Shutemov
