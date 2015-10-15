Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from port70.net ([81.7.13.123]:33892 "EHLO port70.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805AbbJOPKJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Oct 2015 11:10:09 -0400
Date: Thu, 15 Oct 2015 17:10:06 +0200
From: Szabolcs Nagy <nsz@port70.net>
Subject: Re: [PATCHv3] ARM64:Fix MINSIGSTKSZ and SIGSTKSZ
Message-ID: <20151015151006.GT10551@port70.net>
References: <1444386580-10917-1-git-send-email-manjeet.p@samsung.com>
 <20151009103352.GK26278@arm.com>
 <20151015121241.GA26080@port70.net>
 <20151015124756.GB27524@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151015124756.GB27524@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Manjeet Pawar <manjeet.p@samsung.com>, catalin.marinas@arm.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, pankaj.m@samsung.com, Akhilesh Kumar <akhilesh.k@samsung.com>, Rohit Thapliyal <r.thapliyal@samsung.com>
Message-ID: <20151015151006.xf_6vQXUWejao-sCvbUh5NCPUmtu2N-IwVJgQhgob9E@z>

* Will Deacon <will.deacon@arm.com> [2015-10-15 13:47:56 +0100]:
> On Thu, Oct 15, 2015 at 02:12:41PM +0200, Szabolcs Nagy wrote:
> > * Will Deacon <will.deacon@arm.com> [2015-10-09 11:33:52 +0100]:
> > 
> > > On Fri, Oct 09, 2015 at 03:59:40PM +0530, Manjeet Pawar wrote:
> > > > MINSIGSTKSZ and SIGSTKSZ for ARM64 are not correctly set in latest kernel.
> > > > This patch fixes this issue.
> > > > 
> > > > This issue is reported in LTP (testcase: sigaltstack02.c).
> > > > Testcase failed when sigaltstack() called with stack size "MINSIGSTKSZ - 1"
> > > > Since in Glibc-2.22, MINSIGSTKSZ is set to 5120 but in kernel
> > > > it is set to 2048 so testcase gets failed.
> > > > 
> > > > Testcase Output:
> > > > sigaltstack02 1  TPASS  :  stgaltstack() fails, Invalid Flag value,errno:22
> > > > sigaltstack02 2  TFAIL  :  sigaltstack() returned 0, expected -1,errno:12
> > > 
> > > I'm still unable to reproduce this failure. Is this with defconfig?
> > > 
> > > > Reported Issue in Glibc Bugzilla:
> > > > Bugfix in Glibc-2.22: [Bug 16850]
> > > > https://sourceware.org/bugzilla/show_bug.cgi?id=16850
> > > > 
> > > > Signed-off-by: Akhilesh Kumar <akhilesh.k@samsung.com>
> > > > Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
> > > > Signed-off-by: Rohit Thapliyal <r.thapliyal@samsung.com>
> > > > ---
> > > > v1 -> Changes in uapi overall header
> > > > v2 -> Changes done in arm64 headers
> > > > v3 -> Changes done in both uapi & arm64 headers
> > > > 
> > > >  arch/arm64/include/uapi/asm/signal.h |    3 +++
> > > >  include/uapi/asm-generic/signal.h    |    2 ++
> > > >  2 files changed, 5 insertions(+)
> > > 
> > > Acked-by: Will Deacon <will.deacon@arm.com>
> > > 
> > > Arnd: are you planning to take this via asm-generic, or shall I queue it
> > > on the arm64 fixes branch?
> > > 
> > 
> > i just noticed this and wanted to note that an old
> > glibc can fail on a new kernel with this patch if
> > an application uses MINSIGSTKSZ altstack.
> 
> I was worried about that (which was also why I didn't Cc stable on this,
> because we shouldn't pretend that glibc and the kernel are synchronised),
> but the value *is* incorrect and glibc has already been updated. In
> other words, not merging this patch is also problematic, because we're
> advertising a size that's significantly too small.
> 
> Would you rather we kept the old incorrect value in the kernel headers?
> 

i think the change is ok and it is good that it is not yet in stable.

(for posix conformance only the value in libc matters though, the
kernel definition is not visible as glibc does not use it and even
in posix the semantics of this macro is not entirely clear so leaving
the wrong value in kernel uapi is not that terrible.. e.g. the x86
definition was not updated when avx extension was added, for abi
stability i guess.  in musl libc this was set to 6K when i did the
aarch64 port, had i used 5000 as the limit i would be upset by such
a change, but i have nothing to complain about now..)
