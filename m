Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:2176 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932910AbWJIOwd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2006 10:52:33 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4]
Date: Mon, 9 Oct 2006 16:52:24 +0200
References: <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr> <Pine.LNX.4.61.0610091416290.4279@yvahk01.tjqt.qr> <Pine.LNX.4.62.0610091508240.16048@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0610091508240.16048@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610091652.26209.arnd.bergmann@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Kyle Moffett <mrmacman_g4@mac.com>, David Howells <dhowells@redhat.com>, Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, sfr@canb.auug.org.au, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Monday 09 October 2006 15:09, Geert Uytterhoeven wrote:
> On Mon, 9 Oct 2006, Jan Engelhardt wrote:
> > 
> > Ouch ouch ouch. It should better be
> > 
> > typedef uint32_t __u32;
> 
> You mean
> 
> #ifdef __KERNEL__
> typedef __u32 u32;
> #else
> // Assumed we did #include <stdint.h> before
> typedef uint32_t __u32;
> #endif

Why should that be a valid assumption? Right now, it works
if you don't include stdint.h in advance.

	Arnd <><
