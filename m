Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:40857 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265204AbUELTuH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 12 May 2004 15:50:07 -0400
Date: Wed, 12 May 2004 12:49:10 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: Implement print_modules()
Message-Id: <20040512124910.0af06300.akpm@osdl.org>
In-Reply-To: <20040512173905.GA24382@devserv.devel.redhat.com>
References: <20040512173905.GA24382@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Arjan van de Ven <arjanv@redhat.com>
Cc: rusty@rustycorp.com.au, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Arjan van de Ven <arjanv@redhat.com> wrote:
>
> Hi,
> 
> the patch below resolves the "Not Yet Implemented" print_modules() thing. 
> This is a really useful feature for distros; it allows us to do statistical
> analysis on which modules are present how often in oopses compared to how
> often they are used normally.
> In addition it helps to spot candidates for certain bugs without having to
> go back to the customer asking for this information.
> 

OK.  Only three architectures are calling print_modules() at this time. 
arch maintainers should consider adding a call.  We have a stub at present
so the change can go in any time.


> 
> diff -purN linux-2.6.6/include/linux/module.h linux/include/linux/module.h
> --- linux-2.6.6/include/linux/module.h	2004-05-10 04:33:10.000000000 +0200
> +++ linux/include/linux/module.h	2004-05-12 16:40:40.746460936 +0200
> @@ -22,7 +22,7 @@
>  
>  /* Not Yet Implemented */
>  #define MODULE_SUPPORTED_DEVICE(name)
> -#define print_modules()
> +extern void print_modules(void);
>  
>  /* v850 toolchain uses a `_' prefix for all user symbols */
>  #ifndef MODULE_SYMBOL_PREFIX
> diff -purN linux-2.6.6/kernel/module.c linux/kernel/module.c
> --- linux-2.6.6/kernel/module.c	2004-05-12 15:41:30.030251848 +0200
> +++ linux/kernel/module.c	2004-05-12 16:40:26.141681200 +0200
> @@ -1886,6 +1886,25 @@ struct module *module_text_address(unsig
>  	return NULL;
>  }
>  
> +void print_modules(void)
> +{
> +	unsigned long flags;
> +	struct module *mod;
> +	
> +	local_irq_save(flags);
> +	if (!spin_trylock(&modlist_lock)) {
> +		local_irq_restore(flags);
> +		return;
> +	}
> +	printk("Modules linked in: ");
> +	list_for_each_entry(mod, &modules, list) {
> +		printk("%s ",mod->name);
> +	}
> +	printk("\n");
> +	spin_unlock(&modlist_lock);
> +	local_irq_restore(flags);
> +}
> +
>  #ifdef CONFIG_MODVERSIONS
>  /* Generate the signature for struct module here, too, for modversions. */
>  void struct_module(struct module *mod) { return; }
