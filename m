From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Wed, 7 Jun 2017 14:25:38 +0200
Message-ID: <20170607122538.jy3nps6erhlfi4bh@hirez.programming.kicks-ass.net>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-14-palmer@dabbelt.com>
 <20170607115423.qdhpl5dhtmmq4q4u@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170607115423.qdhpl5dhtmmq4q4u@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net, albert@sifive.com, patches@groups.riscv.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 07, 2017 at 01:54:23PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 06, 2017 at 04:00:03PM -0700, Palmer Dabbelt wrote:
> > +/* Assume that atomic operations are already serializing */
> > +#define smp_mb__before_atomic_dec()	barrier()
> > +#define smp_mb__after_atomic_dec()	barrier()
> > +#define smp_mb__before_atomic_inc()	barrier()
> > +#define smp_mb__after_atomic_inc()	barrier()
> 
> > +#define smp_mb__before_clear_bit()  smp_mb()
> > +#define smp_mb__after_clear_bit()   smp_mb()
> 
> These no longer exist.. Also how can they be different? bitops would use
> the same atomic primitives as regular atomic ops would and would thus
> have the very same implicit ordering.

Your manual states that each atomic instruction (be it AMO or LR/SC)
have two ordering bits: AQ and RL. If neither are set the instruction is
unordered, if either one is set, its either an ACQUIRE or a RELEASE and
if both are set its SC.

So you can in fact make the above happen, however your atomic
implementation does not appear to use ".aq.rl" mnemonics so would be
entirely unordered, just like your bitops.

Therefore the above is just plain wrong and broken.
