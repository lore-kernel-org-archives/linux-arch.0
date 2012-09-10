Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo1.mail-out.ovh.net ([178.32.228.1]:48786 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab2IJQnN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 Sep 2012 12:43:13 -0400
Received: from mail425.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 18C76FF9D44
	for <linux-arch@vger.kernel.org>; Mon, 10 Sep 2012 17:31:39 +0200 (CEST)
Date: Mon, 10 Sep 2012 17:21:02 +0200
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v3 02/31] arm64: Kernel booting and initialisation
Message-ID: <20120910152102.GD31430@game.jcrosoft.org>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-3-git-send-email-catalin.marinas@arm.com>
 <20120909172046.GB31430@game.jcrosoft.org>
 <alpine.LFD.2.02.1209091923180.28681@xanadu.home>
 <20120910055339.GC31430@game.jcrosoft.org>
 <20120910125137.GC27042@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120910125137.GC27042@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20120910152102.nvO96WzOtmfb9VVUe6bPjH4TTri8Uv4w1znEFu9Yo7U@z>

On 13:51 Mon 10 Sep     , Catalin Marinas wrote:
> On Mon, Sep 10, 2012 at 06:53:39AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 19:29 Sun 09 Sep     , Nicolas Pitre wrote:
> > > On Sun, 9 Sep 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > On 17:26 Fri 07 Sep     , Catalin Marinas wrote:
> > > > > +The image must be placed at the specified offset (currently 0x80000)
> > > > > +from the start of the system RAM and called there. The start of the
> > > > > +system RAM must be aligned to 2MB.
> > > > can we drop this
> > > 
> > > Drop what?
> > > And why?
> > This contrain the must be loadable at any address
> 
> You can't easily load the kernel image at any address, unless it can
> relocate itself and you have a way to specify PHYS_OFFSET. We don't want
> a compile-time PHYS_OFFSET, the kernel detects it at boot time based on
> the load address.
so NACK kexec and other boot loaders require it

Best Regards,
J.
