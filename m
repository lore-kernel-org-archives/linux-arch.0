From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 16/18] arm64: ptrace: handle ptrace_request differently
 for aarch32 and ilp32
Date: Thu, 8 Dec 2016 13:12:32 +0000
Message-ID: <20161208131232.GA15141@e104818-lin.cambridge.arm.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161206062508.GA17835@yury-N73SV>
 <20161207165913.GD31779@e104818-lin.cambridge.arm.com>
 <3703608.GKr1zzErMk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751577AbcLHNNh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Dec 2016 08:13:37 -0500
Content-Disposition: inline
In-Reply-To: <3703608.GKr1zzErMk@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-doc@vger.kernel.org, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, Yury Norov <ynorov@caviumnetworks.com>, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, linux-arch@vger.kernel.org, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com

On Wed, Dec 07, 2016 at 09:40:13PM +0100, Arnd Bergmann wrote:
> On Wednesday, December 7, 2016 4:59:13 PM CET Catalin Marinas wrote:
> > On Tue, Dec 06, 2016 at 11:55:08AM +0530, Yury Norov wrote:
> > > On Mon, Dec 05, 2016 at 04:34:23PM +0000, Catalin Marinas wrote:
> > > > On Fri, Oct 21, 2016 at 11:33:15PM +0300, Yury Norov wrote:
> > > > > New aarch32 ptrace syscall handler is introduced to avoid run-time
> > > > > detection of the task type.
> > > > 
> > > > What's wrong with the run-time detection? If it's just to avoid a
> > > > negligible overhead, I would rather keep the code simpler by avoiding
> > > > duplicating the generic compat_sys_ptrace().
> > > 
> > > Nothing wrong. This is how Arnd asked me to do. You already asked this
> > > question: http://lkml.iu.edu/hypermail/linux/kernel/1604.3/00930.html
> > 
> > Hmm, I completely forgot about this ;). There is still an advantage to
> > doing run-time checking if we avoid touching core code (less acks to
> > gather and less code duplication).
> > 
> > Let's see what Arnd says but the initial patch looked simpler.
> 
> I don't currently have either version of the patch in my inbox
> (the archive is on a different machine), but in general I'd still
> think it's best to avoid the runtime check for aarch64-ilp32
> altogether. I'd have to look at the overall kernel source to
> see if it's worth avoiding one or two instances though, or
> if there are an overwhelming number of other checks that we
> can't avoid at all.

Just in case you haven't found them already, current version:

https://marc.info/?l=linux-arm-kernel&m=147708276818318&w=2

Original version:

https://patchwork.kernel.org/patch/7980521/

The old one looks more readable and given that ptrace is not really a
fast path, I'm not two worried about run-time checks

> Regarding ptrace, I notice that arch/tile doesn't even use
> the compat entry point for its ilp32 user space on 64-bit
> kernels, it just calls the regular 64-bit one. Would that
> help here?

I don't know whether it would work, we have incompatible siginfo_t on
AArch64/ILP32.

-- 
Catalin
