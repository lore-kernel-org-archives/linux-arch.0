From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 11/31] nds32: Atomic operations
Date: Mon, 20 Nov 2017 14:29:26 +0000
Message-ID: <20171120142925.GC32488@arm.com>
References: <cover.1510118606.git.green.hu@gmail.com>
 <b13577a068afb71e87e21598f59733f127814f37.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58134 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbdKTO31 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Nov 2017 09:29:27 -0500
Content-Disposition: inline
In-Reply-To: <b13577a068afb71e87e21598f59733f127814f37.1510118606.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, Vincent Chen <vincentc@andestech.com>, peterz@infradead.org, paulmck@linux.vnet.ibm.com

Hi Greentime,

On Wed, Nov 08, 2017 at 01:54:59PM +0800, Greentime Hu wrote:
> From: Greentime Hu <greentime@andestech.com>
> 
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> ---
>  arch/nds32/include/asm/futex.h    |  116 ++++++++++++++++++++++++
>  arch/nds32/include/asm/spinlock.h |  178 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 294 insertions(+)
>  create mode 100644 arch/nds32/include/asm/futex.h
>  create mode 100644 arch/nds32/include/asm/spinlock.h

[...]

> +static inline int
> +futex_atomic_cmpxchg_inatomic(u32 * uval, u32 __user * uaddr,
> +			      u32 oldval, u32 newval)
> +{
> +	int ret = 0;
> +	u32 val, tmp, flags;
> +
> +	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
> +		return -EFAULT;
> +
> +	smp_mb();
> +	asm volatile ("       movi    $ta, #0\n"
> +		      "1:     llw     %1, [%6 + $ta]\n"
> +		      "       sub     %3, %1, %4\n"
> +		      "       cmovz   %2, %5, %3\n"
> +		      "       cmovn   %2, %1, %3\n"
> +		      "2:     scw     %2, [%6 + $ta]\n"
> +		      "       beqz    %2, 1b\n"
> +		      "3:\n                   " __futex_atomic_ex_table("%7")
> +		      :"+&r"(ret), "=&r"(val), "=&r"(tmp), "=&r"(flags)
> +		      :"r"(oldval), "r"(newval), "r"(uaddr), "i"(-EFAULT)
> +		      :"$ta", "memory");
> +	smp_mb();
> +
> +	*uval = val;
> +	return ret;
> +}

I see you rely on asm-generic/barrier.h for your barrier definitions, which
suggests that you only need to prevent reordering by the compiler because
you're not SMP. Is that right? If so, using smp_mb() is a little weird.

What about DMA transactions? I imagine you might need some extra
instructions for the mandatory barriers there.

Also:

> +static inline void arch_spin_lock(arch_spinlock_t * lock)
> +{
> +	unsigned long tmp;
> +
> +	__asm__ __volatile__("1:\n"
> +			     "\tllw\t%0, [%1]\n"
> +			     "\tbnez\t%0, 1b\n"
> +			     "\tmovi\t%0, #0x1\n"
> +			     "\tscw\t%0, [%1]\n"
> +			     "\tbeqz\t%0, 1b\n"
> +			     :"=&r"(tmp)
> +			     :"r"(&lock->lock)
> +			     :"memory");
> +}

Here it looks like you're eliding an explicit barrier here because you
already have a "memory" clobber. Can't you do the same for the futex code
above?

Will
