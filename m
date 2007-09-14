Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:16583 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbXINHgT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Sep 2007 03:36:19 -0400
Subject: Re: [Uclinux-dist-devel] Re: [PATCH] Blackfin arch: add some
	missing syscall
From: Bryan Wu <bryan.wu@analog.com>
Reply-To: bryan.wu@analog.com
In-Reply-To: <8bd0f97a0709132344w136f2df5ncfe4496c6c895bd8@mail.gmail.com>
References: <1189670203.30686.15.camel@roc-desktop>
	 <20070913081852.GC17367@parisc-linux.org>
	 <8bd0f97a0709130137l55977c28w95cf8527ae8b9e24@mail.gmail.com>
	 <1189673849.30686.28.camel@roc-desktop> <46E918FD.3070607@t-online.de>
	 <1189748718.5133.23.camel@roc-desktop>
	 <8bd0f97a0709132344w136f2df5ncfe4496c6c895bd8@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Sep 2007 15:32:28 +0800
Message-Id: <1189755148.8165.15.camel@roc-desktop>
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: bryan.wu@analog.com, Bernd Schmidt <bernds_cb1@t-online.de>, bernd.schmidt@analog.com, linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, Linux Kernel <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2007-09-14 at 02:44 -0400, Mike Frysinger wrote:
> On 9/14/07, Bryan Wu <bryan.wu@analog.com> wrote:
> > On Thu, 2007-09-13 at 13:03 +0200, Bernd Schmidt wrote:
> > > Bryan Wu wrote:
> > > >>> but mremap doesn't -- there's even an implementation in mm/nommu.c.
> > > >>> Could you check the rest of these over to see if they truly don't need
> > > >>> to be implemented for no-mmu?
> > > >> you're right we want mremap, my fault
> > > >>
> > > >
> > > > Yes, I do think so, both sys_mremap and sys_munmap are implemented in
> > > > mm/nommu.c. How do think of this, Bernd?
> > >
> > > There's a mremap in nommu.c, but it doesn't do a lot that is useful.
> > > With some further mm changes in our tree, it's little more than a fancy
> > > way of saying munmap, and uClibc does not use it, so there's no
> > > compelling need to have it in userspace.
> >
> > Make sense. So currently Blackfin uClinux use the mremap/munmap in
> > uClibc?
> 
> most functions like this dont have any real libc component ... uClibc
> will define userspace symbols that merely make a syscall iff the __NR_
> exists in the headers
> 
> if we have __NR_mremap in our unistd.h, we'll automagically get the
> mremap() symbol in uClibc which simply passes along the args to the
> kernel

Yes, I know this. But currently, __NR_mremap does not exit in Blackfin
unistd.h:
/* 163 __NR_mremap */.

So the implementation of this kind syscalls should be in uClibc, right?

And Bernd said that the kernel version mremap/munmap is not very useful
for Blackfin arch. I think mremap/munmap can be ignored in Blackfin.

Thanks
-Bryan
