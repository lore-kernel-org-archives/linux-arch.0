Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam03on0076.outbound.protection.outlook.com ([104.47.42.76]:3718
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751032AbdA3F7l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Jan 2017 00:59:41 -0500
Date: Mon, 30 Jan 2017 11:12:52 +0530
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH v7 00/20] ILP32 for ARM64
Message-ID: <20170130054252.GB6156@yury-N73SV>
References: <1483961397-8599-1-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1483961397-8599-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Pinski <pinskia@gmail.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, Adam Borowski <kilobyte@angband.pl>, Chris Metcalf <cmetcalf@ezchip.com>, Steve Ellcey <sellcey@caviumnetworks.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Ramana Radhakrishnan <ramana.gcc@googlemail.com>, Florian Weimer <fweimer@redhat.com>, Bamvor Zhangjian <bamvor.zhangjian@huawei.com>, Andreas Schwab <schwab@suse.de>, Chris Metcalf <cmetcalf@mellanox.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, schwidefsky@de.ibm.com, broonie@kernel.org, Joseph Myers <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, davem@davemloft.net, zhouchengming1@huawei.com
Message-ID: <20170130054252.aL_tndTIwmS4xLhrrG9dVVWge0BhxdqcfmUr2Sa-VyQ@z>

On Mon, Jan 09, 2017 at 04:59:37PM +0530, Yury Norov wrote:
> This series enables aarch64 with ilp32 mode.
> 
> As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> option that is enabled for existing 32-bit architectures but disabled
> for new arches (so 64-bit off_t is is used by new userspace). Also it
> deprecates getrlimit and setrlimit syscalls prior to prlimit64.
> 
> This version is based on linux-next from 2017-01-09. It works with
> glibc-2.25, and tested with LTP, glibc testsuite, trinity, lmbench,
> CPUSpec.
> 
> This is not RFC anymore. I believe that all ABI and implementation
> issues are resolved now. The way that kernel clears registers top
> halves is probably the last question, and because there's no objection
> for current approach for more that 6 month, I think, community agrees
> with it.
> 
> Patches 1, 2, 3 and 8 are general, and may be applied separately.
> 
> Current version does not introduce ABI changes comparing to RFC3.
> Kernel and GLIBC trees:
> https://github.com/norov/linux/tree/ilp32-2017-01-09
> https://github.com/norov/glibc/tree/dev9

Hi Arnd, Catalin,

Is there any progress with review? I particularly ask about generic
patches (1-3, 8). They all reviewed, and most of them acked by you,
but they are still not upstreamed.

Yury
