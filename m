Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam02on0084.outbound.protection.outlook.com ([104.47.36.84]:16800
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751995AbcKRATT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Nov 2016 19:19:19 -0500
Message-ID: <1479419136.908.90.camel@caviumnetworks.com>
Subject: Re: ILP32 for ARM64: testing with glibc testsuite
From: Steve Ellcey <sellcey@caviumnetworks.com>
Date: Thu, 17 Nov 2016 13:45:36 -0800
In-Reply-To: <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
         <20161107082359.GA19666@yury-N73SV> <20161109095650.GA22804@yury-N73SV>
         <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, GNU C Library <libc-alpha@sourceware.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Andrew Pinski <pinskia@gmail.com>, broonie@kernel.org, "Joseph S. Myers" <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, Szabolcs Nagy <szabolcs.nagy@arm.com>, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, kilobyte@angband.pl, Geert Uytterhoeven <geert@linux-m68k.org>, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, manuel.montezelo@gmail.com, linyongting@huawei.com, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com, Adhemerval Zanella <adhemerval.zanella@linaro.org>
Message-ID: <20161117214536.jSCMltRiOdhXhnVrL2kp0IS6tWN-XQfUmG7EdCYevaQ@z>

On Wed, 2016-11-16 at 15:22 +0400, Maxim Kuvyrkov wrote:
> > 
> > On Nov 9, 2016, at 1:56 PM, Yury Norov <ynorov@caviumnetworks.com>
> > wrote:
> > 
> > > 
> > > Below is the results of glibc testsuite run for aarch64/lp64

I have been running the glibc testsuite as well.  I have only run it on
an ILP32 enabled kernel.  Using that kernel, top-of-tree glibc, and the
ILP32 glibc patches I have no LP64 regressions.  There are 5 failures
in LP64 mode but I get them with vanilla top-of-tree glibc sources too.
They are:
	nptl/eintr1 (I actually don't run this because it kills the 'make check')
	debug/tst-backtrace5
	debug/tst-backtrace6
	nptl/tst-stack4
	nptl/tst-thread_local1

In ILP32 mode I get 33 failures, they include the above failures (minus
nptl/tst-thread_local1) plus:

	c++-types-check
	conform/ISO11/inttypes.h/conform
	conform/ISO11/stdint.h/conform
	conform/ISO99/inttypes.h/conform
	conform/ISO99/stdint.h/conform
	conform/POSIX2008/inttypes.h/conform
	conform/POSIX2008/stdint.h/conform
	conform/XOPEN2K/inttypes.h/conform
	conform/XOPEN2K/stdint.h/conform
	conform/XOPEN2K8/inttypes.h/conform
	conform/XOPEN2K8/stdint.h/conform
	elf/tst-tls1
	elf/tst-tls1-static
	elf/tst-tls2
	elf/tst-tls2-static
	elf/tst-tls3
	math/check-abi-libm
	math/test-double
	math/test-double-finite
	math/test-float
	math/test-float-finite
	misc/tst-sync_file_range
	nptl/tst-cancel26
	nptl/tst-cancel27
	nptl/tst-sem3
	rt/tst-mqueue1
	rt/tst-mqueue2
	rt/tst-mqueue4
	rt/tst-mqueue7
	stdlib/tst-makecontext3

I am currently looking at these ILP32 regressions (starting with the
tls failures) to see if I can figure out what is happening with them.

Steve Ellcey
sellcey@caviumnetworks.com
