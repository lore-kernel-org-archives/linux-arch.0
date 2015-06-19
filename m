From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 22/28] ARCv2: STAR 9000837815 workaround hardware
 exclusive transactions livelock
Date: Fri, 19 Jun 2015 10:59:32 +0100
Message-ID: <20150619095932.GC18017@arm.com>
References: <20150610110234.GH3644@twins.programming.kicks-ass.net>
 <1434707726-32624-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434707726-32624-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Jun 19, 2015 at 10:55:26AM +0100, Vineet Gupta wrote:
> A quad core SMP build could get into hardware livelock with concurrent
> LLOCK/SCOND. Workaround that by adding a PREFETCHW which is serialized by
> SCU (System Coherency Unit). It brings the cache line in Exclusive state
> and makes others invalidate their lines. This gives enough time for
> winner to complete the LLOCK/SCOND, before others can get the line back.
> 
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---
>  arch/arc/include/asm/atomic.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
> index 20b7dc17979e..03484cb4d16d 100644
> --- a/arch/arc/include/asm/atomic.h
> +++ b/arch/arc/include/asm/atomic.h
> @@ -23,13 +23,21 @@
>  
>  #define atomic_set(v, i) (((v)->counter) = (i))
>  
> +#ifdef CONFIG_ISA_ARCV2
> +#define PREFETCHW	"	prefetchw   [%1]	\n"
> +#else
> +#define PREFETCHW
> +#endif
> +
>  #define ATOMIC_OP(op, c_op, asm_op)					\
>  static inline void atomic_##op(int i, atomic_t *v)			\
>  {									\
>  	unsigned int temp;						\
>  									\
>  	__asm__ __volatile__(						\
> -	"1:	llock   %0, [%1]	\n"				\
> +	"1:				\n"				\
> +	PREFETCHW							\
> +	"	llock   %0, [%1]	\n"				\
>  	"	" #asm_op " %0, %0, %2	\n"				\
>  	"	scond   %0, [%1]	\n"				\
>  	"	bnz     1b		\n"				\

Curious, but are you *sure* the prefetch should be *inside* the loop?
On most ll/sc architectures, that's a livelock waiting to happen because
you ping-pong the cache-line around in exclusive state.

Will
