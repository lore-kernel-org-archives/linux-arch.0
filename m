From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Date: Thu, 6 Apr 2017 15:13:53 +0100
Message-ID: <20170406141352.GF18204@arm.com>
References: <20170404095001.664718b8@roar.ozlabs.ibm.com>
 <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
 <20170404130233.1f45115b@roar.ozlabs.ibm.com>
 <20170405.070157.871721909352646302.davem@davemloft.net>
 <20170406105958.196c6977@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170406105958.196c6977@roar.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: David Miller <davem@davemloft.net>, torvalds@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, anton@samba.org, linuxppc-dev@ozlabs.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Hi Nick,

On Thu, Apr 06, 2017 at 10:59:58AM +1000, Nicholas Piggin wrote:
> On Wed, 05 Apr 2017 07:01:57 -0700 (PDT)
> David Miller <davem@davemloft.net> wrote:
> 
> > From: Nicholas Piggin <npiggin@gmail.com>
> > Date: Tue, 4 Apr 2017 13:02:33 +1000
> > 
> > > On Mon, 3 Apr 2017 17:43:05 -0700
> > > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > >   
> > >> But that depends on architectures having some pattern that we *can*
> > >> abstract. Would some "begin/in-loop/end" pattern like the above be
> > >> sufficient?  
> > > 
> > > Yes. begin/in/end would be sufficient for powerpc SMT priority, and
> > > for x86, and it looks like sparc64 too. So we could do that if you
> > > prefer.  
> > 
> > Sparc64 has two cases, on older chips we can induce a cpu thread yield
> > with a special sequence of instructions, and on newer chips we have
> > a bonafide pause instruction.
> > 
> > So cpu_relax() all by itself pretty much works for us.
> > 
> 
> Thanks for taking a look. The default spin primitives should just
> continue to do the right thing for you in that case.
> 
> Arm has a yield instruction, ia64 has a pause... No unusual
> requirements that I can see.

Yield tends to be implemented as a NOP in practice, since it's in the
architecture for SMT CPUs and most ARM CPUs are single-threaded. We do have
the WFE instruction (wait for event) which is used in our implementation of
smp_cond_load_acquire, but I don't think we'd be able to use it with the
proposals here.

WFE can stop the clock for the CPU until an "event" is signalled by
another CPU. This could be done by an explicit SEV (send event) instruction,
but that tends to require heavy barriers on the signalling side. Instead,
the preferred way to generate an event is to clear the exclusive monitor
reservation for the CPU executing the WFE. That means that the waiter
does something like:

	LDXR x0, [some_address]	// Load exclusive from some_address
	CMP  x0, some value	// If the value matches what I want
	B.EQ out		// then we're done
	WFE			// otherwise, wait

at this point, the waiter will stop on the WFE until its monitor is cleared,
which happens if another CPU writes to some_address.

We've wrapped this up in the arm64 code as __cmpwait, and we use that
to build smp_cond_load_acquire. It would be nice to use the same machinery
for the conditional spinning here, unless you anticipate that we're only
going to be spinning for a handful of iterations anyway?

Cheers,

Will
