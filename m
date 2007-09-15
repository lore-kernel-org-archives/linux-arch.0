Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:56865 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbXIOB2H (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Sep 2007 21:28:07 -0400
Received: by rv-out-0910.google.com with SMTP id k20so827483rvb
        for <linux-arch@vger.kernel.org>; Fri, 14 Sep 2007 18:28:06 -0700 (PDT)
Message-ID: <8bd0f97a0709141828p6ed05f5dm9cea104714b37a0d@mail.gmail.com>
Date: Fri, 14 Sep 2007 21:28:06 -0400
From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] Re: [PATCH] Blackfin arch: add some missing syscall
In-Reply-To: <1189755148.8165.15.camel@roc-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1189670203.30686.15.camel@roc-desktop>
	 <20070913081852.GC17367@parisc-linux.org>
	 <8bd0f97a0709130137l55977c28w95cf8527ae8b9e24@mail.gmail.com>
	 <1189673849.30686.28.camel@roc-desktop> <46E918FD.3070607@t-online.de>
	 <1189748718.5133.23.camel@roc-desktop>
	 <8bd0f97a0709132344w136f2df5ncfe4496c6c895bd8@mail.gmail.com>
	 <1189755148.8165.15.camel@roc-desktop>
Sender: linux-arch-owner@vger.kernel.org
To: bryan.wu@analog.com
Cc: Bernd Schmidt <bernds_cb1@t-online.de>, bernd.schmidt@analog.com, linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, Linux Kernel <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On 9/14/07, Bryan Wu <bryan.wu@analog.com> wrote:
> On Fri, 2007-09-14 at 02:44 -0400, Mike Frysinger wrote:
> > On 9/14/07, Bryan Wu <bryan.wu@analog.com> wrote:
> > > On Thu, 2007-09-13 at 13:03 +0200, Bernd Schmidt wrote:
> > > > Bryan Wu wrote:
> > > > >>> but mremap doesn't -- there's even an implementation in mm/nommu.c.
> > > > >>> Could you check the rest of these over to see if they truly don't need
> > > > >>> to be implemented for no-mmu?
> > > > >> you're right we want mremap, my fault
> > > > >>
> > > > >
> > > > > Yes, I do think so, both sys_mremap and sys_munmap are implemented in
> > > > > mm/nommu.c. How do think of this, Bernd?
> > > >
> > > > There's a mremap in nommu.c, but it doesn't do a lot that is useful.
> > > > With some further mm changes in our tree, it's little more than a fancy
> > > > way of saying munmap, and uClibc does not use it, so there's no
> > > > compelling need to have it in userspace.
> > >
> > > Make sense. So currently Blackfin uClinux use the mremap/munmap in
> > > uClibc?
> >
> > most functions like this dont have any real libc component ... uClibc
> > will define userspace symbols that merely make a syscall iff the __NR_
> > exists in the headers
> >
> > if we have __NR_mremap in our unistd.h, we'll automagically get the
> > mremap() symbol in uClibc which simply passes along the args to the
> > kernel
>
> Yes, I know this. But currently, __NR_mremap does not exit in Blackfin
> unistd.h:
> /* 163 __NR_mremap */.
>
> So the implementation of this kind syscalls should be in uClibc, right?

no ... if the kernel supports it, uClibc supports ... if the kernel
doesnt support, uClibc doesnt support it

adding a ghetto userspace implementation to workaround this is weak
... that'll just mean random bugs may crop up on us that dont exist
for any other architecture simply because we opted not to hook up the
common kernel version

either we support it and have the kernel pull in the common one or we
dont support ... no middle ground here
-mike
