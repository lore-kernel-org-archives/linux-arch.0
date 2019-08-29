Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:47470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbfH2Pwj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 11:52:39 -0400
Subject: Re: [PATCH 5/7] arm64: compat: vdso: Remove unused
 VDSO_HAS_32BIT_FALLBACK
References: <20190829111843.41003-1-vincenzo.frascino@arm.com>
 <20190829111843.41003-6-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1908291420060.1938@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <100cf343-1cac-84d9-3a4f-5de801fc4482@arm.com>
Date: Thu, 29 Aug 2019 16:52:34 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908291420060.1938@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com, salyzyn@android.com, 0x7f454c46@gmail.com, luto@kernel.org
Message-ID: <20190829155234.W10fzR1Bh2WiaM7f9Apos49QW1SENJ58qYzC4HPATxs@z>

On 29/08/2019 13:21, Thomas Gleixner wrote:
> On Thu, 29 Aug 2019, Vincenzo Frascino wrote:
> 
>> As a consequence of Commit 623fa33f7bd6 ("lib:vdso: Remove
> 
> -ENOSUCH commit ....
> 
> Just say:
> 
> VDSO_HAS_32BIT_FALLBACK has been removed from the core ....
>

Thanks Thomas, I will fix it in v2.

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo
