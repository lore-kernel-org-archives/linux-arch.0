Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:51276 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbcD0KAk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2016 06:00:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/8] char/rtc: move mc146818rtc code out of asm-generic/rtc.h
Date: Wed, 27 Apr 2016 11:59:45 +0200
Message-ID: <13463932.UFUngJV7ZH@wuerfel>
In-Reply-To: <20160427084707.GI3264@piout.net>
References: <1461707052-1337718-1-git-send-email-arnd@arndb.de> <1461707052-1337718-5-git-send-email-arnd@arndb.de> <20160427084707.GI3264@piout.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, dhowells@redhat.com, linux-arch@vger.kernel.org, deller@gmx.de, x86@kernel.org, jejb@parisc-linux.org, geert@linux-m68k.org, rtc-linux@googlegroups.com, ink@jurassic.park.msu.ru, rth@twiddle.net, a.zummo@towertech.it, tony.luck@intel.com, linux-parisc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, yasutake.koichi@jp.panasonic.com
Message-ID: <20160427095945.p-CB1KlS7Rn7vycthQF8-wimpgnuR83mCxDmW6Id0ns@z>

On Wednesday 27 April 2016 11:29:12 Alexandre Belloni wrote:
> The subject should be:
> rtc: cmos: move mc146818rtc code out of asm-generic/rtc.h

Good point, the functions are only used by rtc-cmos, not the old
drivers/char/rtc.c.
 
> Else, you can add:
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Thanks.

	Arnd
