From: John Linn <John.Linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [GIT PULL] Microblaze initial pack
Date: Fri, 27 Mar 2009 07:20:27 -0600
Message-ID: <20090327132029.3DE1613C005E@mail159-va3.bigfish.com>
References: <49CC8A41.4060503@monstr.eu> <20090327103032.GA12485@elte.hu> <49CCBA3F.6040703@petalogix.com> <20090327122518.GB23023@elte.hu>
Reply-To: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <owner-microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <20090327122518.GB23023-X9Un+BFzKDI@public.gmane.org>
Sender: owner-microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org
To: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Michal Simek <michal.simek-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org>
Cc: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lkml <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, John Williams <john.williams-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org>, Stephen Neuendorffer <stephenn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Sure of course you can change it.  We're just putting in GPL license in
our current code.

-- John

> -----Original Message-----
> From: Ingo Molnar [mailto:mingo-X9Un+BFzKDI@public.gmane.org]
> Sent: Friday, March 27, 2009 6:25 AM
> To: Michal Simek
> Cc: Michal Simek; Alan Cox; torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org; Linux
Kernel list; lkml; microblaze-
> uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org; Andrew Morton; John Williams; John Linn;
Stephen Neuendorffer; Thomas
> Gleixner; Randy Dunlap; Arnd Bergmann; Peter Korsgaard
> Subject: Re: [GIT PULL] Microblaze initial pack
> 
> 
> * Michal Simek <michal.simek-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org> wrote:
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
