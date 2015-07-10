From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFC][PATCH 19/24] s390: Provide atomic_{or,xor,and}
Date: Fri, 10 Jul 2015 09:17:09 +0200
Message-ID: <20150710071709.GA3905@osiris>
References: <20150709172855.564686637@infradead.org>
 <20150709175309.831326362@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:50430 "EHLO
	e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbbGJHRS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2015 03:17:18 -0400
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Fri, 10 Jul 2015 08:17:16 +0100
Content-Disposition: inline
In-Reply-To: <20150709175309.831326362@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org

On Thu, Jul 09, 2015 at 07:29:14PM +0200, Peter Zijlstra wrote:
> Implement atomic logic ops -- atomic_{or,xor,and}.
> 
> These will replace the atomic_{set,clear}_mask functions that are
> available on some archs.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/s390/include/asm/atomic.h |   45 ++++++++++++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 14 deletions(-)
> 
> --- a/arch/s390/include/asm/atomic.h
> +++ b/arch/s390/include/asm/atomic.h
> @@ -28,6 +28,7 @@
>  #define __ATOMIC_AND	"lan"
>  #define __ATOMIC_ADD	"laa"
>  #define __ATOMIC_BARRIER "bcr	14,0\n"
> +#define __ATOMIC_XOR	"lax"
> 
>  #define __ATOMIC_LOOP(ptr, op_val, op_string, __barrier)		\
>  ({									\
> @@ -50,6 +51,7 @@
>  #define __ATOMIC_AND	"nr"
>  #define __ATOMIC_ADD	"ar"
>  #define __ATOMIC_BARRIER "\n"
> +#define __ATOMIC_XOR	"xr"

Would you mind moving the two XOR define above the BARRIER?
Just to keep it consistent with ATOMIC64 stuff within this patch ;)

>  #define __ATOMIC_LOOP(ptr, op_val, op_string, __barrier)		\
>  ({									\
> @@ -118,14 +120,26 @@ static inline void atomic_add(int i, ato
>  #define atomic_dec_return(_v)		atomic_sub_return(1, _v)
>  #define atomic_dec_and_test(_v)		(atomic_sub_return(1, _v) == 0)
> 
> -static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
> +#define ATOMIC_OP(op, OP)						\
> +static inline void atomic_##op(int i, atomic_t *v)			\
> +{									\
> +	__ATOMIC_LOOP(v, i, __ATOMIC_##OP, __ATOMIC_NO_BARRIER);	\
> +}
> +
> +ATOMIC_OP(and, AND)
> +ATOMIC_OP(or, OR)
> +ATOMIC_OP(xor, XOR)
> +
> +#undef ATOMIC_OP
> +
> +static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
>  {
> -	__ATOMIC_LOOP(v, ~mask, __ATOMIC_AND, __ATOMIC_NO_BARRIER);
> +	atomic_and(~mask, v);
>  }
> 
> -static inline void atomic_set_mask(unsigned int mask, atomic_t *v)
> +static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
>  {
> -	__ATOMIC_LOOP(v, mask, __ATOMIC_OR, __ATOMIC_NO_BARRIER);
> +	atomic_or(mask, v);
>  }

If you insist on the __deprecated (no problem with that), I'd like to apply
your patch to the s390 tree so I can convert all users.
I would like to avoid to see tons of warnings.

Besides that:

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
