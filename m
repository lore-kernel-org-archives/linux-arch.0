Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pqueuea.post.tele.dk ([193.162.153.9]:53572 "EHLO
	pqueuea.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab1D0UJm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2011 16:09:42 -0400
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueuea.post.tele.dk (Postfix) with ESMTP id 01D97DC112
	for <linux-arch@vger.kernel.org>; Wed, 27 Apr 2011 21:42:44 +0200 (CEST)
Date: Wed, 27 Apr 2011 21:42:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v3] kbuild: asm-generic support
Message-ID: <20110427194225.GA6551@merkur.ravnborg.org>
References: <20110108130302.GA21698@merkur.ravnborg.org> <20110109192707.GA12387@merkur.ravnborg.org> <20110109192907.GA12403@merkur.ravnborg.org> <4D2F24CD.5040101@suse.cz> <20110113170131.GA28377@merkur.ravnborg.org> <20110114144354.GA23611@sepie.suse.cz> <20110422155349.GA9579@merkur.ravnborg.org> <008401cc02e8$415af510$c410df30$@mprc.pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008401cc02e8$415af510$c410df30$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: 'Michal Marek' <mmarek@suse.cz>, 'lkml' <linux-kernel@vger.kernel.org>, 'linux-kbuild' <linux-kbuild@vger.kernel.org>, 'linux arch' <linux-arch@vger.kernel.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Guan Xuetao' <guanxuetao@mprc.pku.edu.cn>
Message-ID: <20110427194225.xOefI_yf1awm4Gba_XZjw6kJc_k0kjZNcA6scSo6ZTg@z>

> > @@ -349,7 +349,8 @@ CFLAGS_GCOV	= -fprofile-arcs -ftest-coverage
> > 
> >  # Use LINUXINCLUDE when you must reference the include/ directory.
> >  # Needed to be compatible with the O= option
> > -LINUXINCLUDE    := -I$(srctree)/arch/$(hdr-arch)/include -Iinclude \
> > +LINUXINCLUDE    := -I$(srctree)/arch/$(hdr-arch)/include \
> > +                   -Iarch/$(hdr-arch)/include/generated -Iinclude \
> I think $(srctree) is necessary before new include-dir.
> 

The generated files are located in objtree - because they
are generated. So $(srctree) would be wrong here.

> > +PHONY += asm-generic
> > +asm-generic:
> > +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic obj=arch/$(SRCARCH)/include/generated/asm
> Too long
fixed

> >  _dst := $(if $(destination-y),$(destination-y),$(_dst))
> > +_src := $(srctree)/$(obj)
> _src is only used one time
fixed

> > +
> Additional empty line
fixed

> > +        done;                                                           \
> >          touch $@
> > 
> > +
> Additional empty line
fixed

> >  targets += $(install-file)
> > -$(install-file): scripts/headers_install.pl $(input-files) FORCE
> > +$(install-file): scripts/headers_install.pl \
> > +                 $(input-files) FORCE
> The same content
fixed

> I have tested on UniCore32, and it works well.
I take this as "Acked-by" and "Tested-by".

Thanks for feedback - new version to be posted shortly.

	Sam
