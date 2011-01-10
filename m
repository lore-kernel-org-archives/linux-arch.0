Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pqueueb.post.tele.dk ([193.162.153.10]:40954 "EHLO
	pqueueb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694Ab1AJQse (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2011 11:48:34 -0500
Date: Mon, 10 Jan 2011 17:26:39 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/2] kbuild: asm-generic support
Message-ID: <20110110162639.GB13763@merkur.ravnborg.org>
References: <20110108130302.GA21698@merkur.ravnborg.org> <20110109192707.GA12387@merkur.ravnborg.org> <20110109192907.GA12403@merkur.ravnborg.org> <004e01cbb0c8$4de80470$e9b80d50$@mprc.pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004e01cbb0c8$4de80470$e9b80d50$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: 'lkml' <linux-kernel@vger.kernel.org>, 'linux-kbuild' <linux-kbuild@vger.kernel.org>, 'linux arch' <linux-arch@vger.kernel.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Michal Marek' <mmarek@suse.cz>
Message-ID: <20110110162639.Sf7dw8tB2EtnmZ35L6s_wNPUV_TREgQMHFqlGzqd6Q8@z>

Hi Guan (I will try to spell you name correct fom now on!)

> > +	During the prepare phase of the build a wrapper include
> > +	file is generated in the directory:
> > +
> > +		arch/$(ARCH)/include/generated/asm
> IMHO, the directory could be include/generated/asm

We have moved all the arch specific files away from include/*
which is why I invented arch/$(ARCH)/include/generated.

I was actually considering:

   arch/$(ARCH)/generated.

But using include/generated just seems wrong.

> > 
> >  # Work out what needs to be removed
> > @@ -47,8 +54,12 @@ quiet_cmd_install = INSTALL $(printdir) ($(words $(all-files))\
> >        cmd_install = \
> >          $(PERL) $< $(srctree)/$(obj) $(install) $(SRCARCH) $(header-y); \
> >          $(PERL) $< $(objtree)/$(obj) $(install) $(SRCARCH) $(objhdr-y); \
> > +        for F in $(wrapper-files); do                                   \
> > +                echo "\#include <asm-generic/$$F>" > $(install)/$$F;    \
> > +        done;                                                           \
> >          touch $@
> > 
> > +
> Empty line.
> 

Will fix.

As noticed in another mail the patchset has the same issue with rebuilding.
This will likewise be included in next version.

	Sam
