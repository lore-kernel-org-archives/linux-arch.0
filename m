Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56910 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfCHLVV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Mar 2019 06:21:21 -0500
Subject: Re: [PATCH 0/4] vdso fixups
References: <20190307160532.3328288-1-arnd@arndb.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <7fba9c5e-542e-a6d9-e267-7ce3090bce4f@arm.com>
Date: Fri, 8 Mar 2019 11:21:18 +0000
MIME-Version: 1.0
In-Reply-To: <20190307160532.3328288-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

Hi Arnd,

On 07/03/2019 16:05, Arnd Bergmann wrote:
> Hi Vincento,
> 
> Here are a couple more patches that I had to apply on top of your series
> to get the combined vdso to build cleanly in all randconfig configurations.
> 
> Unfortunately, I haven't managed to build the arm64 compat vdso at
> all here, so there may be additional patches needed for that.
> 

Thank you for this. Going forward, I will start using randconfig as well to make
sure that I catch as many issues as I can.

For what concerns arm64 compat vdso, the compilation is currently disabled by
default when the compiler is clang, because there is a problem with the include
paths that requires further investigation. I was planning to provide a separate
patchset to address the problem.



>       Arnd
> 
> Arnd Bergmann (4):
>   vdso: ARM: fix building without ARM_ARCH_TIMER
>   x86: vdso: fix compat_vdso build
>   vdso: arm: use __iter_div_u64_rem() for 64-bit division
>   arm64: vdso: turn off profiling etc
> 
>  arch/arm/include/asm/vdso/gettimeofday.h |  4 ++
>  arch/arm/kernel/vdso.c                   |  7 +--
>  arch/arm64/kernel/vdso/Makefile          |  6 ++
>  arch/x86/include/asm/mshyperv-tsc.h      | 76 ++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h          | 70 +---------------------
>  arch/x86/include/asm/pvclock.h           |  2 +-
>  arch/x86/include/asm/vdso/gettimeofday.h |  2 +-
>  arch/x86/include/asm/vgtod.h             |  2 +-
>  arch/x86/kernel/pvclock.c                |  1 +
>  include/linux/hrtimer.h                  | 15 +----
>  include/linux/hrtimer_defs.h             | 25 ++++++++
>  lib/vdso/gettimeofday.c                  |  3 +-
>  12 files changed, 121 insertions(+), 92 deletions(-)
>  create mode 100644 arch/x86/include/asm/mshyperv-tsc.h
>  create mode 100644 include/linux/hrtimer_defs.h
> 

-- 
Regards,
Vincenzo
