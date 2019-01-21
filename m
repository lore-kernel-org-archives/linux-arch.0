Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728234AbfAUMPg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Jan 2019 07:15:36 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0LC5vlF052591
        for <linux-arch@vger.kernel.org>; Mon, 21 Jan 2019 07:15:35 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q5ctdb65e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 21 Jan 2019 07:15:35 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 21 Jan 2019 12:15:32 -0000
Date: Mon, 21 Jan 2019 13:15:19 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 28/29] y2038: rename old time and utime syscalls
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-29-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20190118161835.2259170-29-arnd@arndb.de>
Message-ID: <20190121121519.GE4020@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com, deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jcmvbkbc@gmail.com, akpm@linux-foundation.org, deepa.kernel@gmail.com, ebiederm@xmission.com, firoz.khan@linaro.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <20190121121519.ClIVM17S1_2oApbbBYpO7VzUDdDJ8QLNyOSlPag2Ugs@z>

On Fri, Jan 18, 2019 at 05:18:34PM +0100, Arnd Bergmann wrote:
> The time, stime, utime, utimes, and futimesat system calls are only
> used on older architectures, and we do not provide y2038 safe variants
> of them, as they are replaced by clock_gettime64, clock_settime64,
> and utimensat_time64.
> 
> However, for consistency it seems better to have the 32-bit architectures
> that still use them call the "time32" entry points (leaving the
> traditional handlers for the 64-bit architectures), like we do for system
> calls that now require two versions.
> 
> Note: We used to always define __ARCH_WANT_SYS_TIME and
> __ARCH_WANT_SYS_UTIME and only set __ARCH_WANT_COMPAT_SYS_TIME and
> __ARCH_WANT_SYS_UTIME32 for compat mode on 64-bit kernels. Now this is
> reversed: only 64-bit architectures set __ARCH_WANT_SYS_TIME/UTIME, while
> we need __ARCH_WANT_SYS_TIME32/UTIME32 for 32-bit architectures and compat
> mode. The resulting asm/unistd.h changes look a bit counterintuitive.
> 
> This is only a cleanup patch and it should not change any behavior.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
...
>  arch/s390/include/asm/unistd.h              |  2 +-

For the s390 bits:
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
