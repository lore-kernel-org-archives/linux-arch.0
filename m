From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 01/20] asm-generic/mmiowb: Add generic implementation
 of mmiowb() tracking
Date: Tue, 26 Feb 2019 11:02:50 -0800
Message-ID: <CAHk-=wjx89RpPw6EV4fwSDAPbQcs=-2a4oM9N94saa9hemNbmw@mail.gmail.com>
References: <20190222185026.10973-1-will.deacon@arm.com> <20190222185026.10973-2-will.deacon@arm.com>
 <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
 <20190226182624.GC28709@fuggles.cambridge.arm.com> <20190226183335.GN2861@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226183335.GN2861@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 26, 2019 at 10:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Arguably we could fix that for __this_cpu_xchg(), which isn't IRQ-safe.

Yeah, I guess x86 _should_ really do __this_cpu_xchg() as just a
read-write pair.

In general, a read-write pair is probably always the right thing to
do, and the only reason we can't just do it in an
architecture-independent way is that we'd want to avoid doing the
address generation twice (for architectures where that is an issue).

                  Linus
