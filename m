Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752041AbcLFIcm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Dec 2016 03:32:42 -0500
From: Andreas Schwab <schwab@suse.de>
Subject: Re: ILP32 for ARM64: testing with glibc testsuite
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
        <20161107082359.GA19666@yury-N73SV>
        <20161109095650.GA22804@yury-N73SV>
        <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
        <1479419136.908.90.camel@caviumnetworks.com>
        <ff3b973b-3887-7ae8-5a27-4d1ad115055f@huawei.com>
        <mvmeg1mn0yp.fsf@hawking.suse.de>
        <1480966437.29811.23.camel@caviumnetworks.com>
Date: Tue, 06 Dec 2016 09:31:27 +0100
In-Reply-To: <1480966437.29811.23.camel@caviumnetworks.com> (Steve Ellcey's
        message of "Mon, 5 Dec 2016 11:33:57 -0800")
Message-ID: <mvm37i1laqo.fsf@hawking.suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Ellcey <sellcey@caviumnetworks.com>
Cc: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, GNU C Library <libc-alpha@sourceware.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Andrew Pinski <pinskia@gmail.com>, broonie@kernel.org, "Joseph S. Myers" <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, Szabolcs Nagy <szabolcs.nagy@arm.com>, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, kilobyte@angband.pl, Geert Uytterhoeven <geert@linux-m68k.org>, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, manuel.montezelo@gmail.com, linyongting@huawei.com, davem@davemloft.net, zh@suse.de
Message-ID: <20161206083127.21xcoC5W7MyIMoL3oxXmYVVJtYCBBf0ROGwxFWZ6Bkc@z>

On Dez 05 2016, Steve Ellcey <sellcey@caviumnetworks.com> wrote:

> FAIL: nptl/tst-cancel26
> FAIL: nptl/tst-cancel27

> FAIL: rt/tst-mqueue1
> FAIL: rt/tst-mqueue2
> FAIL: rt/tst-mqueue4
> FAIL: rt/tst-mqueue7

I don't see these failures.  Maybe you need to rebuild libgcc?

https://build.opensuse.org/package/live_build_log/devel:ARM:AArch64:ILP32/glibc-testsuite/standard/aarch64_ilp32

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
