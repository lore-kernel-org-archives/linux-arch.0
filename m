From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 7/7] Fix IRQ flag handling naming
Date: Thu, 26 Aug 2010 18:00:01 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1008261758450.2768@localhost.localdomain>
References: <20100826141110.11132.91931.stgit@warthog.procyon.org.uk>
	<20100826141141.11132.24274.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20100826141141.11132.24274.stgit-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Thu, 26 Aug 2010, David Howells wrote:

> Fix the IRQ flag handling naming.  In linux/irqflags.h under one configuration,
> it maps:
> 
> 	local_irq_enable() -> raw_local_irq_enable()
> 	local_irq_disable() -> raw_local_irq_disable()
> 	local_irq_save() -> raw_local_irq_save()
> 	...
> 
> and under the other configuration, it maps:
> 
> 	raw_local_irq_enable() -> local_irq_enable()
> 	raw_local_irq_disable() -> local_irq_disable()
> 	raw_local_irq_save() -> local_irq_save()
> 	...
> 
> This is quite confusing.  There should be one set of names expected of the
> arch, and this should be wrapped to give another set of names that are expected
> by users of this facility.
> 
> Change this to have the arch provide:
> 
> 	flags = arch_local_save_flags()
> 	flags = arch_local_irq_save()
> 	arch_local_irq_restore(flags)
> 	arch_local_irq_disable()
> 	arch_local_irq_enable()
> 	arch_irqs_disabled_flags(flags)
> 	arch_irqs_disabled()
> 	arch_safe_halt()
> 
> Then linux/irqflags.h wraps these to provide:
> 
> 	raw_local_save_flags(flags)
> 	raw_local_irq_save(flags)
> 	raw_local_irq_restore(flags)
> 	raw_local_irq_disable()
> 	raw_local_irq_enable()
> 	raw_irqs_disabled_flags(flags)
> 	raw_irqs_disabled()
> 	raw_safe_halt()
> 
> with type checking on the flags 'arguments', and then wraps those to provide:
> 
> 	local_save_flags(flags)
> 	local_irq_save(flags)
> 	local_irq_restore(flags)
> 	local_irq_disable()
> 	local_irq_enable()
> 	irqs_disabled_flags(flags)
> 	irqs_disabled()
> 	safe_halt()
> 
> with tracing included if enabled.
> 
> The arch functions can now all be inline functions rather than some of them
> having to be macros.

Nice one.
 
> [Note that this patch only alters X86, FRV, MN10300, ARM and Blackfin at the
>  moment.  The other arches will need altering too as part of this patch].
> 
> Signed-off-by: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Tested-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>

Acked-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
