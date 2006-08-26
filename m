Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:14805 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750811AbWHZOH2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 26 Aug 2006 10:07:28 -0400
Subject: Re: Cache alias handling in copy_user_page / copy_user_highpage
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20060826082017.GE725@flint.arm.linux.org.uk>
References: <20060819122520.GA18180@linux-mips.org>
	 <20060826082017.GE725@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sat, 26 Aug 2006 09:06:58 -0500
Message-Id: <1156601218.3501.5.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Sat, 2006-08-26 at 09:20 +0100, Russell King wrote:
> > I lean toward 2) since kmap_coherent is a more versatile interface.
> 
> This gives me cause for concern - if we move the VIPT remapping of pages
> into kmap_coherent(), it's wrong for VIVT caches, and we already build
> kernels which run-time configure themselves depending on what they find.
> 
> So I'm in favour of (1), where the architecture specific details can be
> properly handled by the architecture specific code, perhaps by indirecting
> copy_user_highpage() via a function pointer when necessary.

Actually, I think I favour (1) as well.  We have all the machinery in
place on parisc for copying coherently via the tmpalias space, I just
need to enable it.  While kmap_coherent would get us out of having to
take special action on kunmap (the patch I sent in previously), we just
don't have enough spare kernel mappings on 32 bit machines to implement
it.

The reason for choosing (1) over (2) is simply that we already take
special action to restore coherency on kmap/kunmap, but it would be
faster to do a coherent copy, so we have to hijack the whole interface,
because we don't want the kmap overhead if we're going to copy
coherently.

James


