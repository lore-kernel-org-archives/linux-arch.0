From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCHv4 6/6] byteorder: add copy_{endian} helpers
Date: Wed, 4 Jun 2008 21:34:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806042133510.32459@anakin>
References: <1212428244.11008.40.camel@brick> <Pine.LNX.4.64.0806022038400.6262@anakin>
 <1212604681.6340.28.camel@brick>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from winston.telenet-ops.be ([195.130.137.75]:46247 "EHLO
	winston.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762389AbYFDTfD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jun 2008 15:35:03 -0400
In-Reply-To: <1212604681.6340.28.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>, "tony.luck" <tony.luck@intel.com>

On Wed, 4 Jun 2008, Harvey Harrison wrote:
> On Mon, 2008-06-02 at 21:15 +0200, Geert Uytterhoeven wrote:
> > On Mon, 2 Jun 2008, Harvey Harrison wrote:
> > > Add helpers for the idiom:
> > > *(__le16 *)ptr = cpu_to_le16(val);
> > > 
> > > Can now be written as:
> > > copy_le16(ptr, val);
> > 
> > Copy a little endian 16-bit value?
> > 
> > It doesn't just copy. It does a byteswap during the copy.
> 
> True, I had originally called this put_le16.  akpm suggested copy_le16.
> What do people think of copy_as_le16?

Sounds still a bit strange to me...

As `get' and `put' have connotations of reference counts, what about
`load' and `store', e.g. `load_le32()' and `store_be16()'?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
