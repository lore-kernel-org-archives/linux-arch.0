From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v3 18/36] Hexagon: Add time and timer functions
Date: Fri, 09 Sep 2011 10:23:45 +0200
Message-ID: <8440717.zkZKr0bf7e@wuerfel>
References: <20110909010847.294039464@codeaurora.org> <20110909010916.422373448@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110909010916.422373448@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


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
