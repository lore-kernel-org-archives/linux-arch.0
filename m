From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] printk: Only unregister boot consoles when
 necessary
Date: Thu, 5 Nov 2015 03:05:43 -0800
Message-ID: <20151105030543.84877221.akpm@linux-foundation.org>
References: <1446107167-7001-1-git-send-email-thierry.reding@gmail.com>
	<1446107167-7001-2-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57824 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031209AbbKELCX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2015 06:02:23 -0500
In-Reply-To: <1446107167-7001-2-git-send-email-thierry.reding@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 29 Oct 2015 09:26:07 +0100 Thierry Reding <thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
> 
> Boot consoles are typically replaced by proper consoles during the boot
> process. This can be problematic if the boot console data is part of the
> init section that is reclaimed late during boot. If the proper console
> does not register before this point in time, the boot console will need
> to be removed (so that the freed memory is not accessed), leaving the
> system without output for some time.
> 
> There are various reasons why the proper console may not register early
> enough, such as deferred probe or the driver being a loadable module. If
> that happens, there is some amount of time where no console messages are
> visible to the user, which in turn can mean that they won't see crashes
> or other potentially useful information.
> 
> To avoid this situation, only remove the boot console when it resides in
> the init section. Code exists to replace the boot console by the proper
> console when it is registered, keeping a seamless transition between the
> boot and proper consoles.

OK.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -48,6 +48,7 @@
>  #include <linux/uio.h>
>  
>  #include <asm/uaccess.h>
> +#include <asm-generic/sections.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/printk.h>
> @@ -2661,7 +2662,8 @@ static int __init printk_late_init(void)
>  
>  	for_each_console(con) {
>  		if (!keep_bootcon && con->flags & CON_BOOT) {
> -			unregister_console(con);
> +			if (init_section_contains(con, sizeof(*con)))
> +				unregister_console(con);
>  		}

It's a bit hacky.  It might be nicer to add a new CON_foo flag
specifying the treatment but a) there are waaay too many consoles in
the kernel and b) it's fragile to require every register_console()
caller to remember to do this, and to maintain the CON_foo as code
evolves.  So I guess we go with hacky.


There is no way in which a reader can work out why this code is here,
without forcing them to go off and wrestle with git-blame.  Can we
please add a comment to save them from this fate?
