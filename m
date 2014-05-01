From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH V4 3/7] arm: mm: Enable HAVE_RCU_TABLE_FREE logic
Date: Thu, 1 May 2014 12:11:21 +0100
Message-ID: <20140501111120.GF22316@arm.com>
References: <1396018892-6773-1-git-send-email-steve.capper@linaro.org>
 <1396018892-6773-4-git-send-email-steve.capper@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:12713 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755244AbaEALME (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 May 2014 07:12:04 -0400
Content-Disposition: inline
In-Reply-To: <1396018892-6773-4-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

On Fri, Mar 28, 2014 at 03:01:28PM +0000, Steve Capper wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1594945..7d5340d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -58,6 +58,7 @@ config ARM
>  	select HAVE_PERF_EVENTS
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
> +	select HAVE_RCU_TABLE_FREE if SMP

You select this if (SMP && CPU_V7). On ARMv6 SMP systems we use IPI for
TLB maintenance already.

-- 
Catalin
