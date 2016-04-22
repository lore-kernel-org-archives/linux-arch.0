From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC][PATCH 27/31] locking: Remove linux/atomic.h:atomic_fetch_or
Date: Fri, 22 Apr 2016 14:02:56 +0100
Message-ID: <20160422130256.GG10289@arm.com>
References: <20160422090413.393652501@infradead.org>
 <20160422093924.799805337@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33935 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbcDVNDE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 22 Apr 2016 09:03:04 -0400
Content-Disposition: inline
In-Reply-To: <20160422093924.799805337@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com

On Fri, Apr 22, 2016 at 11:04:40AM +0200, Peter Zijlstra wrote:
> Since all architectures have this implemented natively, remove this
> now dead code.
> 
> 
> 
> 
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/alpha/include/asm/atomic.h    |    2 --
>  arch/arc/include/asm/atomic.h      |    2 --
>  arch/arm/include/asm/atomic.h      |    2 --
>  arch/arm64/include/asm/atomic.h    |    2 --
>  arch/avr32/include/asm/atomic.h    |    2 --
>  arch/frv/include/asm/atomic.h      |    2 --
>  arch/h8300/include/asm/atomic.h    |    2 --
>  arch/hexagon/include/asm/atomic.h  |    2 --
>  arch/m32r/include/asm/atomic.h     |    2 --
>  arch/m68k/include/asm/atomic.h     |    2 --
>  arch/metag/include/asm/atomic.h    |    2 --
>  arch/mips/include/asm/atomic.h     |    2 --
>  arch/mn10300/include/asm/atomic.h  |    2 --
>  arch/parisc/include/asm/atomic.h   |    2 --
>  arch/s390/include/asm/atomic.h     |    2 --
>  arch/sh/include/asm/atomic.h       |    2 --
>  arch/sparc/include/asm/atomic.h    |    1 -
>  arch/sparc/include/asm/atomic_32.h |    2 --
>  arch/tile/include/asm/atomic.h     |    2 --
>  arch/x86/include/asm/atomic.h      |    2 --
>  arch/xtensa/include/asm/atomic.h   |    2 --
>  include/asm-generic/atomic.h       |    2 --
>  include/linux/atomic.h             |   21 ---------------------
>  23 files changed, 64 deletions(-)
> 
> --- a/arch/alpha/include/asm/atomic.h
> +++ b/arch/alpha/include/asm/atomic.h
> @@ -155,8 +155,6 @@ ATOMIC_OPS(sub)
>  #define atomic_andnot atomic_andnot
>  #define atomic64_andnot atomic64_andnot
>  
> -#define atomic_fetch_or atomic_fetch_or
> -
>  #undef ATOMIC_OPS
>  #define ATOMIC_OPS(op, asm)						\
>  	ATOMIC_OP(op, asm)						\
> --- a/arch/arc/include/asm/atomic.h
> +++ b/arch/arc/include/asm/atomic.h
> @@ -226,8 +226,6 @@ ATOMIC_OPS(sub, -=, sub)
>  
>  #define atomic_andnot atomic_andnot
>  
> -#define atomic_fetch_or atomic_fetch_or
> -
>  #undef ATOMIC_OPS
>  #define ATOMIC_OPS(op, c_op, asm_op)					\
>  	ATOMIC_OP(op, c_op, asm_op)					\
> --- a/arch/arm/include/asm/atomic.h
> +++ b/arch/arm/include/asm/atomic.h
> @@ -237,8 +237,6 @@ ATOMIC_OPS(sub, -=, sub)
>  
>  #define atomic_andnot atomic_andnot
>  
> -#define atomic_fetch_or atomic_fetch_or
> -
>  #undef ATOMIC_OPS
>  #define ATOMIC_OPS(op, c_op, asm_op)					\
>  	ATOMIC_OP(op, c_op, asm_op)					\
> --- a/arch/arm64/include/asm/atomic.h
> +++ b/arch/arm64/include/asm/atomic.h
> @@ -128,8 +128,6 @@
>  #define __atomic_add_unless(v, a, u)	___atomic_add_unless(v, a, u,)
>  #define atomic_andnot			atomic_andnot
>  
> -#define atomic_fetch_or atomic_fetch_or

For some reason, you added this twice to our atomic.h, so there's still
one left after this patch.

Will
