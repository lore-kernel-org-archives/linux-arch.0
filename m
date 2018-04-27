From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 4/7] kprobes: Replace %p with other pointer types
Date: Fri, 27 Apr 2018 08:56:36 +0200
Message-ID: <20180427065636.ells635z7cw4b4oz@gmail.com>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
 <152481130062.22588.10747314456340608852.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <152481130062.22588.10747314456340608852.stgit@devbox>
Sender: stable-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* Masami Hiramatsu <mhiramat@kernel.org> wrote:

> @@ -712,7 +712,7 @@ static void reuse_unused_kprobe(struct kprobe *ap)
>  	op = container_of(ap, struct optimized_kprobe, kp);
>  	if (unlikely(list_empty(&op->list)))
>  		printk(KERN_WARNING "Warning: found a stray unused "
> -			"aggrprobe@%p\n", ap->addr);
> +			"aggrprobe@%pS\n", ap->addr);

Is this a kernel bug? If yes then please convert this to a WARN_ON_ONCE() that 
doesn't print any kernel addresses.

>  	/* Enable the probe again */
>  	ap->flags &= ~KPROBE_FLAG_DISABLED;
>  	/* Optimize it again (remove from op->list) */
> @@ -985,7 +985,8 @@ static int arm_kprobe_ftrace(struct kprobe *p)
>  	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
>  				   (unsigned long)p->addr, 0, 0);
>  	if (ret) {
> -		pr_debug("Failed to arm kprobe-ftrace at %p (%d)\n", p->addr, ret);
> +		pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
> +			 p->addr, ret);
>  		return ret;

Can this happen during normal use? If yes then just remove the warning message.

>  	}
>  
> @@ -1025,7 +1026,8 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
>  
>  	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
>  			   (unsigned long)p->addr, 1, 0);
> -	WARN(ret < 0, "Failed to disarm kprobe-ftrace at %p (%d)\n", p->addr, ret);
> +	WARN(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
> +	     p->addr, ret);

As this is a signal of a kernel bug, just convert this to a regular WARN_ONCE() 
that doesn't print any kernel addresses.

> +/* Caller must NOT call this in usual path. This is only for critical case */
>  void dump_kprobe(struct kprobe *kp)
>  {
> -	printk(KERN_WARNING "Dumping kprobe:\n");
> -	printk(KERN_WARNING "Name: %s\nAddress: %p\nOffset: %x\n",
> -	       kp->symbol_name, kp->addr, kp->offset);
> +	pr_err("Dumping kprobe:\n");
> +	pr_err("Name: %s\nOffset: %x\nAddress: %pS\n",
> +	       kp->symbol_name, kp->offset, kp->addr);

No, this function should just go away and be replaced by a WARN() in 
reenter_kprobe().

Thanks,

	Ingo
