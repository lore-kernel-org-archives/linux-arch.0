From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 0/8] Rework READ_ONCE() to improve codegen
Date: Mon, 13 Jan 2020 14:03:41 +0100
Message-ID: <CAK8P3a1Qvz+HB-ROy2cmtPtE2m113iBhWbdibpdQ4ycNp9u=ng@mail.gmail.com>
References: <20200110165636.28035-1-will@kernel.org> <CAK8P3a1UzSOHdihbzOn5CZZfo1kvCdj7BAzdQE=PgYS9GBF4Hw@mail.gmail.com>
 <CAHk-=wggv_LmrL85Ez0TLcAku8iz05VZmJxDGo=2aP2VvQtrsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wggv_LmrL85Ez0TLcAku8iz05VZmJxDGo=2aP2VvQtrsA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 10, 2020 at 9:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jan 10, 2020 at 11:47 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Isn't the read_barrier_depends() the only reason for actually needing
> > the temporary local variable that must not be volatile?
> >
> > If you make alpha provide its own READ_ONCE() as the first
> > step, it would seem that the rest of the series gets much easier
> > as the others can go back to the simple statement from your
>
> Hmm.. The union still would cause that "take the address of a volatile
> thing on the stack" problem, wouldn't it? And that was what caused
> most of the issues.

Ah, I was missing that there is still the union in smp_load_acquire(),
I only saw that the one in READ_ONCE() is needed only on alpha.

The number of files using smp_load_acquire() is fairly small though,
so we could consider changing it to pass both source and destination
as macro arguments and use typeof(dest) instad of typeof(source)
to avoid the volatile pointer access.

> I think the _real_ issue is how KASAN forces that odd pair of inline
> functions in order to have the annotations on the accesses.

But the inline functions (I assume you mean __write_once_size
and __read_once_size_nocheck?) are completely removed after
Will's series, so those no longer cause harm, right?

      Arnd
