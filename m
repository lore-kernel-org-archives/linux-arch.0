From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC][PATCH 04/31] locking,arm: Implement
 atomic{,64}_fetch_{add,sub,and,andnot,or,xor}{,_relaxed,_acquire,_release}()
Date: Fri, 22 Apr 2016 12:35:27 +0100
Message-ID: <20160422113527.GD10289@arm.com>
References: <20160422090413.393652501@infradead.org>
 <20160422093923.293177377@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160422093923.293177377@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 22, 2016 at 11:04:17AM +0200, Peter Zijlstra wrote:
> Implement FETCH-OP atomic primitives, these are very similar to the
> existing OP-RETURN primitives we already have, except they return the
> value of the atomic variable _before_ modification.
> 
> This is especially useful for irreversible operations -- such as
> bitops (because it becomes impossible to reconstruct the state prior
> to modification).
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm/include/asm/atomic.h |  108 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 98 insertions(+), 10 deletions(-)
> 
> --- a/arch/arm/include/asm/atomic.h
> +++ b/arch/arm/include/asm/atomic.h
> @@ -77,8 +77,36 @@ static inline int atomic_##op##_return_r
>  	return result;							\
>  }

[...]

> +static inline long long							\
> +atomic64_fetch_##op##_relaxed(long long i, atomic64_t *v)		\
> +{									\
> +	long long result, val;						\
> +	unsigned long tmp;						\
> +									\
> +	prefetchw(&v->counter);						\
> +									\
> +	__asm__ __volatile__("@ atomic64_fetch_" #op "\n"		\
> +"1:	ldrexd	%0, %H0, [%4]\n"					\
> +"	" #op1 " %Q1, %Q0, %Q5\n"					\
> +"	" #op2 " %R1, %R0, %R5\n"					\
> +"	strexd	%2, %1, %H0, [%4]\n"					\

You want %H1 here.

With that:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
