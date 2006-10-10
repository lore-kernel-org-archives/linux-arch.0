Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:17546 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965084AbWJJHzs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Oct 2006 03:55:48 -0400
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in
	the kernel [try #4]
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <200610091847.05441.arnd.bergmann@de.ibm.com>
References: <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr>
	 <200610091727.34780.arnd.bergmann@de.ibm.com>
	 <Pine.LNX.4.62.0610091729420.16048@pademelon.sonytel.be>
	 <200610091847.05441.arnd.bergmann@de.ibm.com>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 08:55:33 +0100
Message-Id: <1160466933.7920.25.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>, Kyle Moffett <mrmacman_g4@mac.com>, David Howells <dhowells@redhat.com>, Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, sfr@canb.auug.org.au, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-10-09 at 18:47 +0200, Arnd Bergmann wrote:
> That has the potential of breaking other source files that don't expect
> linux/types.h to bring in the whole stdint.h file.

I don't think we need to care about those. Userspace in _general_
shouldn't be including our header files -- this is only for low-level
system stuff, and that can be expected to deal with the fact that we
define and use some standard C types from last century.

> Also, it may break some other linux header files that include <linux/types.h>
> and expect to get stuff like uid_t, which you don't get if a glibc header is
> included first, because of __KERNEL_STRICT_NAMES.

We have that problem already, don't we?

-- 
dwmw2

