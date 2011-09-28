Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65053 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250Ab1I1XYj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 19:24:39 -0400
Date: Wed, 28 Sep 2011 18:11:12 -0500
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 07/24] C6X: devicetree support
Message-ID: <20110928231112.GE2838@ponder.secretlab.ca>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com>
 <1317155405-26235-8-git-send-email-msalter@redhat.com>
 <201109281531.36792.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201109281531.36792.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Salter <msalter@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Message-ID: <20110928231112.AQJiw0kzWzuWPHni4mh4S7LcXLA1YVNMNZIiBJEBGxo@z>

On Wed, Sep 28, 2011 at 03:31:36PM +0200, Arnd Bergmann wrote:
> On Tuesday 27 September 2011, Mark Salter wrote:
> > diff --git a/arch/c6x/boot/install-dtb.c b/arch/c6x/boot/install-dtb.c
> > new file mode 100644
> > index 0000000..fa979ce
> > --- /dev/null
> > +++ b/arch/c6x/boot/install-dtb.c
> > @@ -0,0 +1,333 @@
> > +/*
> > + * Program to hack in a DTB to an ELF file having a placeholder
> > + * section named __fst_blob.
> > + *
> > + * This allows for building multiple images with builtin DTBs
> > + * using a single vmlinux image. This is only necessary until
> > + * bootloader support exists.
> > + *
> > + * Copyright 2011 Texas Instruments Incorporated
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + *
> > + * Usage: install-dtb <image.dtb> <kernel.elf>
> > + */
> 
> Other architectures allow simply appending the device tree to the
> kernel image file, which is more convenient for users and does
> not require much kernel support. Have you tried this?
> 
> > diff --git a/arch/c6x/platforms/platform.c b/arch/c6x/platforms/platform.c
> > new file mode 100644
> > index 0000000..ad4651c
> > --- /dev/null
> > +++ b/arch/c6x/platforms/platform.c
> > @@ -0,0 +1,17 @@
> > +
> > +static int __init c6x_device_probe(void)
> > +{
> > +       of_platform_bus_probe(NULL, of_default_bus_match_table, NULL);
> > +       return 0;
> > +}
> > +device_initcall(c6x_device_probe);
> 
> device_initcall is run rather late. I think it would be more useful
> to run this as early as possible, in order to make it possible to
> have more of the core services probed through the device tree.
> 
> I also think that for probing the device tree root, you should be
> using of_platform_populate instead of of_platform_bus_probe
> nowadays. Maybe Grant can provide more information on this.

Yes.  Use of_platform_populate().  It's better.

g.

