From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCHv4 6/6] byteorder: add copy_{endian} helpers
Date: Mon, 2 Jun 2008 21:15:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806022038400.6262@anakin>
References: <1212428244.11008.40.camel@brick>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from edna.telenet-ops.be ([195.130.132.58]:34263 "EHLO
	edna.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbYFBTPJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jun 2008 15:15:09 -0400
In-Reply-To: <1212428244.11008.40.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>, "tony.luck" <tony.luck@intel.com>

On Mon, 2 Jun 2008, Harvey Harrison wrote:
> Add helpers for the idiom:
> *(__le16 *)ptr = cpu_to_le16(val);
> 
> Can now be written as:
> copy_le16(ptr, val);

Copy a little endian 16-bit value?

It doesn't just copy. It does a byteswap during the copy.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
