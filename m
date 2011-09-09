Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54698 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757534Ab1IIIYH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2011 04:24:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v3 18/36] Hexagon: Add time and timer functions
Date: Fri, 09 Sep 2011 10:23:45 +0200
Message-ID: <8440717.zkZKr0bf7e@wuerfel>
In-Reply-To: <20110909010916.422373448@codeaurora.org>
References: <20110909010847.294039464@codeaurora.org> <20110909010916.422373448@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20110909082345.TgvDBtb_o1JVJj9m0c-i-PIyQYcD4_KeO5WVVfCJQyM@z>


> + * 8x50 HDD Specs 5-8.  Simulator co-sim not fixed until
> + * release 1.1, and then it's "adjustable" and probably not defaulted.
> + */
> +#define RTOS_TIMER_INT         3
> +#ifdef CONFIG_HEXAGON_COMET
> +#define RTOS_TIMER_REGS_ADDR   0xAB000000UL
> +#endif
> +#define SLEEP_CLK_RATE         32000

I think it would be better to pull RTOS_TIMER_REGS_ADDR from the device
tree, but this is probably good enough for 3.2.

Acked-by: Arnd Bergmann <arnd@arndb.de>
