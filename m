From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/4] doc: Rename LOCK/UNLOCK to ACQUIRE/RELEASE
Date: Thu, 7 Nov 2013 15:05:04 -0500
Message-ID: <20131107200503.GA27329@Krystal>
References: <20131107220314.740353088@infradead.org>
 <20131107221254.085121978@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182]:28506 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754997Ab3KHATw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Nov 2013 19:19:52 -0500
Content-Disposition: inline
In-Reply-To: <20131107221254.085121978@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: linux-arch@vger.kernel.org, geert@linux-m68k.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tony.luck@intel.com

Hi Peter,

Some comments follow. Sorry for being late at joining all the fun. I
look at my polymtl address less and less often nowadays. You'll have a
faster response time with my mathieu.desnoyers@efficios.com address.

* peterz@infradead.org (peterz@infradead.org) wrote:
> The LOCK and UNLOCK barriers as described in our barrier document are
> generally known as ACQUIRE and RELEASE barriers in other literature.
> 
> Since we plan to introduce the acquire and release nomenclature in
> generic kernel primitives we should ammend the document to avoid

ammend -> amend

> confusion as to what an acquire/release means.
> 
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> Cc: Michael Ellerman <michael@ellerman.id.au>
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Victor Kaplansky <VICTORK@il.ibm.com>
> Reviewed-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> ---
>  Documentation/memory-barriers.txt |  164 +++++++++++++++++++-------------------
>  1 file changed, 85 insertions(+), 79 deletions(-)
> 
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -371,33 +371,38 @@ VARIETIES OF MEMORY BARRIER
>  
>  And a couple of implicit varieties:
>  
> - (5) LOCK operations.
> + (5) ACQUIRE operations.
>  
>       This acts as a one-way permeable barrier.  It guarantees that all memory
> -     operations after the LOCK operation will appear to happen after the LOCK
> -     operation with respect to the other components of the system.
> +     operations after the ACQUIRE operation will appear to happen after the
> +     ACQUIRE operation with respect to the other components of the system.
> +     ACQUIRE operations include LOCK operations and smp_load_acquire()
> +     operations.
>  
> -     Memory operations that occur before a LOCK operation may appear to happen
> -     after it completes.
> +     Memory operations that occur before a ACQUIRE operation may appear to

a ACQUIRE -> an ACQUIRE

> +     happen after it completes.
>  
> -     A LOCK operation should almost always be paired with an UNLOCK operation.
> +     A ACQUIRE operation should almost always be paired with an RELEASE

A ACQUIRE -> An ACQUIRE
an RELEASE -> a RELEASE

> +     operation.
>  
>  
> - (6) UNLOCK operations.
> + (6) RELEASE operations.
>  
>       This also acts as a one-way permeable barrier.  It guarantees that all
> -     memory operations before the UNLOCK operation will appear to happen before
> -     the UNLOCK operation with respect to the other components of the system.
> +     memory operations before the RELEASE operation will appear to happen
> +     before the RELEASE operation with respect to the other components of the
> +     system. RELEASE operations include UNLOCK operations and
> +     smp_store_release() operations.
>  
> -     Memory operations that occur after an UNLOCK operation may appear to
> +     Memory operations that occur after an RELEASE operation may appear to

an RELEASE -> a RELEASE

