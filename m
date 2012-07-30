From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC] page-table walkers vs memory order
Date: Mon, 30 Jul 2012 13:28:57 -0700
Message-ID: <20120730202857.GL2391@linux.vnet.ibm.com>
References: <1343064870.26034.23.camel@twins>
 <alpine.LSU.2.00.1207241356350.2094@eggly.anvils>
 <20120725175628.GH2378@linux.vnet.ibm.com>
 <alpine.LSU.2.00.1207251313180.1942@eggly.anvils>
 <20120725211217.GR2378@linux.vnet.ibm.com>
 <20120730192140.GU25459@jl-vm1.vm.bytemark.co.uk>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20120730192140.GU25459@jl-vm1.vm.bytemark.co.uk>
Sender: owner-linux-mm@kvack.org
To: Jamie Lokier <jamie@shareable.org>
Cc: Hugh Dickins <hughd@google.com>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@kernel.dk>, Andrea Arcangeli <aarcange@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 30, 2012 at 08:21:40PM +0100, Jamie Lokier wrote:
> Paul E. McKenney wrote:
> > > Does some version of gcc, under the options which we insist upon,
> > > make such optimizations on any of the architectures which we support?
> > 
> > Pretty much any production-quality compiler will do double-fetch
> > and old-value-reuse optimizations, the former especially on 32-bit
> > x86.  I don't know of any production-quality compilers that do value
> > speculation, which would make the compiler act like DEC Alpha hardware,
> > and I would hope that if this does appear, (1) we would have warning
> > and (2) it could be turned off.  But there has been a lot of work on
> > this topic, so we would be foolish to rule it out.
> 
> GCC documentation for IA-64:
> 
>    -msched-ar-data-spec
>    -mno-sched-ar-data-spec
>      (En/Dis)able data speculative scheduling after reload. This results
>      in generation of ld.a instructions and the corresponding check
>      instructions (ld.c / chk.a). The default is 'enable'.
> 
> I don't know if that results in value speculation of the relevant kind.

If I remember correctly, the chk.a instruction will detect failed
speculation via cache state and deal with the situation correctly,
but I really need to defer to someone with more recent IA-64 experience.

							Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
