From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 21/29] nios2: Time keeping
Date: Wed, 8 Oct 2014 12:44:32 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1410081240110.4292@nanos>
References: <1412760595-3935-1-git-send-email-lftan@altera.com> <1412760595-3935-22-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37223 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192AbaJHKoh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Oct 2014 06:44:37 -0400
In-Reply-To: <1412760595-3935-22-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, lftan.linux@gmail.com, cltang@codesourcery.com

On Wed, 8 Oct 2014, Ley Foon Tan wrote:
> +static void nios2_timer_set_mode(enum clock_event_mode mode,
> +	struct clock_event_device *evt)
> +{
> +	unsigned long period;
> +	struct nios2_clockevent_dev *nios2_ced = to_nios2_clkevent(evt);
> +	struct nios2_timer *timer = &nios2_ced->timer;
> +
> +	switch (mode) {
> +	case CLOCK_EVT_MODE_PERIODIC:
> +		period = DIV_ROUND_UP(timer->freq, HZ);
> +		nios2_timer_config(timer, period, CLOCK_EVT_MODE_PERIODIC);
> +		break;
> +	case CLOCK_EVT_MODE_ONESHOT:
> +		nios2_timer_config(timer, ULONG_MAX, CLOCK_EVT_MODE_ONESHOT);

What's the point of this? This should simply stop the timer.

> +		break;
> +	case CLOCK_EVT_MODE_UNUSED:
> +	case CLOCK_EVT_MODE_SHUTDOWN:
> +		nios2_timer_stop(timer);
> +		break;
> +	case CLOCK_EVT_MODE_RESUME:
> +		nios2_timer_start(timer);
> +		break;
> +	}
> +}

> +static int num_called;
> +static void __init nios2_time_init(struct device_node *timer)
> +{
> +	switch (num_called) {
> +	case 0:
> +		nios2_clockevent_init(timer);
> +		break;
> +	case 1:
> +		nios2_clocksource_init(timer);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	num_called++;
> +}

Eew. So this depends on the DT ordering. If thats wrong, then stuff
will be initialized in the wrong oder. 

> +CLOCKSOURCE_OF_DECLARE(nios2_timer, "altr,timer-1.0", nios2_time_init);

Why can't you have separate match entries with where one calls
nios2_clockevent_init and the other nios2_clocksource_init?

Thanks,

	tglx
