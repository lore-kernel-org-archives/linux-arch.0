Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pqueuea.post.tele.dk ([193.162.153.9]:49267 "EHLO
	pqueuea.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab1AHLss (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2011 06:48:48 -0500
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueuea.post.tele.dk (Postfix) with ESMTP id 494CCDB97B
	for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2011 12:48:47 +0100 (CET)
Date: Sat, 8 Jan 2011 12:48:26 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCHv1 01/12] unicore32 core architecture: build
	infrastructure
Message-ID: <20110108114826.GA7915@merkur.ravnborg.org>
References: <00c601cba463$69533750$3bf9a5f0$@mprc.pku.edu.cn> <20110106075553.GC15914@linux-sh.org> <023601cbaef7$850f2af0$8f2d80d0$@mprc.pku.edu.cn> <20110108072053.GA10552@merkur.ravnborg.org> <023c01cbaf24$85a99cc0$90fcd640$@mprc.pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <023c01cbaf24$85a99cc0$90fcd640$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: 'Paul Mundt' <lethal@linux-sh.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20110108114826.V_jEOnLm0lGG_NfIrhYBBEHjHbk5Rj5eZpwSEY0xlP0@z>

> > > +textofs-y	:= 0x00408000
> > > +
> > > +# The byte offset of the kernel image in RAM from the start of RAM.
> > > +TEXT_OFFSET := $(textofs-y)
> > 
> > If you are going to have different TEXT_OFFSET's then I suggest to move
> > this to KConfig as an "hex "Text offset" config option.
> > You can set default values dependign on BSP etc.
> There is no different TEXT_OFFSET.
> 
> > 
> > Also defiing stuff here just to export it for use in boot/
> > has always looked like a strange concept - but many archs do so today.
> > You do not export TEXT_OFFSET but I guess this is a bug?
> I need TEXT_OFFSET for kernel/ and boot/, so export it.

I would suggest to move this to you Kconfig file.
something like this:

# The byte offset of the kernel image in RAM from the start of RAM
config UNICORE32_TEXT_OFFSET
	hex
	default 0x00408000

Then you have the symbol available as CONFIG_UNICORE32_TEXT_OFFSET
both in your Makefiles and in your source files.
> > 
> > > +
> > > +core-y				+= arch/unicore32/kernel/ arch/unicore32/mm/
> > > +core-$(CONFIG_UNICORE_FPU_F64)	+= arch/unicore32/uc-f64/
> > > +
> > > +drivers-$(CONFIG_ARCH_PUV3)	+= drivers/staging/puv3/
> > > +
> > > +libs-y				+= arch/unicore32/lib/
> > > +# include libc.a in libs-y for string functions, like memcpy and so on.
> > > +libs-y				+= $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libc.a)
> > > +libs-y				+= $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libgcc.a)
> > > +
> > 
> > The other three archs that uses libgcc use:
> > 
> >     $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
> > 
> > So when I read the above I am confused why it looks different than the others.
> > For libc I guess you do nto have that option and what you do is fine there.
> It's the same with -print-libgcc-file-name and -print-file-name=libgcc.a.
> And we need libc.a for string like functions.

And then they use equal methods - OK.

	Sam
