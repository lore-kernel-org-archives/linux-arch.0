Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam02on0061.outbound.protection.outlook.com ([104.47.36.61]:60096
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751223AbcLETeE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Dec 2016 14:34:04 -0500
Message-ID: <1480966437.29811.23.camel@caviumnetworks.com>
Subject: Re: ILP32 for ARM64: testing with glibc testsuite
From: Steve Ellcey <sellcey@caviumnetworks.com>
Date: Mon, 5 Dec 2016 11:33:57 -0800
In-Reply-To: <mvmeg1mn0yp.fsf@hawking.suse.de>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
         <20161107082359.GA19666@yury-N73SV> <20161109095650.GA22804@yury-N73SV>
         <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
         <1479419136.908.90.camel@caviumnetworks.com>
         <ff3b973b-3887-7ae8-5a27-4d1ad115055f@huawei.com>
         <mvmeg1mn0yp.fsf@hawking.suse.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@suse.de>, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Cc: Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, GNU C Library <libc-alpha@sourceware.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Andrew Pinski <pinskia@gmail.com>, broonie@kernel.org, "Joseph S. Myers" <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, Szabolcs Nagy <szabolcs.nagy@arm.com>, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, kilobyte@angband.pl, Geert Uytterhoeven <geert@linux-m68k.org>, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, manuel.montezelo@gmail.com, linyongting@huawei.com, davem@davemloft.net, zh@suse.de
Message-ID: <20161205193357.vcohWGaTwkwJ4RiVNG1f5qdQT4PRG4QHi2JkfetGu2A@z>

On Mon, 2016-12-05 at 11:07 +0100, Andreas Schwab wrote:
> On Dez 05 2016, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
> wrote:
> 
> > 
> > Is there some progresses on it? We could collabrate to fix those
> > issues.
> All the elf/nptl/rt fails should be fixed by the recent binutils
> fixes.
> 
> Andreas.

I am using binutils ToT and Yury's latest patch (https://sourceware.org
/ml/binutils/2016-12/msg00039.html) and I am still seeing some nptl and
rt failures in the glibc testsuite, specifically:

FAIL: nptl/tst-cancel26
FAIL: nptl/tst-cancel27
FAIL: nptl/tst-stack4
FAIL: rt/tst-mqueue1
FAIL: rt/tst-mqueue2
FAIL: rt/tst-mqueue4
FAIL: rt/tst-mqueue7

Steve Ellcey
sellcey@caviumnetworks.com
