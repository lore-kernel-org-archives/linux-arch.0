Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44004 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfF1QuU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jun 2019 12:50:20 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190628165018euoutp0121f2c82f48fbc8897dc34f2a3ad6ac4e~satF61Su82831028310euoutp01j
        for <linux-arch@vger.kernel.org>; Fri, 28 Jun 2019 16:50:18 +0000 (GMT)
Subject: Re: [PATCH v7 04/25] arm64: Substitute gettimeofday with C
 implementation
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <530cd07e-0da7-1d83-be4e-b14813029424@samsung.com>
Date: Fri, 28 Jun 2019 18:50:13 +0200
MIME-Version: 1.0
In-Reply-To: <27386d82-2906-b541-f71d-3c61f5099bdf@arm.com>
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
        <20190621095252.32307-5-vincenzo.frascino@arm.com>
        <CGME20190628130921eucas1p239935b0771032c331911eacc1a69dd2e@eucas1p2.samsung.com>
        <1fd47b0d-f77f-8d07-c039-6ac9072834fc@samsung.com>
        <27386d82-2906-b541-f71d-3c61f5099bdf@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Andre Przywara <andre.przywara@arm.com>, Arnd Bergmann <arnd@arndb.de>, Huw Davies <huw@codeweavers.com>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Thomas Gleixner <tglx@linutronix.de>, Shijith Thotton <sthotton@marvell.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20190628165013.cVCl7X-oEWGjL79M3iDzMDomoRxMiK3NPmcdp9YU8DY@z>

Hi Vincenzo,

On 6/28/19 16:32, Vincenzo Frascino wrote:
> On 6/28/19 2:09 PM, Marek Szyprowski wrote:
>> On 2019-06-21 11:52, Vincenzo Frascino wrote:
>>> To take advantage of the commonly defined vdso interface for
>>> gettimeofday the architectural code requires an adaptation.
>>>
>>> Re-implement the gettimeofday vdso in C in order to use lib/vdso.
>>>
>>> With the new implementation arm64 gains support for CLOCK_BOOTTIME
>>> and CLOCK_TAI.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>> Tested-by: Shijith Thotton <sthotton@marvell.com>
>>> Tested-by: Andre Przywara <andre.przywara@arm.com>
>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>
>> This patch causes serious regression on Samsung Exynos5433 SoC based 
>> TM2(e) boards. The time in userspace is always set to begin of the epoch:
>>
>> # date 062813152019
>> Fri Jun 28 13:15:00 UTC 2019
>> # date
>> Thu Jan  1 00:00:00 UTC 1970
>> # date
>> Thu Jan  1 00:00:00 UTC 1970
>>
>> I've noticed that since the patch landed in Linux next-20190625 and 
>> bisect indeed pointed to this patch.
>>
> Thank you for reporting this, seems that the next that you posted is missing
> some fixes for arm64.
> 
> Could you please try the tree below?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
> 
> Let us know if the functionality is restored. Otherwise the issue will require
> further investigation.
 
Marek is already out for holidays, I gave your tree a try but kernel from 
that branch was failing to boot on TM2(e).  

Then I have cherry-picked 5 patches from the branch that seemed to 
be missing in next-20190628:

28028f3174cf1 (HEAD) MAINTAINERS: Fix Andy's surname and the directory entries of VDSO
ec8f8e4bf2206 arm64: vdso: Fix compilation with clang older than 8
721882ebb5729 arm64: compat: Fix __arch_get_hw_counter() implementation
7027fea977a3d arm64: Fix __arch_get_hw_counter() implementation
10b305853fe22 lib/vdso: Make delta calculation work correctly
48568d8c7f479 (tag: next-20190628, linux-next/master) Add linux-next specific files for 20190628

With those 5 additional patches on top of next-20190628 the problem
is not observed any more. date, ping, etc. seems to be working well.

# date
Fri Jun 28 16:39:22 UTC 2019
#
# systemctl stop systemd-timesyncd
#  
# date 062818392019
Fri Jun 28 18:39:00 UTC 2019
# date
Fri Jun 28 18:39:01 UTC 2019
# 
# date 062818432019; date
Fri Jun 28 18:43:00 UTC 2019
Fri Jun 28 18:43:00 UTC 2019
# date
Fri Jun 28 18:43:04 UTC 2019

--
Regards,
Sylwester
