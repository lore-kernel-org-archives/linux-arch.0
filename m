From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] tracing: add support for tracing MMIO helpers
Date: Tue, 26 Apr 2016 21:14:47 +0200
Message-ID: <6253918.VUpbMrMy7R@wuerfel>
References: <1461697482-32406-1-git-send-email-rabin@rab.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:55252 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752236AbcDZTPo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2016 15:15:44 -0400
In-Reply-To: <1461697482-32406-1-git-send-email-rabin@rab.in>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rabin Vincent <rabin@rab.in>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 26 April 2016 21:04:42 Rabin Vincent wrote:
> Add support for tracing the MMIO helpers readl()/writel() (and their
> variants), for use while developing and debugging device drivers.
> 
> The address and the value are saved along with the C expressions used in
> the driver when calling these MMIO access functions, leading to a trace
> of the driver's interactions with the hardware's registers:

This seems like a very useful feature
 
> We do not globally replace the MMIO helpers.  Instead, tracing must be
> explicitly enabled in the required driver source files by #defining
> TRACE_MMIO_HELPERS at the top of the file.
> 
> The support is added via <asm-generic/io.h> and as such is only
> available on the archs which use that header.

Why that limitation? I think only few architectures use it. Maybe
at least enable it for x86 as well?

> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index e45db6b0d878..feca834436c5 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -372,6 +372,22 @@ config STACK_TRACER
>  
>  	  Say N if unsure.
>  
> +config TRACE_MMIO_HELPERS
> +       bool "Support for tracing MMIO helpers"
> +       select GENERIC_TRACER

How about putting a whitelist of architectures here that are including
the necessary definitions? Or better, a HAVE_TRACE_MMIO_HELPERS
symbol that gets selected by architectures and that this depends on?

> diff --git a/kernel/trace/trace_mmio_helpers.c b/kernel/trace/trace_mmio_helpers.c
> new file mode 100644
> index 000000000000..dbd8f725e7b8
> --- /dev/null
> +++ b/kernel/trace/trace_mmio_helpers.c
> @@ -0,0 +1,45 @@
> +#define TRACE_MMIO_HELPERS
> +#include <linux/io.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/mmio.h>
> +
> +#define DEFINE_MMIO_RW_TRACE(c, type)					\
> +type read ## c ## _trace(const volatile void __iomem *addr,		\
> +		    const char *addrexp, bool relaxed,			\
> +		    unsigned long caller)				\
> +{									\
> +	type value;							\
> +									\
> +	if (relaxed)							\
> +		value = read ## c ## _relaxed_notrace(addr);		\
> +	else								\
> +		value = read ## c ## _notrace(addr);			\
> +									\
> +	trace_mmio_read(addr, addrexp, value,				\
> +			sizeof(value), relaxed, caller);		\
> +									\
> +	return value;							\
> +}									\
> +									\

We have a number of other accessors that are commonly used:

{ioread,iowrite}{8,16,32,64}{,_be}
{in,out}{b,w,l,q}
{hi_lo_,lo_hi_}{read,write}q

Other than having to write up the code for all of them, are the
strong reasons for defining only the subset you currently have?

	Arnd
