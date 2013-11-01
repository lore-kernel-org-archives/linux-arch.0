From: Domenico Andreoli <cavokz@gmail.com>
Subject: Re: [PATCH 04/11] MIPS: use the common machine reset handling
Date: Fri, 1 Nov 2013 06:26:14 +0100
Message-ID: <20131101052614.GB28233@glitch>
References: <20131031062708.520968323@linux.com>
 <20131031062959.169063871@linux.com>
 <5273381A.9020103@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:47656 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732Ab3KAF0Y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Nov 2013 01:26:24 -0400
Received: by mail-ea0-f177.google.com with SMTP id f15so1780868eak.8
        for <linux-arch@vger.kernel.org>; Thu, 31 Oct 2013 22:26:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5273381A.9020103@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Domenico Andreoli <domenico.andreoli@linux.com>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org

On Fri, Nov 01, 2013 at 10:41:54AM +0530, Vineet Gupta wrote:
> On 10/31/2013 11:57 AM, Domenico Andreoli wrote:
> > From: Domenico Andreoli <domenico.andreoli@linux.com>
> > 
> > Proof of concept: MIPS as a consumer of the machine reset hooks.
> > 
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-mips@vger.kernel.org
> > Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > ---
> >  arch/mips/kernel/reset.c |    7 +++++++
> >  kernel/power/Kconfig     |    2 +-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > Index: b/arch/mips/kernel/reset.c
> > ===================================================================
> > --- a/arch/mips/kernel/reset.c
> > +++ b/arch/mips/kernel/reset.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/pm.h>
> >  #include <linux/types.h>
> >  #include <linux/reboot.h>
> > +#include <linux/machine_reset.h>
> >  
> >  #include <asm/reboot.h>
> >  
> > @@ -29,16 +30,22 @@ void machine_restart(char *command)
> >  {
> >  	if (_machine_restart)
> >  		_machine_restart(command);
> > +	else
> > +		default_restart(reboot_mode, command);
> >  }
> >  
> >  void machine_halt(void)
> >  {
> >  	if (_machine_halt)
> >  		_machine_halt();
> > +	else
> > +		default_halt();
> >  }
> >  
> >  void machine_power_off(void)
> >  {
> >  	if (pm_power_off)
> >  		pm_power_off();
> > +	else
> > +		default_power_off();
> >  }
> > Index: b/kernel/power/Kconfig
> > ===================================================================
> > --- a/kernel/power/Kconfig
> > +++ b/kernel/power/Kconfig
> > @@ -297,4 +297,4 @@ config CPU_PM
> >  config MACHINE_RESET
> >  	bool
> >  	default n
> > -	depends on ARM || ARM64
> > +	depends on ARM || ARM64 || MIPS
> 
> This particular idiom is frowned upon for new code. As new arches get added this
> list keeps getting bigger and then those who don't need the feature need to add
> the anti dependency. Also in this particular case the dependency is trivial so you
> can just "select" it in arch/*/Kconfig

this dependency guarantees only that the option is available only on the
supported arches.

anyway I've not a strong opinion, I only picked the least invasive solution
I was able to think.

thanks,
Domenico
