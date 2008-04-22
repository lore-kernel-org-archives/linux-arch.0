From: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [patch 2/2]: introduce fast_gup
Date: Tue, 22 Apr 2008 11:46:29 +0200
Message-ID: <20080422094629.GC23770@wotan.suse.de>
References: <20080328025455.GA8083@wotan.suse.de> <20080328030023.GC8083@wotan.suse.de> <1208857356.7115.218.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1208857356.7115.218.camel@twins>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, shaggy-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org, axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org

On Tue, Apr 22, 2008 at 11:42:36AM +0200, Peter Zijlstra wrote:
> On Fri, 2008-03-28 at 04:00 +0100, Nick Piggin wrote:
> 
> > +static noinline int gup_pte_range(pmd_t pmd, unsigned long addr,
> > +		unsigned long end, int write, struct page **pages, int *nr)
> > +{
> > +	unsigned long mask, result;
> > +	pte_t *ptep;
> > +
> > +	result = _PAGE_PRESENT|_PAGE_USER;
> > +	if (write)
> > +		result |= _PAGE_RW;
> > +	mask = result | _PAGE_SPECIAL;
> > +
> > +	ptep = pte_offset_map(&pmd, addr);
> > +	do {
> > +		/*
> > +		 * XXX: careful. On 3-level 32-bit, the pte is 64 bits, and
> > +		 * we need to make sure we load the low word first, then the
> > +		 * high. This means _PAGE_PRESENT should be clear if the high
> > +		 * word was not valid. Currently, the C compiler can issue
> > +		 * the loads in any order, and I don't know of a wrapper
> > +		 * function that will do this properly, so it is broken on
> > +		 * 32-bit 3-level for the moment.
> > +		 */
> > +		pte_t pte = *ptep;
> > +		struct page *page;
> > +
> > +		if ((pte_val(pte) & mask) != result)
> > +			return 0;
> 
> This return path fails to unmap the pmd.

Ah good catch. As you can see I haven't done any highmem testing ;)
Which I will do so before sending upstream.
