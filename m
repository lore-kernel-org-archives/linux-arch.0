From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v8 10/10] pvqspinlock, x86: Enable qspinlock PV support
 for XEN
Date: Wed, 2 Apr 2014 10:39:32 -0400
Message-ID: <20140402143932.GA13097@phenom.dumpdata.com>
References: <1396445259-27670-1-git-send-email-Waiman.Long@hp.com>
 <1396445259-27670-11-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1396445259-27670-11-git-send-email-Waiman.Long@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
List-Id: linux-arch.vger.kernel.org

> diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
> index a70fdeb..451e392 100644
> --- a/kernel/Kconfig.locks
> +++ b/kernel/Kconfig.locks
> @@ -229,4 +229,4 @@ config ARCH_USE_QUEUE_SPINLOCK
>  
>  config QUEUE_SPINLOCK
>  	def_bool y if ARCH_USE_QUEUE_SPINLOCK
> -	depends on SMP && (!PARAVIRT_SPINLOCKS || !XEN)
> +	depends on SMP

If I read this correctly that means you cannot select any more the old
ticketlocks? As in, if you select CONFIG_PARAVIRT on X86 it will automatically
select ARCH_USE_QUEUE_SPINLOCK which will then enable this by default?

Should the 'def_bool' be selectable?

> -- 
> 1.7.1
> 
