From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC][PATCH 01/31] locking: Flip arguments to atomic_fetch_or
Date: Fri, 22 Apr 2016 13:09:38 +0200
Message-ID: <CAMuHMdV79ShATdNZZDWSREpeHEEbSa+UFDynzQRHo63E4L8atw@mail.gmail.com>
References: <20160422090413.393652501@infradead.org>
	<20160422093923.095484070@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160422093923.095484070@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, boqun.feng@gmail.com, waiman.long@hpe.com, =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 22, 2016 at 11:04 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> All the atomic operations have their arguments the wrong way around;

s/wrong/other/?

> make atomic_fetch_or() consistent and flip them.

BTW, there are a few other inconsistencies:

atomic_add_unless()
atomic_cmpxchg()
atomic_inc_not_zero_hint()
atomic_set()
atomic_xchg

git grep "\<atomic_.*atomic_t\>.*\<int\>"

Gr{oetje,eeting}s,

                        Geert
