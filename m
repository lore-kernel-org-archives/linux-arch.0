From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v3 02/31] arm64: Kernel booting and initialisation
Date: Mon, 10 Sep 2012 07:53:39 +0200
Message-ID: <20120910055339.GC31430@game.jcrosoft.org>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-3-git-send-email-catalin.marinas@arm.com>
 <20120909172046.GB31430@game.jcrosoft.org>
 <alpine.LFD.2.02.1209091923180.28681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:33086 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751208Ab2IJF4R (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 Sep 2012 01:56:17 -0400
Received: from mail636.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id AC956DC3DC1
	for <linux-arch@vger.kernel.org>; Mon, 10 Sep 2012 08:01:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1209091923180.28681@xanadu.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 19:29 Sun 09 Sep     , Nicolas Pitre wrote:
> On Sun, 9 Sep 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > On 17:26 Fri 07 Sep     , Catalin Marinas wrote:
> > > +4. Call the kernel image
> > > +------------------------
> > > +
> > > +Requirement: MANDATORY
> > > +
> > > +The decompressed kernel image contains a 32-byte header as follows:
> > > +
> > > +  u32 magic	= 0x14000008;	/* branch to stext, little-endian */
> > > +  u32 res0	= 0;		/* reserved */
> > > +  u64 text_offset;		/* Image load offset */
> > > +  u64 res1	= 0;		/* reserved */
> > > +  u64 res2	= 0;		/* reserved */
> > we need to have a magic to known it's a arm64 kernel
> 
> You have it: it's 0x14000008 at the beginning.
fragile
> 
> > > +
> > > +The image must be placed at the specified offset (currently 0x80000)
> > > +from the start of the system RAM and called there. The start of the
> > > +system RAM must be aligned to 2MB.
> > can we drop this
> 
> Drop what?
> And why?
This contrain the must be loadable at any address

Best Regards,
J.
