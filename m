From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Wed, 7 Jun 2017 14:16:11 +0100
Message-ID: <20170607131611.GF30263@arm.com>
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net, albert@sifive.com, patches@groups.riscv.org
List-Id: linux-arch.vger.kernel.org

[sorry, jumping in here because it's the only mail I have relating to
 patch 13]

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

Is there an up-to-date specification for the RISC-V memory model? I looked
at:

https://github.com/riscv/riscv-isa-manual/releases/download/riscv-user-2.2/riscv-spec-v2.2.pdf

but it says:

| 2.7 Memory Model
| This section is out of date as the RISC-V memory model is
| currently under revision to ensure it can efficiently support current
| programming language memory models. The revised base mem- ory model will
| contain further ordering constraints, including at least that loads to the
| same address from the same hart cannot be reordered, and that syntactic data
| dependencies between instructions are respected

which, on the one hand is reassuring (because ignoring dependency ordering is
plain broken), but on the other it doesn't go quite far enough in defining
exactly what constitutes a "syntactic data dependency". The cumulativity of
your fences also needs defining, because I think this was up in the air at some
point and the document above doesn't seem to tackle it (it doesn't seem to
describe what constitutes being a memory of the predecessor or successor sets)

Could you shed some light on this please? We've started relying on RW control
dependencies in semi-recent history, so it's important to get this nailed down.

Thanks,

Will

P.S. You should also totally get your architects to write a formal model ;)
