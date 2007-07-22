Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from astra.telenet-ops.be ([195.130.132.58]:48988 "EHLO
	astra.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762437AbXGVSve (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Jul 2007 14:51:34 -0400
Date: Sun, 22 Jul 2007 20:51:26 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3] take declarations of enable_irq() et.al. to
 linux/interrupt.h
In-Reply-To: <E1ICNRo-0000lx-G2@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0707222050590.18493@anakin>
References: <E1ICNRo-0000lx-G2@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: torvalds@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, 21 Jul 2007, Al Viro wrote:
> Now that the last inlined instances are gone, all that is left to do
> is turning disable_irq_nosync on arm26 and m68k from defines to aliases
> and we are all set - we can make these externs in linux/interrupt.h
> uncoditional and kill remaining instances in asm/irq.h

Looks great, thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
