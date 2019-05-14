Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44188 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfENXDL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 May 2019 19:03:11 -0400
Date: Tue, 14 May 2019 16:01:58 -0700
From: Yury Norov <yury.norov@gmail.com>
Subject: Re: [LTP] [EXT] Re: [PATCH v9 00/24] ILP32 for ARM64
Message-ID: <20190514230158.GA6780@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20190508225900.GA14091@yury-thinkpad>
 <mvmtvdyoi33.fsf@suse.de>
 <MN2PR18MB30865B950D85C6463EB0E1D4CB0F0@MN2PR18MB3086.namprd18.prod.outlook.com>
 <20190514104311.GA24708@rei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514104311.GA24708@rei>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Yuri Norov <ynorov@marvell.com>, Andreas Schwab <schwab@suse.de>, "ltp@lists.linux.it" <ltp@lists.linux.it>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Joseph Myers <joseph@codesourcery.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Steve Ellcey <sellcey@caviumnetworks.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Alexander Graf <agraf@suse.de>, Bamvor Zhangjian <bamv2005@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Dave Martin <Dave.Martin@arm.com>, Adam Borowski <kilobyte@angband.pl>, Manuel Montezelo <manuel.montezelo@gmail.com>, James Hogan <james.hogan@imgtec.com>, Chris Metcalf <cmetcalf@mellanox.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Pinski <pinskia@gmail.com>, Lin Yongting <linyongting@huawei.com>, Alexey Klimov <klimov.linux@gmail.com>, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Florian Weimer <fweimer@redhat.com>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Nathan_Lynch <Nathan_Lynch@mentor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ramana Radhakrishnan <ramana.gcc@googlemail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "David S . Miller" <davem@davemloft.net>, Christoph Muellner <christoph.muellner@theobroma-systems.com>
Message-ID: <20190514230158.kgiQ5_eCVG1VaBuQaDE6I-6ghBGsNXK2mpu-8VEv8Mk@z>

On Tue, May 14, 2019 at 12:43:11PM +0200, Cyril Hrubis wrote:
> Hi!
> > > There is a problem with the stack size accounting during execve when
> > > there is no stack limit:
> > >
> > > $ ulimit -s
> > > 8192
> > > $ ./hello.ilp32 
> > > Hello World!
> > > $ ulimit -s unlimited
> > > $ ./hello.ilp32 
> > > Segmentation fault
> > > $ strace ./hello.ilp32 
> > > execve("./hello.ilp32", ["./hello.ilp32"], 0xfffff10548f0 /* 77 vars */) = -1 ENOMEM (Cannot allocate memory)
> > > +++ killed by SIGSEGV +++
> > > Segmentation fault (core dumped)
> > >
> > > Andreas.
> > 
> > Thanks Andreas, I will take a look. Do we have such test in LTP?

So the problem was in not converting new compat-sensitive code:

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 5bdf357169d8..c509f83fa506 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -63,7 +63,7 @@
 				TASK_SIZE_32 : TASK_SIZE_64)
 #define TASK_SIZE_OF(tsk)	(is_compat_thread(tsk) ? \
 				TASK_SIZE_32 : TASK_SIZE_64)
-#define DEFAULT_MAP_WINDOW	(test_thread_flag(TIF_32BIT) ? \
+#define DEFAULT_MAP_WINDOW	(is_compat_task() ? \
 				TASK_SIZE_32 : DEFAULT_MAP_WINDOW_64)
 #else
 #define TASK_SIZE		TASK_SIZE_64

The fix is incorporated in ilp32-5.1.1:
https://github.com/norov/linux/tree/ilp32-5.1.1

> We do have a test that we can run a binary with very small stack size
> i.e. 512kB but there does not seem to be anything that would catch this
> specific problem.
> 
> Can you please open an issue and describe how to reproduce the problem
> at our github tracker:
> 
> https://github.com/linux-test-project/ltp/issues
> 
> Then we can create testcase based on that reproducer later on.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

OK, I'll do.

Yury
