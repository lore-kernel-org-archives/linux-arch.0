From: Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH 5/8] READ_ONCE: Enforce atomicity for
 {READ,WRITE}_ONCE() memory accesses
Date: Mon, 13 Jan 2020 16:16:06 +0000
Message-ID: <20200113161606.GD4458@willie-the-truck>
References: <20200110165636.28035-1-will@kernel.org>
 <20200110165636.28035-6-will@kernel.org>
 <CAK8P3a1pDW7cABLeotZBNTTxLxkQ299wO0OG3AWGyDqJWmQA+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a1pDW7cABLeotZBNTTxLxkQ299wO0OG3AWGyDqJWmQA+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 10, 2020 at 08:24:00PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
> 
> > +/*
> > + * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
> > + * atomicity or dependency ordering guarantees. Note that this may result
> > + * in tears!
> > + */
> > +#define __READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> > +
> 
> This probably allows writing
> 
>        extern int i;
>        __READ_ONCE(i) = 1;
> 
> and not get a warning for it. How about also casting to 'const'?

Well spotted! I'll fold that in.

Will
