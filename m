From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mtd: only use __xipram annotation when XIP_KERNEL is set
Date: Sun, 6 Mar 2016 20:56:01 +0100
Message-ID: <201603062056.01683.arnd@arndb.de>
References: <1453736525-1959191-2-git-send-email-arnd@arndb.de> <3582240.H8v1IXn8EB@wuerfel> <8737s5wbxa.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:56979 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbcCFT5G (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 6 Mar 2016 14:57:06 -0500
In-Reply-To: <8737s5wbxa.fsf@belgarion.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>

On Saturday 05 March 2016, Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > I guess we can bring back the macros for the case that MTD_XIP and XIP_KERNEL
> > are both enabled.
> >
> > 	Arnd
> I wouldn't have ICMR and ICIP exposed to drivers, Eric's original move looks
> corect to me.

Yes, it's a reasonable cleanup that we have done in many places, except
this one introduced a regression for MTD_XIP.

> On the other hand, I'm wondering if xip_irqpending(), xip_currtime() and
> xip_cpu_idle() should be declared as functions in mtd-xip.h, and be part of
> something like arch/arm/mach-pxa/xip.c ...

They have to at least be marked __xipram and must not reference anything
in .text or .rodata, but there might be additional requirements.

	Arnd
