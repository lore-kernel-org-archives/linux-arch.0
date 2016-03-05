From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] mtd: only use __xipram annotation when XIP_KERNEL is set
Date: Sat, 05 Mar 2016 09:45:21 +0100
Message-ID: <8737s5wbxa.fsf@belgarion.home>
References: <1453736525-1959191-2-git-send-email-arnd@arndb.de>
	<20160305000225.GB55664@google.com>
	<20160305001057.GC55664@google.com> <3582240.H8v1IXn8EB@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:18530 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbcCEIp1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 5 Mar 2016 03:45:27 -0500
In-Reply-To: <3582240.H8v1IXn8EB@wuerfel> (Arnd Bergmann's message of "Sat, 05
	Mar 2016 01:24:36 +0100")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>

Arnd Bergmann <arnd@arndb.de> writes:

> I guess we can bring back the macros for the case that MTD_XIP and XIP_KERNEL
> are both enabled.
>
> 	Arnd
I wouldn't have ICMR and ICIP exposed to drivers, Eric's original move looks
corect to me.

On the other hand, I'm wondering if xip_irqpending(), xip_currtime() and
xip_cpu_idle() should be declared as functions in mtd-xip.h, and be part of
something like arch/arm/mach-pxa/xip.c ...

Cheers.

-- 
Robert
