Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50347 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbfGHM5T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jul 2019 08:57:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190708125716euoutp0221220be68333346b7729d7d1979eeb9b~vb_fGgwrk1882318823euoutp02a
        for <linux-arch@vger.kernel.org>; Mon,  8 Jul 2019 12:57:16 +0000 (GMT)
Subject: Re: [PATCH v7 04/25] arm64: Substitute gettimeofday with C
 implementation
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <ed758c10-7260-bec3-caf1-08cae7e0968d@samsung.com>
Date: Mon, 8 Jul 2019 14:57:11 +0200
MIME-Version: 1.0
In-Reply-To: <06c264a8-8778-18b1-1094-4281a4a2abc9@arm.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
        <20190621095252.32307-5-vincenzo.frascino@arm.com>
        <CGME20190628130921eucas1p239935b0771032c331911eacc1a69dd2e@eucas1p2.samsung.com>
        <1fd47b0d-f77f-8d07-c039-6ac9072834fc@samsung.com>
        <27386d82-2906-b541-f71d-3c61f5099bdf@arm.com>
        <530cd07e-0da7-1d83-be4e-b14813029424@samsung.com>
        <06c264a8-8778-18b1-1094-4281a4a2abc9@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Andre Przywara <andre.przywara@arm.com>, Arnd Bergmann <arnd@arndb.de>, Huw Davies <huw@codeweavers.com>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Thomas Gleixner <tglx@linutronix.de>, Shijith Thotton <sthotton@marvell.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20190708125711.ES8mB9NqBdSV2aKn8CCyYZKB-D1mGT4oWsIS8ZvMVsI@z>

Hi Vincenzo, 

On 6/29/19 08:58, Vincenzo Frascino wrote:
> If I may, I would like to ask to you one favor, could you please keep an eye on
> next and once those patches are merged repeat the test?
> 
> I want just to make sure that the regression does not reappear.

My apologies, I forgot about this for a moment. I repeated the test with 
next-20190705 tag and couldn't see any regressions.

-- 
Regards,
Sylwester
