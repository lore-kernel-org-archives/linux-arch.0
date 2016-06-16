From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -v2 14/33] locking,m68k: Implement
 atomic_fetch_{add,sub,and,or,xor}()
Date: Thu, 16 Jun 2016 16:35:30 +0200
Message-ID: <20160616143530.GG30921@twins.programming.kicks-ass.net>
References: <20160531101925.702692792@infradead.org>
 <20160531102642.333689893@infradead.org>
 <CAMuHMdXG4veEOqr5vcZQEQH55=CT6CPXOfqrc_m=fpXEseAdLA@mail.gmail.com>
 <20160616101309.GD30921@twins.programming.kicks-ass.net>
 <mvmk2hpxq1a.fsf@hawking.suse.de>
 <20160616124949.GF30921@twins.programming.kicks-ass.net>
 <mvma8ilxpl6.fsf@hawking.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <mvma8ilxpl6.fsf@hawking.suse.de>
Sender: linux-m68k-owner@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, boqun.feng@gmail.com, waiman.long@hpe.com, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>Ja
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 16, 2016 at 02:53:09PM +0200, Andreas Schwab wrote:
> Peter Zijlstra <peterz@infradead.org> writes:

> > OK, care to elucidate? Clearly I need help reading this.
> 
> grep '2.*atomic_read'

Much thanks to your detailed answer I found yet another obscure inline
asm syntax 'feature'.

So the "2" input operand actually sets the value of "=&d" (tmp), how
creative...

I would find:

#define ATOMIC_OP_RETURN(op, c_op, asm_op)                              \
static inline int atomic_##op##_return(int i, atomic_t *v)              \
{                                                                       \
        int t, tmp = atomic_read(v);                                    \
                                                                        \
        __asm__ __volatile__(                                           \
                        "1:     movel %2,%1\n"                          \
                        "       " #asm_op "l %3,%1\n"                   \
                        "       casl %2,%1,%0\n"                        \
                        "       jne 1b"                                 \
                        : "+m" (*v), "=&d" (t), "+d" (tmp)              \
                        : "g" (i));                                     \
        return t;                                                       \
}

Much more obvious.

But you're right, it seems to be sorted. I'll queue a patch removing
that comment.

Thanks!
