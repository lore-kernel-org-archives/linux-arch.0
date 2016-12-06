From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: ILP32 for ARM64: testing with glibc testsuite
Date: Tue, 6 Dec 2016 10:59:18 +0530
Message-ID: <20161206052918.GA12474@yury-N73SV>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161107082359.GA19666@yury-N73SV>
 <20161109095650.GA22804@yury-N73SV>
 <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
 <1479419136.908.90.camel@caviumnetworks.com>
 <ff3b973b-3887-7ae8-5a27-4d1ad115055f@huawei.com>
 <mvmeg1mn0yp.fsf@hawking.suse.de>
 <d4dedc32-b324-107d-7de1-d1e670ffc00a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam03on0068.outbound.protection.outlook.com ([104.47.42.68]:11344
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751225AbcLFF3l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Dec 2016 00:29:41 -0500
Content-Disposition: inline
In-Reply-To: <d4dedc32-b324-107d-7de1-d1e670ffc00a@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Cc: Andreas Schwab <schwab@suse.de>, Steve Ellcey <sellcey@caviumnetworks.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, GNU C Library <libc-alpha@sourceware.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Andrew Pinski <pinskia@gmail.com>, broonie@kernel.org, "Joseph S. Myers" <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, Szabolcs Nagy <szabolcs.nagy@arm.com>, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, kilobyte@angband.pl, Geert Uytterhoeven <geert@linux-m68k.org>, Dr. Philipp

On Mon, Dec 05, 2016 at 06:24:11PM +0800, Zhangjian (Bamvor) wrote:
> 
> 
> On 2016/12/5 18:07, Andreas Schwab wrote:
> >On Dez 05 2016, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com> wrote:
> >
> >>Is there some progresses on it? We could collabrate to fix those issues.
> >
> >All the elf/nptl/rt fails should be fixed by the recent binutils fixes.
> Cool. How about the conform and other failures?

I think conform is only my local problem. I use pretty non-standard
environment for build and testing - cross-compilation + qemu. Steve
builds and runs tests natively, and he doesn't see that regressions.

Yury
