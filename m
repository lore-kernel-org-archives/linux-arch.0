Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:2053 "EHLO
        dggrg05-dlp.huawei.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751244AbcLEKZd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2016 05:25:33 -0500
Subject: Re: ILP32 for ARM64: testing with glibc testsuite
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161107082359.GA19666@yury-N73SV> <20161109095650.GA22804@yury-N73SV>
 <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
 <1479419136.908.90.camel@caviumnetworks.com>
 <ff3b973b-3887-7ae8-5a27-4d1ad115055f@huawei.com>
 <mvmeg1mn0yp.fsf@hawking.suse.de>
From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Message-ID: <d4dedc32-b324-107d-7de1-d1e670ffc00a@huawei.com>
Date: Mon, 5 Dec 2016 18:24:11 +0800
MIME-Version: 1.0
In-Reply-To: <mvmeg1mn0yp.fsf@hawking.suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Steve Ellcey <sellcey@caviumnetworks.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, GNU C Library <libc-alpha@sourceware.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Andrew Pinski <pinskia@gmail.com>, broonie@kernel.org, "Joseph S. Myers" <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, Szabolcs Nagy <szabolcs.nagy@arm.com>, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, kilobyte@angband.pl, Geert Uytterhoeven <geert@linux-m68k.org>, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, manuel.montezelo@gmail.com, linyongting@huawei.com, davem@davemloft.net, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Message-ID: <20161205102411.jn9dLkNpxW3w4wcMADJz-mBIYE52UL23ou5kXv22C7o@z>



On 2016/12/5 18:07, Andreas Schwab wrote:
> On Dez 05 2016, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com> wrote:
>
>> Is there some progresses on it? We could collabrate to fix those issues.
>
> All the elf/nptl/rt fails should be fixed by the recent binutils fixes.
Cool. How about the conform and other failures?

Regards

Bamvor
>
> Andreas.
>

