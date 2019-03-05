From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
Date: Mon, 4 Mar 2019 16:19:58 -0800
Message-ID: <CAHk-=wgbnn7x+i72NqnvXotbxjsk2Ag56Q5YP0OSvhY9sUk7QA@mail.gmail.com>
References: <20190301140348.25175-1-will.deacon@arm.com> <20190301140348.25175-2-will.deacon@arm.com>
 <1551575210.6lwpiqtg5k.astroid@bobo.none> <87ef7n7x9v.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87ef7n7x9v.fsf@concordia.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Yoshinori Sato <ysato@users.sourceforge.j>
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 4, 2019 at 2:24 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Without wading into the rest of the discussion, this does raise an
> interesting point, ie. what about eg. rwlock's?
>
> They're basically equivalent to spinlocks, and so could reasonably be
> expected to have the same behaviour.
>
> But we don't check the io_sync flag in arch_read/write_unlock() etc. and
> both of those use lwsync.

I think technically rwlocks should do the same thing, at least when
they are used for exclusion.

Because of the exclusion argument, we can presubably limit it to just
write_unlock(), although at least in theory I guess you could have
some "one reader does IO, then a writer comes in" situation..

Perhaps more importantly, what about sleeping locks? When they
actually *block*, they get the barrier thanks to the scheduler, but
you can have a nice non-contended sequence that never does that.

I guess the fact that these cases have never even shown up as an issue
means that we could just continue to ignore it.

We could even give that approach some fancy name, and claim it as a
revolutionary new programming paradigm ("ostrich programming" to go
with "agile" and "pair programming").

                    Linus
