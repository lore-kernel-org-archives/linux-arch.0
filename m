Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:44395 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbbCZPrJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Mar 2015 11:47:09 -0400
Date: Thu, 26 Mar 2015 15:46:18 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3  10/15] serial: stm32-usart: Add STM32 USART Driver
Message-ID: <20150326154618.GO8656@n2100.arm.linux.org.uk>
References: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>
 <1426197361-19290-11-git-send-email-maxime.coquelin@st.com>
 <5511ABAA.2010303@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5511ABAA.2010303@hurleysoftware.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, u.kleine-koenig@pengutronix.de, afaerber@suse.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, stefan@agner.ch, pmeerw@pmeerw.net, pebolle@tiscali.nl, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150326154618.-rNR6IPXpC3B4GFXyGlHfQenbaZnh3vvtwVhsNO8Gi0@z>

On Tue, Mar 24, 2015 at 02:23:38PM -0400, Peter Hurley wrote:
> Hi Maxime,
> 
> On 03/12/2015 05:55 PM, Maxime Coquelin wrote:
> > +static unsigned int stm32_get_mctrl(struct uart_port *port)
> > +{
> > +	/*
> > +	 * This routine is used for geting signals of: DTR, DCD, DSR, RI,
> > +	 * and CTS/RTS

It's also worth noting that this comment is wrong.  This is used to get
the state of DCD, DSR, RI and CTS.  DTR and RTS are *not* included
because the core tracks their state.

...

> > +	stm32port->clk = devm_clk_get(&pdev->dev, NULL);
> > +
> > +	if (WARN_ON(IS_ERR(stm32port->clk)))
> 
> Do you really need a stack trace here? Could this be dev_err() instead?
> 
> > +		return -EINVAL;

Also, propagate the error code.

> > +
> > +	/* ensure that clk rate is correct by enabling the clk */
> > +	clk_prepare_enable(stm32port->clk);

And remember to check the return value of clk_prepare_enable().

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
