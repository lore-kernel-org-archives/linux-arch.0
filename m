From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 16/18] arm64: ptrace: handle ptrace_request differently
 for aarch32 and ilp32
Date: Tue, 6 Dec 2016 11:55:08 +0530
Message-ID: <20161206062508.GA17835@yury-N73SV>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <1477081997-4770-17-git-send-email-ynorov@caviumnetworks.com>
 <20161205163422.GG14429@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-cys01nam02on0049.outbound.protection.outlook.com ([104.47.37.49]:41299
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751139AbcLFGZ1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Dec 2016 01:25:27 -0500
Content-Disposition: inline
In-Reply-To: <20161205163422.GG14429@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com

On Mon, Dec 05, 2016 at 04:34:23PM +0000, Catalin Marinas wrote:
> On Fri, Oct 21, 2016 at 11:33:15PM +0300, Yury Norov wrote:
> > New aarch32 ptrace syscall handler is introduced to avoid run-time
> > detection of the task type.
> 
> What's wrong with the run-time detection? If it's just to avoid a
> negligible overhead, I would rather keep the code simpler by avoiding
> duplicating the generic compat_sys_ptrace().

Nothing wrong. This is how Arnd asked me to do. You already asked this
question: http://lkml.iu.edu/hypermail/linux/kernel/1604.3/00930.html

If it's still looking weird to you, I can switch back to runtime
ptrace. But I'd like to see Arnd's opinion.

Yury.
