Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:52152 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbcD1JjU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Apr 2016 05:39:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 04/16] rtc: sh: provide rtc_class_ops directly
Date: Thu, 28 Apr 2016 11:38:47 +0200
Message-ID: <5905519.cjzepiYx4I@wuerfel>
In-Reply-To: <2582931.5Q3899gsIm@wuerfel>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de> <20160427232122.GW21636@brightrain.aerifal.cx> <2582931.5Q3899gsIm@wuerfel>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Rich Felker <dalias@libc.org>, linux-arch@vger.kernel.org, a.zummo@towertech.it, rtc-linux@googlegroups.com, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, deller@gmx.de, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-m68k@lists.linux-m68k.org, geert@linux-m68k.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Message-ID: <20160428093847.k6Vpn5fXOLwl8eSG7dctxhzOxIvvR7qfrpCFzDg2i8w@z>

On Thursday 28 April 2016 11:08:41 Arnd Bergmann wrote:
> I only see two of them anyway (dreamcast and sh03), so that should
> be easy enough to do. For instance in arch/sh/boards/mach-sh03/rtc.c,
> the sh03_time_init() function should register a platform driver,
> whose probe function calls devm_rtc_device_register() to register
> with the rtc subsystem. Then you move the entire file to drivers/rtc/
> and change the callers of sh03_time_init() to create the device
> manually (for the classic board file) or drop it (for DT).

Just FYI:

Another look at the sh03_rtc_settimeofday function shows that it's
always been wrong: unlike the set_mmss() function it calls, it should
set all the time fields, not just minutes and seconds.

	Arnd
