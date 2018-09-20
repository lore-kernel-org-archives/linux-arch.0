Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:55113 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731260AbeITLgx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Sep 2018 07:36:53 -0400
Date: Thu, 20 Sep 2018 13:54:40 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V8 5/6] clocksource: add C-SKY SMP timer
Message-ID: <20180920055439.GA5488@guoren-Inspiron-7460>
References: <cover.1537417413.git.ren_guo@c-sky.com>
 <81ffeff6131882989652a0050e5a947ffc9a327c.1537417413.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81ffeff6131882989652a0050e5a947ffc9a327c.1537417413.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, robh@kernel.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com
Message-ID: <20180920055440.wAY2Io-iafi7PR05t6oQ5rK5VEs_jt_pK9u_4XVTzDc@z>

On Thu, Sep 20, 2018 at 01:39:31PM +0800, Guo Ren wrote:
> +struct clocksource csky_clocksource = {
> +	.name	= "csky",
> +	.rating	= 400,
> +	.mask	= CLOCKSOURCE_MASK(32),
> +	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.read	= clksrc_read,
> +};
> +
> +#define CPUHP_AP_CSKY_TIMER_STARTING CPUHP_AP_RISCV_TIMER_STARTING
My fault, forget delete the line above.

 Guo Ren
