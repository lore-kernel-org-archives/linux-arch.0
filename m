From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v4 32/71] ARC: [DeviceTree] Basic support
Date: Wed, 30 Jan 2013 11:08:03 +0000
Message-ID: <5108FF13.7080404@imgtec.com>
References: <5107CDD3.3050502@gmail.com> <1359467723-4269-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:41707 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755111Ab3A3LIM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Jan 2013 06:08:12 -0500
In-Reply-To: <1359467723-4269-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: robherring2@gmail.com, inux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>

Hi Vineet

On 29/01/13 13:55, Vineet Gupta wrote:
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index a353849..7666857 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -24,8 +24,11 @@ config ARC

> +	select OF

> diff --git a/arch/arc/Makefile b/arch/arc/Makefile
> index 4d52a3b..29b5fcd 100644
> --- a/arch/arc/Makefile
> +++ b/arch/arc/Makefile
> @@ -83,6 +83,9 @@ head-y		:= arch/arc/kernel/head.o

> +# w/o this dtb won't embed into kernel binary
> +core-y		+= arch/arc/boot/dts/

> diff --git a/arch/arc/boot/dts/Makefile b/arch/arc/boot/dts/Makefile
> new file mode 100644
> index 0000000..ea3114c
> --- /dev/null
> +++ b/arch/arc/boot/dts/Makefile
> @@ -0,0 +1,17 @@
> +ifeq ($(CONFIG_OF),y)

This doesn't seem necessary since you select OF (and if you didn't you
could put core-$(CONFIG_OF) in the main Makefile.

> diff --git a/arch/arc/kernel/Makefile b/arch/arc/kernel/Makefile
> index 6d83431..eeab7c79 100644
> --- a/arch/arc/kernel/Makefile
> +++ b/arch/arc/kernel/Makefile
> @@ -7,6 +7,7 @@
>  
>  obj-y	:= arcksyms.o setup.o irq.o time.o reset.o ptrace.o entry.o process.o
>  obj-y	+= signal.o traps.o sys.o troubleshoot.o stacktrace.o clk.o
> +obj-y   += devtree.o

nit: whitespace is inconsistent here.

> diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
> index 82ac206..27aebd6 100644
> --- a/arch/arc/kernel/setup.c
> +++ b/arch/arc/kernel/setup.c

> @@ -71,6 +76,8 @@ void __init setup_arch(char **cmdline_p)
>  	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
>  	*cmdline_p = command_line;
>  
> +	rc = setup_machine_fdt(__dtb_start);

Should this panic or something if it fails? Actually I see it does in
your -next branch, so I guess it's fixed in a later patch.

So other than the stuff above:
Reviewed-by: James Hogan <james.hogan@imgtec.com>
