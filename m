Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:55675 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755713AbcECJGS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 May 2016 05:06:18 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 24/25] arm64:ilp32: add vdso-ilp32 and use for signal return
Date: Tue, 03 May 2016 11:05:02 +0200
Message-ID: <3846428.6xx69KGEja@wuerfel>
In-Reply-To: <20160503090045.GB10733@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com> <1554541.oDP7Ro5zB2@wuerfel> <20160503090045.GB10733@e104818-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, broonie@kernel.org, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, Yury Norov <ynorov@caviumnetworks.com>, bamvor.zhangjian@huawei.com, joseph@codesourcery.com, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, linux-arm-kernel@lists.infradead.org, christoph.muellner@theobroma-systems.com
Message-ID: <20160503090502.Uq-xL7jklQVqGuEpLLwXNV7t5zk40mTuN-B5XQNlPt4@z>

On Tuesday 03 May 2016 10:00:45 Catalin Marinas wrote:
> On Fri, Apr 29, 2016 at 07:30:19PM +0200, Arnd Bergmann wrote:
> > On Friday 29 April 2016 17:01:55 Catalin Marinas wrote:
> > > On Wed, Apr 06, 2016 at 01:08:46AM +0300, Yury Norov wrote:
> > > > ILP32 VDSO exports next symbols:
> > > >  __kernel_rt_sigreturn;
> > > >  __kernel_gettimeofday;
> > > >  __kernel_clock_gettime;
> > > >  __kernel_clock_getres;
> > > 
> > > [...]
> > > 
> > > > +$(obj)/gettimeofday-ilp32.o: $(src)/../vdso/gettimeofday.S
> > > > + $(call if_changed_dep,vdso-ilp32as)
> > > 
> > > Are struct timeval and timespec the same between ILP32 and LP64? For
> > > example, __kernel_gettimeofday() assumes TVAL_TV_SEC offset defined in
> > > asm-offsets.c based on the LP64 timeval.
> > 
> > No, ilp32 uses the generic 32-bit data structures, which have a 32-bit
> > time_t. I guess that means it can work for little-endian but not
> > big-endian, right?
> 
> I don't think it works for little-endian either. The LP64 struct timeval
> is 16 bytes while the ILP32 one is 8 bytes. The VDSO gettimeofday is
> storing 16 bytes (stp x10, x11, [x0, #TVAL_TV_SEC])

You are right. Yury asked pointed out the same thing on IRC as well.
Using the 64-bit gettimeofday() will put the right number in the
.tv_sec member on little-endian, but will write zeroes to tv_nsec
and corrupt the memory following it.

Yury also tried it out and noticed that for a (so far) unknown reason,
the vdso gets never used by his glibc build, so it has not triggered
any test case failures.

	Arnd
