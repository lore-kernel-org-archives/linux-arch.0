From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 04/24] C6X: build infrastructure
Date: Tue, 23 Aug 2011 09:23:17 -0400
Message-ID: <1314105799.2404.40.camel@deneb.redhat.com>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com>
	 <1314043785-2880-5-git-send-email-msalter@redhat.com>
	 <20110822205509.GA7940@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55189 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755310Ab1HWNXZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Aug 2011 09:23:25 -0400
In-Reply-To: <20110822205509.GA7940@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org

On Mon, 2011-08-22 at 22:55 +0200, Sam Ravnborg wrote:
> > 
> > diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
> > new file mode 100644
> > index 0000000..f147a446
> > --- /dev/null
> > +++ b/arch/c6x/Kconfig
> > @@ -0,0 +1,179 @@
> > +#
> > +# For a description of the syntax of this configuration file,
> > +# see Documentation/kbuild/kconfig-language.txt.
> > +#
> > +
> > +config TMS320C6X
> > +	def_bool y
> > +	select CLKDEV_LOOKUP
> > +	select GENERIC_HARDIRQS_NO__DO_IRQ
> > +	select GENERIC_HARDIRQS_NO__DO_IRQ
> Not present in todays kernel - not even if you try to select it twice

Hmm, maybe it is true that I am stubborn.

> 
> > +	select GENERIC_HARDIRQS_NO_DEPRECATED
> Not present either - drop it.
> 

okay, I'll get rid of these.

> > +
> > +menu "Processor type and features"
> > +
> > +config TMS320C64XPLUS
> > +	bool "TMS320C64X+"
> A little help would be nice. Maybe with a pointer to a web-site.

okay.

> 
> > +cflags-y := -D__linux__ -D__TMS320C6X__
> 
> Why is __linux__ and __TMS3206C6X__ neeeded?
> and why are they not needed for CHECKFLAGS ?

I think these two defines were left over from trying to compensate
for differences between TI compiler and GCC. They aren't needed.

--Mark
