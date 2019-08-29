From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 5/7] arm64: compat: vdso: Remove unused
 VDSO_HAS_32BIT_FALLBACK
Date: Thu, 29 Aug 2019 16:52:34 +0100
Message-ID: <100cf343-1cac-84d9-3a4f-5de801fc4482@arm.com>
References: <20190829111843.41003-1-vincenzo.frascino@arm.com>
 <20190829111843.41003-6-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1908291420060.1938@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1908291420060.1938@nanos.tec.linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com, salyzyn@android.com, 0x7f454c46@gmail.com, luto@kernel.org
List-Id: linux-arch.vger.kernel.org

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
