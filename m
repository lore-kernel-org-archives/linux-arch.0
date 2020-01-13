From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/8] compiler/gcc: Emit build-time warning for GCC
 prior to version 4.8
Date: Mon, 13 Jan 2020 15:39:45 +0100
Message-ID: <CAK8P3a1t9757M5CRKNX_X+T9VuLX+5=z5_845rLJGTG50RogXA@mail.gmail.com>
References: <20200110165636.28035-1-will@kernel.org> <20200110165636.28035-2-will@kernel.org>
 <CAK8P3a3ueJ_rQc-1JTg=3N0JSuY9BduJ6FrrPFG1K2FWVzJdfA@mail.gmail.com> <8fe4f81699517758b44afbe0e1a53bc080f64a62.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8fe4f81699517758b44afbe0e1a53bc080f64a62.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 10, 2020 at 6:54 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2020-01-10 at 18:35 +0100, Arnd Bergmann wrote:
> > On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
> > > Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
> > > discarding the 'volatile' qualifier:
> > >
> > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> > >
> > > We've been working around this using some nasty hacks which make
> > > READ_ONCE() both horribly complicated and also prevent us from enforcing
> > > that it is only used on scalar types. Since GCC 4.8 is pretty old for
> > > kernel builds now, emit a warning if we detect it during the build.
> >
> > No objection to recommending gcc-4.8, but I think this should either
> > just warn once during the kernel build instead of for every file, or
> > it should become a hard requirement.
>
> It might as well be a hard requirement as
> gcc 4.8.0 is already nearly 7 years old.
>
> gcc 4.6.0 released 2011-03-25
> gcc 4.8.0 released 2013-03-22
>
> Perhaps there are exceedingly few to zero new
> instances using gcc compiler versions < 4.8

The last time we had this discussion, the result was that gcc-4.8 is
probably ok as a minimum version, but moving to 5.1+ (from 2015)
was not an obvious choice:

https://www.spinics.net/lists/linux-kbuild/msg23648.html

If nobody complains about the move to 4.8, we can try moving to
gcc-5.1 and GNU99/GNU11 next year  ;-)

       Arnd
