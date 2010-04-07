From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] sparc64: Implement local_irq_save_nmi().
Date: Wed, 07 Apr 2010 08:52:26 +0200
Message-ID: <1270623146.5109.532.camel@twins>
References: <20100406.163955.28809295.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20100406.163955.28809295.davem@davemloft.net>
Sender: sparclinux-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: mingo@elte.hu, acme@redhat.com, paulus@samba.org, efault@gmx.de, fweisbec@gmail.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 2010-04-06 at 16:39 -0700, David Miller wrote:
> It disables up to PIL_NMI instead of just PIL_NORMAL_MAX.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> diff --git a/arch/sparc/include/asm/irqflags_64.h b/arch/sparc/include/asm/irqflags_64.h
> index 8b49bf9..fa1e00e 100644
> --- a/arch/sparc/include/asm/irqflags_64.h
> +++ b/arch/sparc/include/asm/irqflags_64.h
> @@ -49,6 +49,16 @@ static inline void raw_local_irq_disable(void)
>  	);
>  }
>  
> +static inline void raw_local_irq_disable_nmi(void)
> +{
> +	__asm__ __volatile__(
> +		"wrpr	%0, %%pil"
> +		: /* no outputs */
> +		: "i" (PIL_NMI)
> +		: "memory"
> +	);
> +}
> +

Isn't this wrong when used from !NMI context?

Should this thing do something like:

  if (rdpr() < PIL_NORMAL_MAX)
    wrpr(PIL_NORMAL_MAX);

so that it only disables IRQs, but doesn't enable NMIs.
