From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Tue, 26 Nov 2013 16:46:54 -0800
Message-ID: <529540FE.3070504@zytor.com>
References: <20131121132041.GS4138@linux.vnet.ibm.com> <20131121172558.GA27927@linux.vnet.ibm.com> <20131121215249.GZ16796@laptop.programming.kicks-ass.net> <20131121221859.GH4138@linux.vnet.ibm.com> <20131122155835.GR3866@twins.programming.kicks-ass.net> <20131122182632.GW4138@linux.vnet.ibm.com> <20131122185107.GJ4971@laptop.programming.kicks-ass.net> <20131125173540.GK3694@twins.programming.kicks-ass.net> <20131125180250.GR4138@linux.vnet.ibm.com> <5293E37F.5020908@zytor.com> <20131126031626.GE4138@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20131126031626.GE4138@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: paulmck@linux.vnet.ibm.com
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>Peter Hurley <p>
List-Id: linux-arch.vger.kernel.org

On 11/25/2013 07:16 PM, Paul E. McKenney wrote:
>=20
> My biggest question is the definition of "Memory ordering obeys causali=
ty
> (memory ordering respects transitive visibility)" in Section 3.2.2 of
> the "Intel=AE 64 and IA-32 Architectures Developer's Manual: Vol. 3A"
> dated March 2013 from:
>=20
> http://www.intel.com/content/www/us/en/architecture-and-technology/64-i=
a-32-architectures-software-developer-vol-3a-part-1-manual.html
>=20
> I am guessing that is orders loads as well as stores, so that a load
> is said to be "visible" to some other CPU once that CPU no longer has
> the opportunity to affect the return value from the load.  Is that a
> reasonable interpretation?
>=20

The best pointer I can give is the example in section 8.2.3.6 of the
current SDM (version 048, dated September 2013).  It is a bit more
complex than what you have described above.

> More generally, is the model put forward by Sewell et al. in "x86-TSO:
> A Rigorous and Usable Programmer's Model for x86 Multiprocessors"
> accurate?  This is on pages 4 and 5 here:
>=20
> 	http://www.cl.cam.ac.uk/~pes20/weakmemory/cacm.pdf

I think for Intel to give that one a formal stamp of approval would take
some serious analysis.

	-hpa

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
