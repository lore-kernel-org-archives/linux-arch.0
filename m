From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
Date: Mon, 4 Mar 2019 16:33:22 -0800
Message-ID: <CAHk-=wi4aAzhvPBon1wLS0zdzzg-_GQhkteBiQZE8KuotThToQ@mail.gmail.com>
References: <20190301140348.25175-1-will.deacon@arm.com> <20190301140348.25175-2-will.deacon@arm.com>
 <1551575210.6lwpiqtg5k.astroid@bobo.none> <CAHk-=whxaYGTmHyoWeegL=ihHMDW_FJehUJVN_nP++Su=foL+g@mail.gmail.com>
 <1551583190.duzqnmfnvg.astroid@bobo.none> <CAHk-=whVN58nWh29jvXx+X-Yx9dCC6BeAZOtKak+d01y_UVg=A@mail.gmail.com>
 <1551606848.8cceyn7nhv.astroid@bobo.none> <CAHk-=wi9ZnP_17qwPB_b3hJ+C7DP3oxcRAPuDBCoEbe2QrbQew@mail.gmail.com>
 <1551743521.hogpbicfcz.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551743521.hogpbicfcz.astroid@bobo.none>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>, Yoshinori Sato <ysato@users.sourceforge>
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 4, 2019 at 4:21 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Well you don't have to talk about it but why do you want me to stop?
> I don't understand. It's an open topic still after this series. I
> can post a new thread about it if that would upset you less, I just
> thought it would kind of fit here because we're talking about mmiowb,
> I'm not trying to derail this series.

Because if anybody is doing lockless programming with IO, they deserve
whatever they get.

In other words, the whole "wmb()" issue is basically not an issue.

We already have rules like:

 - mmio is ordered wrt itself

 - mmio is ordered wrt previous memory ops (because of dma)

and while it turned out that at least alpha had broken those rules at
some point, and we had a discussion about it, that was just a bug.

So there's basically no real reason to ever use "wmb()" with any of
the normal mmio stuff.

Now, we do have __raw_writel() etc, which are explicitly not ordered,
but they also haven't been really standardized. And in fact, people
who use them often seem to want to use them together with various weak
memory remappings.

And yes, "wmb()" has been the traditional way to order those, to the
point where "wmb()" on x86 is actually a "sfence" because once you do
IO on those kinds of unordered mappings, the usual SMP rules go out
the window (a normal "smp_wmb()" is just a compiler barrier on x86).

But notice how this is *entirely* independent of the spinlock issue,
and has absolutely *nothing* to do with the whole mmiowb() thing that
was always about "normal IO vs normal RAM" (due to the ia64 breakage).

                 Linus
