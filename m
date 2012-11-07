From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 14/31] ARC: syscall support
Date: Wed, 7 Nov 2012 14:21:39 +0000
Message-ID: <201211071421.39523.arnd@arndb.de>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <1352281674-2186-15-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57484 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab2KGOVo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Nov 2012 09:21:44 -0500
In-Reply-To: <1352281674-2186-15-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de

On Wednesday 07 November 2012, Vineet Gupta wrote:
> + * Being uClibc based we need some of the deprecated syscalls:
> + * -Not emulated by uClibc at all
> + *     unlink, mkdir,... (needed by Busybox, LTP etc)
> + *     times (needed by LTP pan test harness)
> + * -Not emulated efficiently
> + *     select: emulated using pselect (but extra code to chk usec > 1sec)
> + *
> + * some (send/recv) correctly emulated using (recfrom/sendto) and
> + * some arch specific ones (fork/vfork)can easily be emulated using clone but
> + * thats the price of using common-denominator....
> + */
> +#define __ARCH_WANT_SYSCALL_NO_AT
> +#define __ARCH_WANT_SYSCALL_NO_FLAGS
> +#define __ARCH_WANT_SYSCALL_OFF_T
> +#define __ARCH_WANT_SYSCALL_DEPRECATED

I'm pretty sure that this has been solved before, best get in contact with
the maintainers of the openrisc/c6x/hexagon platforms, that probably all
use uClibc without needing these.

You have to remove the legacy calls here.

	Arnd
