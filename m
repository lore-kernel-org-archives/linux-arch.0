From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCHv2 09/11] unicore32 core architecture: timer and time
 handling
Date: Wed, 16 Feb 2011 10:20:35 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1102161018370.26192@localhost6.localdomain6>
References: <02f301cbcb48$bebea4c0$3c3bee40$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:33817 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758787Ab1BPJUr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 Feb 2011 04:20:47 -0500
In-Reply-To: <02f301cbcb48$bebea4c0$3c3bee40$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 'Greg KH' <greg@kroah.com>

On Sun, 13 Feb 2011, Guan Xuetao wrote:
> +static struct clock_event_device ckevt_puv3_osmr0 = {
> +	.name		= "osmr0",
> +	.features	= CLOCK_EVT_FEAT_ONESHOT,
> +#ifdef CONFIG_ARCH_FPGA
> +	.shift		= 18, /* correct shift val: 16, but warn_on_slowpath */
> +#else
> +	.shift          = 30,
> +#endif

Please get rid of this.

> +void __init time_init(void)
> +{
> +	OST_OIER = 0;		/* disable any timer interrupts */
> +	OST_OSSR = 0;		/* clear status on all timers */
> +
> +	ckevt_puv3_osmr0.mult =
> +		div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC, ckevt_puv3_osmr0.shift);

And use clockevents_calc_mult_shift() instead of this.

Thanks,

	tglx
