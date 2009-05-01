From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/27] asm-generic: add legacy I/O header files
Date: Fri, 1 May 2009 15:56:38 +0200
Message-ID: <200905011556.39437.arnd@arndb.de>
References: <cover.1241105648.git.arnd@arndb.de> <200905011529.04774.arnd@arndb.de> <20090501144420.5a3e9c6e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54273 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760364AbZEAN4s (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 09:56:48 -0400
In-Reply-To: <20090501144420.5a3e9c6e@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Michal Simek <monstr@monstr.eu>, linux-arch@vger.kernel.org, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

On Friday 01 May 2009, Alan Cox wrote:
> They shouldn't define it - we want those invalid cases to error. Stick
> CLOCK_TICK_RATE in the depths of the x86 arch includes and then we can
> fix the other cases properly. Either the device has an independant clock
> of the same frequency (some watchdogs do this), it relies upon a
> motherboard timer in which case the platform can define CLOCK_TICK_RATE
> (or a better name for it), or it doesn't have any meaning in which case
> we *want* it not to compile.

I just noticed that linux/jiffies.h does not compile without a definition
of CLOCK_TICK_RATE, so that's probably why every architecture defines it.
If I find a way to remove that dependency, I can simply leave out the
CLOCK_TICK_RATE from the generic header. I have not yet understood the
relation of jiffies to CLOCK_TICK_RATE, but my suspicion is that it's
not good for architectures that do not have a clock tick.

	Arnd <><
