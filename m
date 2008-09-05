From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] Remove redundant CONFIG_ARCH_SUPPORTS_AOUT
Date: Fri, 05 Sep 2008 18:17:52 +0100
Message-ID: <1220635072.2985.368.camel@pmac.infradead.org>
References: <1213696004.26255.960.camel@pmac.infradead.org>
	 <1220632021.2985.360.camel@pmac.infradead.org>
	 <20080905162831.GA13801@phobos.i.cabal.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:49039 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692AbYIERR4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Sep 2008 13:17:56 -0400
In-Reply-To: <20080905162831.GA13801@phobos.i.cabal.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, bunk@kernel.org

On Fri, 2008-09-05 at 12:28 -0400, Kyle McMartin wrote:
> On Fri, Sep 05, 2008 at 05:27:01PM +0100, David Woodhouse wrote:
> > diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> > index a7d4fd3..8313fcc 100644
> > --- a/arch/parisc/Kconfig
> > +++ b/arch/parisc/Kconfig
> > @@ -76,9 +76,6 @@ config IRQ_PER_CPU
> >  	bool
> >  	default y
> >  
> > -config ARCH_SUPPORTS_AOUT
> > -	def_bool y
> > -
> >  # unless you want to implement ACPI on PA-RISC ... ;-)
> >  config PM
> >  	bool
> 
> This isn't even correct. PA-RISC only supports SOM or ELF...

Yeah, ARCH_SUPPORTS_AOUT was a bit b0rked from the beginning.

Hm, that reminds me -- I was supposed to pick up Adrian's patch to
remove a bunch of pointless <asm/a.out.h> files... now added to my tree
and sent.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
