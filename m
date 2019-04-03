Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725956AbfDCJiy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Apr 2019 05:38:54 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x339ULv3054903
        for <linux-arch@vger.kernel.org>; Wed, 3 Apr 2019 05:38:53 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rmrdqx3r9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 03 Apr 2019 05:38:53 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 3 Apr 2019 10:38:50 +0100
Date: Wed, 3 Apr 2019 11:38:44 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 3/5] s390: Fix vDSO clock_getres()
In-Reply-To: <20190401115152.32751-4-vincenzo.frascino@arm.com>
References: <20190401115152.32751-1-vincenzo.frascino@arm.com>
        <20190401115152.32751-4-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID: <20190403113844.334a32d9@mschwideX1>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190403093844.Sir10UfrCO98N5fwBF03YWEioaSoe5cmPaRx3l25FTE@z>

On Mon,  1 Apr 2019 12:51:50 +0100
Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:

> clock_getres in the vDSO library has to preserve the same behaviour
> of posix_get_hrtimer_res().
> 
> In particular, posix_get_hrtimer_res() does:
>     sec = 0;
>     ns = hrtimer_resolution;
> and hrtimer_resolution depends on the enablement of the high
> resolution timers that can happen either at compile or at run time.
> 
> Fix the s390 vdso implementation of clock_getres keeping a copy of
> hrtimer_resolution in vdso data and using that directly.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/s390/include/asm/vdso.h           |  1 +
>  arch/s390/kernel/asm-offsets.c         |  2 +-
>  arch/s390/kernel/time.c                |  1 +
>  arch/s390/kernel/vdso32/clock_getres.S | 17 ++++++++++++-----
>  arch/s390/kernel/vdso64/clock_getres.S | 15 ++++++++++-----
>  5 files changed, 25 insertions(+), 11 deletions(-)

I tried this patch and in principle this works. In that regard
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

But I wonder if the loop to check the update counter is really
necessary. The hrtimer_resolution value can only changes once with
the first call to hrtimer_switch_to_hres(). With the TOD clock
as the only clock available on s390 we always have the ability
to do hrtimer. It then all depends on the highres=[on|off] kernel
parameter what value we get with clock_getres().

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
