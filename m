From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] asm-generic/gpio.h: merge basic gpiolib wrappers
Date: Thu, 27 Oct 2011 14:53:53 +0100
Message-ID: <20111027135353.GM19187@n2100.arm.linux.org.uk>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com> <1319720503-3183-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1319720503-3183-1-git-send-email-vapier@gentoo.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Jonas Bonn <jonas@southpole.se>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 27, 2011 at 09:01:43AM -0400, Mike Frysinger wrote:
> diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
> index 11ad0bf..741efb2 100644
> --- a/arch/arm/include/asm/gpio.h
> +++ b/arch/arm/include/asm/gpio.h
> @@ -5,14 +5,15 @@
>  #include <mach/gpio.h>
>  
>  #ifndef __ARM_GPIOLIB_COMPLEX
> +/* assume the mach has defined this */
> +#ifndef irq_to_gpio
> +#define irq_to_gpio irq_to_gpio
> +#endif

Oh, this isn't a valid assumption either - it's far from valid.  Those
sub-architectures which don't define __ARM_GPIOLIB_COMPLEX probably don't
define any kind of irq_to_gpio function by any means.  Some of our
mach/gpio.h header files for sub-architectures using entirely gpiolib
are entirely empty - and we want them to stay that way.
