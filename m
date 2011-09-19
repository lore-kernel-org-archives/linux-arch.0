From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 18/36] Hexagon: Add time and timer functions
Date: Mon, 19 Sep 2011 15:38:02 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1109191536330.2723@ionos>
References: <e97c6e$3hno05@wolverine02.qualcomm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <e97c6e$3hno05@wolverine02.qualcomm.com>
Sender: linux-hexagon-owner@vger.kernel.org
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 14 Sep 2011, Richard Kuo wrote:
> +
> +void debug_adsp_timers(void)
> +{
> +	printk(KERN_INFO "rtos_timer->match=0x%08x\n", rtos_timer->match);
> +	printk(KERN_INFO "rtos_timer->count=%d\n", rtos_timer->count);
> +	printk(KERN_INFO "rtos_timer->enable=%d\n", rtos_timer->enable);
> +	printk(KERN_INFO "rtos_timer->clear=%d\n", rtos_timer->clear);
> +}

Does this have a caller and is it useful ?

Otherwise this looks good.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
