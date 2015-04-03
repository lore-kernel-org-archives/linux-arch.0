Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37677 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbbDCRCL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Apr 2015 13:02:11 -0400
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH v5 02/15] ARM: ARMv7-M: Enlarge vector table up to 256 entries
Date: Fri,  3 Apr 2015 19:01:08 +0200
Message-ID: <1428080481-18591-3-git-send-email-mcoquelin.stm32@gmail.com>
In-Reply-To: <1428080481-18591-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1428080481-18591-1-git-send-email-mcoquelin.stm32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: u.kleine-koenig@pengutronix.de, afaerber@suse.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, stefan@agner.ch, pmeerw@pmeerw.net, pebolle@tiscali.nl, peter@hurleysoftware.com, andy.shevchenko@gmail.com, cw00.choi@samsung.com, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, mcoquelin.stm32@gmail.com
Message-ID: <20150403170108.R68QrB-g5dXIa_05-BCoPtWwyxvvQamnrxMfKJaEKiw@z>
