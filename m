From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 04/24] C6X: build infrastructure
Date: Wed, 24 Aug 2011 10:10:32 -0400
Message-ID: <1314195033.2344.8.camel@deneb.redhat.com>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com>
	 <1314043785-2880-5-git-send-email-msalter@redhat.com>
	 <20110822205509.GA7940@merkur.ravnborg.org>
	 <1314105799.2404.40.camel@deneb.redhat.com>
	 <1314193639.16478.3.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19179 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893Ab1HXOKr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Aug 2011 10:10:47 -0400
In-Reply-To: <1314193639.16478.3.camel@i7.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-arch@vger.kernel.org

On Wed, 2011-08-24 at 14:47 +0100, David Woodhouse wrote:
> On Tue, 2011-08-23 at 09:23 -0400, Mark Salter wrote:
> > 
> > > > +cflags-y := -D__linux__ -D__TMS320C6X__
> > > 
> > > Why is __linux__ and __TMS3206C6X__ neeeded?
> > > and why are they not needed for CHECKFLAGS ?
> > 
> > I think these two defines were left over from trying to compensate
> > for differences between TI compiler and GCC. They aren't needed.
> 
> Last time I looked, the Coda file system was broken and would not
> compile if __linux__ wasn't defined. This is the *only* thing that
> prevents you from building a kernel with a generic $ARCH-elf toolchain,
> IIRC.
> 

The reason we defined it in the C6X Makefile was that the TI compiler
did not define it for us. GCC does define it, so we're good without it
the makefile now.

It looks like coda still needs it as well as drm, scsi/aic7xxx driver,
and a couple other places.

--Mark