>       happen before it completes.
>  
> -     LOCK and UNLOCK operations are guaranteed to appear with respect to each
> -     other strictly in the order specified.
> +     ACQUIRE and RELEASE operations are guaranteed to appear with respect to
> +     each other strictly in the order specified.
>  
> -     The use of LOCK and UNLOCK operations generally precludes the need for
> -     other sorts of memory barrier (but note the exceptions mentioned in the
> -     subsection "MMIO write barrier").
> +     The use of ACQUIRE and RELEASE operations generally precludes the need
> +     for other sorts of memory barrier (but note the exceptions mentioned in
> +     the subsection "MMIO write barrier").
>  
>  
>  Memory barriers are only required where there's a possibility of interaction
> @@ -1135,7 +1140,7 @@ CPU from reordering them.
>  	clear_bit( ... );
>  
>       This prevents memory operations before the clear leaking to after it.  See
> -     the subsection on "Locking Functions" with reference to UNLOCK operation
> +     the subsection on "Locking Functions" with reference to RELEASE operation
>       implications.
>  
>       See Documentation/atomic_ops.txt for more information.  See the "Atomic
> @@ -1181,65 +1186,66 @@ LOCKING FUNCTIONS
>   (*) R/W semaphores
>   (*) RCU
>  
> -In all cases there are variants on "LOCK" operations and "UNLOCK" operations
> +In all cases there are variants on "ACQUIRE" operations and "RELEASE" operations
>  for each construct.  These operations all imply certain barriers:
>  
> - (1) LOCK operation implication:
> + (1) ACQUIRE operation implication:
>  
> -     Memory operations issued after the LOCK will be completed after the LOCK
> -     operation has completed.
> +     Memory operations issued after the ACQUIRE will be completed after the
> +     ACQUIRE operation has completed.
>  
> -     Memory operations issued before the LOCK may be completed after the LOCK
> -     operation has completed.
> +     Memory operations issued before the ACQUIRE may be completed after the
> +     ACQUIRE operation has completed.
>  
> - (2) UNLOCK operation implication:
> + (2) RELEASE operation implication:
>  
> -     Memory operations issued before the UNLOCK will be completed before the
> -     UNLOCK operation has completed.
> +     Memory operations issued before the RELEASE will be completed before the
> +     RELEASE operation has completed.
>  
> -     Memory operations issued after the UNLOCK may be completed before the
> -     UNLOCK operation has completed.
> +     Memory operations issued after the RELEASE may be completed before the
> +     RELEASE operation has completed.
>  
> - (3) LOCK vs LOCK implication:
> + (3) ACQUIRE vs ACQUIRE implication:
>  
> -     All LOCK operations issued before another LOCK operation will be completed
> -     before that LOCK operation.
> +     All ACQUIRE operations issued before another ACQUIRE operation will be
> +     completed before that ACQUIRE operation.
>  
> - (4) LOCK vs UNLOCK implication:
> + (4) ACQUIRE vs RELEASE implication:
>  
> -     All LOCK operations issued before an UNLOCK operation will be completed
> -     before the UNLOCK operation.
> +     All ACQUIRE operations issued before an RELEASE operation will be

an RELEASE -> a RELEASE

> +     completed before the RELEASE operation.
>  
> -     All UNLOCK operations issued before a LOCK operation will be completed
> -     before the LOCK operation.
> +     All RELEASE operations issued before a ACQUIRE operation will be

a ACQUIRE -> an ACQUIRE

> +     completed before the ACQUIRE operation.
>  
> - (5) Failed conditional LOCK implication:
> + (5) Failed conditional ACQUIRE implication:
>  
> -     Certain variants of the LOCK operation may fail, either due to being
> +     Certain variants of the ACQUIRE operation may fail, either due to being
>       unable to get the lock immediately, or due to receiving an unblocked
> -     signal whilst asleep waiting for the lock to become available.  Failed
> -     locks do not imply any sort of barrier.
> +     signal whilst asleep waiting for the lock to become available. For
> +     example, failed locks do not imply any sort of barrier.
>  
> -Therefore, from (1), (2) and (4) an UNLOCK followed by an unconditional LOCK is
> -equivalent to a full barrier, but a LOCK followed by an UNLOCK is not.
> +Therefore, from (1), (2) and (4) an RELEASE followed by an unconditional

an RELEASE -> a RELEASE

> +ACQUIRE is equivalent to a full barrier, but a ACQUIRE followed by an RELEASE

a ACQUIRE -> an ACQUIRE

