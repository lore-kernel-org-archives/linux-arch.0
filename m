From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 01/20] asm-generic/mmiowb: Add generic implementation
 of mmiowb() tracking
Date: Fri, 22 Feb 2019 13:55:20 -0800
Message-ID: <CAHk-=whK=Pb9QZhYkqFGUjK1Sas620qjO1Y_EzSBiHSXxJfTYQ@mail.gmail.com>
References: <20190222185026.10973-1-will.deacon@arm.com> <20190222185026.10973-2-will.deacon@arm.com>
 <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 22, 2019 at 1:49 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The case we want to go fast is the spin-lock and unlock case, not the
> "set pending" case.
>
> And the way you implemented this, it's exactly the wrong way around.

Oh, one more comment: couldn't we make that mmiowb flag be right next
to the preemption count?

Because that's the common case anyway, where a spinlock increments the
preemption count too. If we put the mmiowb state in the same
cacheline, we don't cause extra cache effects, which is what really
matters, I guess.

I realize this is somewhat inconvenient, because some architectures
put preempt count in the thread structure, and others do it as a
percpu variable. But maybe the architecture could just declare where
the mmiowb state is?

                 Linus
