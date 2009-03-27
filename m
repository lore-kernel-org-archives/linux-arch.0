From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 7/13] score - New architecure port to SunplusCT S+CORE
	processor
Date: Fri, 27 Mar 2009 13:09:03 -0400
Message-ID: <20090327170903.GC29999@bombadil.infradead.org>
References: <OF67FB031C.57858745-ON48257586.000915EE-48257586.00097F4B@sunplusct.com> <200903271705.29903.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:51105 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbZC0RJG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2009 13:09:06 -0400
Content-Disposition: inline
In-Reply-To: <200903271705.29903.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: liqin.chen@sunplusct.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, monstr@monstr.eu, john.williams@petalogix.com

On Fri, Mar 27, 2009 at 05:05:29PM +0100, arnd@arndb.de wrote:
> > +config MACH_SPCT6600
> > +       bool "SPCT6600 series based machines"
> > +       select SYS_SUPPORTS_32BIT_KERNEL
> > +       select SYS_SUPPORTS_LITTLE_ENDIAN
> > +       select CPU_SCORE7
> > +       select GENERIC_HAS_IOMAP
> > +

Huh, is it intended to add big endian support? <asm/byteorder.h>
was just including <asm-generic/little_endian.h> and should probably
be conditional on your SYS_SUPPROTS_BIG_ENDIAN if so...

I've dug a bit at your code for this, and can't see where you obviously
set a byte order bit in a control register... is it hard wired on the
board?

regards, Kyle
