From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Wed, 7 Jun 2017 18:35:02 +0200
Message-ID: <20170607163502.roefzqivvkywb236@hirez.programming.kicks-ass.net>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-14-palmer@dabbelt.com>
 <20170607120613.ocbqpfajxj6eedbt@hirez.programming.kicks-ass.net>
 <20170607123627.ofjobsxxv5ut776m@hirez.programming.kicks-ass.net>
 <20170607125850.zwh3w5s5ce54jcrz@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170607125850.zwh3w5s5ce54jcrz@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net, albert@sifive.com, patches@groups.riscv.org, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 07, 2017 at 02:58:50PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 07, 2017 at 02:36:27PM +0200, Peter Zijlstra wrote:
> > Which (pending the sub confusion) will generate the entire set of:
> > 
> >  atomic_add, atomic_add_return{_relaxed,_acquire,_release,} atomic_fetch_add{_relaxed,_acquire,_release,}
> >  atomic_sub, atomic_sub_return{_relaxed,_acquire,_release,} atomic_fetch_sub{_relaxed,_acquire,_release,}
> > 
> >  atomic_and, atomic_fetch_and{_relaxed,_acquire,_release,}
> >  atomic_or,  atomic_fetch_or{_relaxed,_acquire,_release,}
> >  atomic_xor, atomic_fetch_xor{_relaxed,_acquire,_release,}
> > 
> 
> Another approach would be to override __atomic_op_{acquire,release} and
> use things like:
> 
> 	"FENCE r,rw" -- (load) ACQUIRE
> 	"FENCE rw,w" -- (store) RELEASE
> 
> And then you only need to provide _relaxed atomics.
> 
> Also, and I didn't check for that, you need to provide:
> 
> smp_load_acquire(), smp_store_release(), atomic_read_acquire(),
> atomic_store_release().

Also, you probably need to provide smp_mb__before_spinlock(), but also
see:

  https://lkml.kernel.org/r/20170607161501.819948352@infradead.org
