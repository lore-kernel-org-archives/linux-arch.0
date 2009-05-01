From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/27] asm-generic: add legacy I/O header files
Date: Fri, 1 May 2009 15:29:04 +0200
Message-ID: <200905011529.04774.arnd@arndb.de>
References: <cover.1241105648.git.arnd@arndb.de> <20090501123728.GC27799@flint.arm.linux.org.uk> <20090501140904.69f44406@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:51992 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761823AbZEAN3G (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 09:29:06 -0400
In-Reply-To: <20090501140904.69f44406@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Michal Simek <monstr@monstr.eu>, linux-arch@vger.kernel.org, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

On Friday 01 May 2009, Alan Cox wrote:
> Joining in late but its not at all highly PC specific. The same frequency
> is used for a whole pile of setups (Alpha etc). It's not well named but
> there are good sound reasons the PC chose 1193182 and while those reasons
> have long lapsed its a good frequency for other reasons nowdays.
> 
> The clock isn't for the PIC either - its for the PIT (although its used
> to clock various other things).
> 
> We actually have a define of PIT_TICK_RATE internal to the x86 port for
> those x86 cases that can use it.

How about this comment then:

/*
 * CLOCK_TICK_RATE is traditionally the base frequency using the PC-style
 * i8253 "PIT" timer. Architecture independent device drivers should not
 * rely on this value.
 * Any architecture that either has a real PC-style PIT, or does not have a
 * fixed timer interval at all and just needs to provide some value here
 * should just fall back to this default.
 */

	Arnd <><
