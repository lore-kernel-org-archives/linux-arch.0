Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:11107
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756068AbZC0Nfi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Mar 2009 09:35:38 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [GIT PULL] Microblaze initial pack
Date: Fri, 27 Mar 2009 07:20:27 -0600
In-Reply-To: <20090327122518.GB23023@elte.hu>
References: <49CC8A41.4060503@monstr.eu> <20090327103032.GA12485@elte.hu> <49CCBA3F.6040703@petalogix.com> <20090327122518.GB23023@elte.hu>
From: John Linn <John.Linn@xilinx.com>
Message-ID: <20090327132029.3DE1613C005E@mail159-va3.bigfish.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Michal Simek <michal.simek@petalogix.com>
Cc: Michal Simek <monstr@monstr.eu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@linux-foundation.org, Linux Kernel list <linux-kernel@vger.kernel.org>, lkml <linux-arch@vger.kernel.org>, microblaze-uclinux@itee.uq.edu.au, Andrew Morton <akpm@linux-foundation.org>, John Williams <john.williams@petalogix.com>, Stephen Neuendorffer <stephenn@xilinx.com>, Thomas Gleixner <tglx@linutronix.de>, Randy Dunlap <randy.dunlap@oracle.com>, Arnd Bergmann <arnd@arndb.de>, Peter Korsgaard <jacmet@sunsite.dk>
Message-ID: <20090327132027.UraTEgijR0Ym5mI9UooZzPBzQ3CJoGsc7DiQdZEQ-tk@z>

Sure of course you can change it.  We're just putting in GPL license in
our current code.

-- John

> -----Original Message-----
> From: Ingo Molnar [mailto:mingo@elte.hu]
> Sent: Friday, March 27, 2009 6:25 AM
> To: Michal Simek
> Cc: Michal Simek; Alan Cox; torvalds@linux-foundation.org; Linux
Kernel list; lkml; microblaze-
> uclinux@itee.uq.edu.au; Andrew Morton; John Williams; John Linn;
Stephen Neuendorffer; Thomas
> Gleixner; Randy Dunlap; Arnd Bergmann; Peter Korsgaard
> Subject: Re: [GIT PULL] Microblaze initial pack
> 
> 
> * Michal Simek <michal.simek@petalogix.com> wrote:
> 
> > > I've also done a (quick) license scan and there's this one file i
> > > found:
> > >
> > >   arch/microblaze/kernel/hw_exception_handler.S
> > >
> > >    * Copyright (C) 2004 Xilinx, Inc. All rights reserved.
> > >    *
> > >    * Xilinx, Inc.
> > >    * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
AS A
> > >    * COURTESY TO YOU.BY PROVIDING THIS DESIGN, CODE, OR
INFORMATION AS
> > >    * ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
> > >    * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS
IMPLEMENTATION
> > >    * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE
RESPONSIBLE
> > >    * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR
IMPLEMENTATION.
> > >
> > > That is an all rights reserved copyrighted file, and i'm not sure
> > > the above constitutes a GPLv2 compatible license. It would be less
> > > ambigious to add what you do in the other places instead,
something
> > > like:
> > >
> > >  * (C) Copyright 2004 Xilinx, Inc.
> > >  *
> > >  * This program is free software; you can redistribute it and/or
modify it
> > >  * under the terms of the GNU General Public License version 2 as
published
> > >  * by the Free Software Foundation.
> > >
> > This is no my license. I'll ask a Xilinx guys for permission to
change
> > it for this file.
> > John L, Stephen: Could I change the license as Ingo suggested?
> 
> Note that there's a couple of other Xilinx files in the upstream
> kernel tree already that could serve as a template:
> 
>  drivers/char/xilinx_hwicap/buffer_icap.c: *     XILINX IS PROVIDING
THIS DESIGN, CODE, OR
> INFORMATION "AS IS"
>  drivers/char/xilinx_hwicap/buffer_icap.h: *     XILINX IS PROVIDING
THIS DESIGN, CODE, OR
> INFORMATION "AS IS"
>  drivers/char/xilinx_hwicap/fifo_icap.c: *     XILINX IS PROVIDING
THIS DESIGN, CODE, OR INFORMATION
> "AS IS"
>  drivers/char/xilinx_hwicap/fifo_icap.h: *     XILINX IS PROVIDING
THIS DESIGN, CODE, OR INFORMATION
> "AS IS"
>  drivers/char/xilinx_hwicap/xilinx_hwicap.c: *     XILINX IS PROVIDING
THIS DESIGN, CODE, OR
> INFORMATION "AS IS"
>  drivers/char/xilinx_hwicap/xilinx_hwicap.h: *     XILINX IS PROVIDING
THIS DESIGN, CODE, OR
> INFORMATION "AS IS"
> 
> Those files carry this as-is no-warrantes notice plus also a GPLv2
> notice:
> 
>
/***********************************************************************
******
>  *
>  *     Author: Xilinx, Inc.
>  *
>  *     This program is free software; you can redistribute it and/or
modify it
>  *     under the terms of the GNU General Public License as published
by the
>  *     Free Software Foundation; either version 2 of the License, or
(at your
>  *     option) any later version.
>  *
>  *     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
>  *     AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
>  *     SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
>  *     OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
>  *     APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
>  *     THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF
INFRINGEMENT,
>  *     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY
REQUIRE
>  *     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
>  *     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
>  *     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
>  *     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
>  *     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
>  *     FOR A PARTICULAR PURPOSE.
>  *
>  *     (c) Copyright 2003-2008 Xilinx Inc.
>  *     All rights reserved.
>  *
>  *     You should have received a copy of the GNU General Public
License along
>  *     with this program; if not, write to the Free Software
Foundation, Inc.,
>  *     675 Mass Ave, Cambridge, MA 02139, USA.
>  *
>
************************************************************************
*****/
> 
> 	Ingo


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.


