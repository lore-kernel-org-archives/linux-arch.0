Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933482AbcKQRHV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Nov 2016 12:07:21 -0500
Date: Thu, 17 Nov 2016 08:50:56 -0700
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: ILP32 for ARM64: testing with glibc testsuite
Message-ID: <20161117155056.6xkldspks6dwoj7z@localhost>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161107082359.GA19666@yury-N73SV>
 <20161109095650.GA22804@yury-N73SV>
 <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Cc: Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, GNU C Library <libc-alpha@sourceware.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Andrew Pinski <pinskia@gmail.com>, broonie@kernel.org, "Joseph S. Myers" <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, Szabolcs Nagy <szabolcs.nagy@arm.com>, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, kilobyte@angband.pl, Geert Uytterhoeven <geert@linux-m68k.org>, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, manuel.montezelo@gmail.com, linyongting@huawei.com, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com, Adhemerval Zanella <adhemerval.zanella@linaro.org>, Steve Ellcey <sellcey@caviumnetworks.com>
Message-ID: <20161117155056.VwJgTbIlHFXf13h1xaOjP4-JChaP8lFTCeV-GFh4qw0@z>

On Wed, Nov 16, 2016 at 03:22:26PM +0400, Maxim Kuvyrkov wrote:
> Regarding ILP32 runtime, my opinion is that it is acceptable for ILP32
> to have extra failures compared to LP64, since these are not
> regressions, but, rather, failures of a new configuration.

I disagree with this. We definitely need to understand why they fail,
otherwise we run the risk of potential glibc or kernel implementation
bugs becoming ABI.

-- 
Catalin
