From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: single copy atomicity for double load/stores on 32-bit systems
Date: Fri, 31 May 2019 04:44:21 -0700
Message-ID: <20190531114421.GJ28207@linux.ibm.com>
References: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
 <895ec12746c246579aed5dd98ace6e38@AcuMS.aculab.com>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <895ec12746c246579aed5dd98ace6e38@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Vineet Gupta' <Vineet.Gupta1@synopsys.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <Will.Deacon@arm.com>, arcml <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, May 31, 2019 at 09:41:17AM +0000, David Laight wrote:
> From: Vineet Gupta
> > Sent: 30 May 2019 19:23
> ...
> > While it seems reasonable form hardware pov to not implement such atomicity by
> > default it seems there's an additional burden on application writers. They could
> > be happily using a lockless algorithm with just a shared flag between 2 threads
> > w/o need for any explicit synchronization. But upgrade to a new compiler which
> > aggressively "packs" struct rendering long long 32-bit aligned (vs. 64-bit before)
> > causing the code to suddenly stop working. Is the onus on them to declare such
> > memory as c11 atomic or some such.
> 
> A 'new' compiler can't suddenly change the alignment rules for structure elements.
> The alignment rules will be part of the ABI.
> 
> More likely is that the structure itself is unexpectedly allocated on
> an 8n+4 boundary due to code changes elsewhere.
> 
> It is also worth noting that for complete portability only writes to
> 'full words' can be assumed atomic.
> Some old Alpha's did RMW cycles for byte writes.
> (Although I suspect Linux doesn't support those any more.)

Any C11 or later compiler needs to generate the atomic RMW cycles if
needed in cases like this.  To see this, consider the following code:

	spinlock_t l1;
	spinlock_t l2;
	struct foo {
		char c1; // Protected by l1
		char c2; // Protected by l2
	}

	...

	spin_lock(&l1);
	fp->c1 = 42;
	do_somthing_protected_by_l1();
	spin_unlock(&l1);

	...

	spin_lock(&l2);
	fp->c2 = 206;
	do_somthing_protected_by_l2();
	spin_unlock(&l2);

A compiler that failed to generate atomic RMW code sequences for those
stores to ->c1 and ->c2 would be generating a data race in the object
code when there was no such race in the source code.  Kudos to Hans Boehm
for having browbeat compiler writers into accepting this restriction,
which was not particularly popular -- they wanted to be able to use
vector units and such.  ;-)

> Even x86 can catch you out.
> The bit operations will do wider RMW cycles than you expect.

But does the compiler automatically generate these?

							Thanx, Paul

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