> +is not.
>  
>  [!] Note: one of the consequences of LOCKs and UNLOCKs being only one-way
>      barriers is that the effects of instructions outside of a critical section
>      may seep into the inside of the critical section.
>  
> -A LOCK followed by an UNLOCK may not be assumed to be full memory barrier
> -because it is possible for an access preceding the LOCK to happen after the
> -LOCK, and an access following the UNLOCK to happen before the UNLOCK, and the
> -two accesses can themselves then cross:
> +A ACQUIRE followed by an RELEASE may not be assumed to be full memory barrier

A ACQUIRE -> An ACQUIRE
an RELEASE -> a RELEASE

Other than that,

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

> +because it is possible for an access preceding the ACQUIRE to happen after the
> +ACQUIRE, and an access following the RELEASE to happen before the RELEASE, and
> +the two accesses can themselves then cross:
>  
>  	*A = a;
> -	LOCK
> -	UNLOCK
> +	ACQUIRE
> +	RELEASE
>  	*B = b;
>  
>  may occur as:
>  
> -	LOCK, STORE *B, STORE *A, UNLOCK
> +	ACQUIRE, STORE *B, STORE *A, RELEASE
>  
>  Locks and semaphores may not provide any guarantee of ordering on UP compiled
>  systems, and so cannot be counted on in such a situation to actually achieve
> @@ -1253,33 +1259,33 @@ See also the section on "Inter-CPU locki
>  
>  	*A = a;
>  	*B = b;
> -	LOCK
> +	ACQUIRE
>  	*C = c;
>  	*D = d;
> -	UNLOCK
> +	RELEASE
>  	*E = e;
>  	*F = f;
>  
>  The following sequence of events is acceptable:
>  
> -	LOCK, {*F,*A}, *E, {*C,*D}, *B, UNLOCK
> +	ACQUIRE, {*F,*A}, *E, {*C,*D}, *B, RELEASE
>  
>  	[+] Note that {*F,*A} indicates a combined access.
>  
>  But none of the following are:
>  
> -	{*F,*A}, *B,	LOCK, *C, *D,	UNLOCK, *E
> -	*A, *B, *C,	LOCK, *D,	UNLOCK, *E, *F
> -	*A, *B,		LOCK, *C,	UNLOCK, *D, *E, *F
> -	*B,		LOCK, *C, *D,	UNLOCK, {*F,*A}, *E
> +	{*F,*A}, *B,	ACQUIRE, *C, *D,	RELEASE, *E
> +	*A, *B, *C,	ACQUIRE, *D,		RELEASE, *E, *F
> +	*A, *B,		ACQUIRE, *C,		RELEASE, *D, *E, *F
> +	*B,		ACQUIRE, *C, *D,	RELEASE, {*F,*A}, *E
>  
>  
>  
>  INTERRUPT DISABLING FUNCTIONS
>  -----------------------------
>  
> -Functions that disable interrupts (LOCK equivalent) and enable interrupts
> -(UNLOCK equivalent) will act as compiler barriers only.  So if memory or I/O
> +Functions that disable interrupts (ACQUIRE equivalent) and enable interrupts
> +(RELEASE equivalent) will act as compiler barriers only.  So if memory or I/O
>  barriers are required in such a situation, they must be provided from some
>  other means.
>  
> @@ -1436,24 +1442,24 @@ Consider the following: the system has a
>  	CPU 1				CPU 2
>  	===============================	===============================
>  	*A = a;				*E = e;
> -	LOCK M				LOCK Q
> +	ACQUIRE M			ACQUIRE Q
>  	*B = b;				*F = f;
>  	*C = c;				*G = g;
> -	UNLOCK M			UNLOCK Q
> +	RELEASE M			RELEASE Q
>  	*D = d;				*H = h;
>  
>  Then there is no guarantee as to what order CPU 3 will see the accesses to *A
>  through *H occur in, other than the constraints imposed by the separate locks
>  on the separate CPUs. It might, for example, see:
>  
> -	*E, LOCK M, LOCK Q, *G, *C, *F, *A, *B, UNLOCK Q, *D, *H, UNLOCK M
> +	*E, ACQUIRE M, ACQUIRE Q, *G, *C, *F, *A, *B, RELEASE Q, *D, *H, RELEASE M
>  
>  But it won't see any of:
>  
> -	*B, *C or *D preceding LOCK M
> -	*A, *B or *C following UNLOCK M
> -	*F, *G or *H preceding LOCK Q
> -	*E, *F or *G following UNLOCK Q
> +	*B, *C or *D preceding ACQUIRE M
> +	*A, *B or *C following RELEASE M
> +	*F, *G or *H preceding ACQUIRE Q
> +	*E, *F or *G following RELEASE Q
>  
>  
>  However, if the following occurs:
> @@ -1461,28 +1467,28 @@ through *H occur in, other than the cons
>  	CPU 1				CPU 2
>  	===============================	===============================
>  	*A = a;
> -	LOCK M		[1]
> +	ACQUIRE M	[1]
>  	*B = b;
>  	*C = c;
> -	UNLOCK M	[1]
> +	RELEASE M	[1]
>  	*D = d;				*E = e;
> -					LOCK M		[2]
> +					ACQUIRE M	[2]
>  					*F = f;
>  					*G = g;
> -					UNLOCK M	[2]
> +					RELEASE M	[2]
>  					*H = h;
>  
>  CPU 3 might see:
>  
> -	*E, LOCK M [1], *C, *B, *A, UNLOCK M [1],
> -		LOCK M [2], *H, *F, *G, UNLOCK M [2], *D
> +	*E, ACQUIRE M [1], *C, *B, *A, RELEASE M [1],
> +	    ACQUIRE M [2], *H, *F, *G, RELEASE M [2], *D
>  
>  But assuming CPU 1 gets the lock first, CPU 3 won't see any of:
>  
> -	*B, *C, *D, *F, *G or *H preceding LOCK M [1]
> -	*A, *B or *C following UNLOCK M [1]
> -	*F, *G or *H preceding LOCK M [2]
> -	*A, *B, *C, *E, *F or *G following UNLOCK M [2]
> +	*B, *C, *D, *F, *G or *H preceding ACQUIRE M [1]
> +	*A, *B or *C following RELEASE M [1]
> +	*F, *G or *H preceding ACQUIRE M [2]
> +	*A, *B, *C, *E, *F or *G following RELEASE M [2]
>  
>  
>  LOCKS VS I/O ACCESSES
> @@ -1702,13 +1708,13 @@ about the state (old or new) implies an
>  	test_and_clear_bit();
>  	test_and_change_bit();
>  
> -These are used for such things as implementing LOCK-class and UNLOCK-class
> +These are used for such things as implementing ACQUIRE-class and RELEASE-class
>  operations and adjusting reference counters towards object destruction, and as
>  such the implicit memory barrier effects are necessary.
>  
>  
>  The following operations are potential problems as they do _not_ imply memory
> -barriers, but might be used for implementing such things as UNLOCK-class
> +barriers, but might be used for implementing such things as RELEASE-class
>  operations:
>  
>  	atomic_set();
> @@ -1750,9 +1756,9 @@ barriers are needed or not.
>  	clear_bit_unlock();
>  	__clear_bit_unlock();
>  
> -These implement LOCK-class and UNLOCK-class operations. These should be used in
> -preference to other operations when implementing locking primitives, because
> -their implementations can be optimised on many architectures.
> +These implement ACQUIRE-class and RELEASE-class operations. These should be
> +used in preference to other operations when implementing locking primitives,
> +because their implementations can be optimised on many architectures.
>  
>  [!] Note that special memory barrier primitives are available for these
>  situations because on some CPUs the atomic instructions used imply full memory
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
