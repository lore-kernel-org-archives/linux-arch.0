Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:59122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbfH3MNX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Aug 2019 08:13:23 -0400
Date: Fri, 30 Aug 2019 13:13:18 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/7] arm64: compat: vdso: Expose BUILD_VDSO32
Message-ID: <20190830121318.GH36992@arrakis.emea.arm.com>
References: <20190829111843.41003-1-vincenzo.frascino@arm.com>
 <20190829111843.41003-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829111843.41003-2-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, will@kernel.org, paul.burton@mips.com, tglx@linutronix.de, salyzyn@android.com, 0x7f454c46@gmail.com, luto@kernel.org
Message-ID: <20190830121318.REwV5PxDnpBU3ATzHb1Y1MruqKa98y8lluu9pQ2GY6I@z>

On Thu, Aug 29, 2019 at 12:18:37PM +0100, Vincenzo Frascino wrote:
> clock_gettime32 and clock_getres_time32 should be compiled only with the
> 32 bit vdso library.
> 
> Expose BUILD_VDSO32 when arm64 compat is compiled, to provide an
> indication to the generic library to include these symbols.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
