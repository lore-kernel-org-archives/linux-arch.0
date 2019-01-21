Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728318AbfAUMAK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Jan 2019 07:00:10 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0LBvL8A083935
        for <linux-arch@vger.kernel.org>; Mon, 21 Jan 2019 07:00:09 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q5csxtnr3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 21 Jan 2019 07:00:08 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 21 Jan 2019 12:00:06 -0000
Date: Mon, 21 Jan 2019 12:59:52 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 17/29] syscalls: remove obsolete __IGNORE_ macros
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-18-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20190118161835.2259170-18-arnd@arndb.de>
Message-ID: <20190121115952.GD4020@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com, deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jcmvbkbc@gmail.com, akpm@linux-foundation.org, deepa.kernel@gmail.com, ebiederm@xmission.com, firoz.khan@linaro.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <20190121115952._vYd9vOUR1wPS6wpM0qPTiYEQSM2xmcsuxpmp9rWN4E@z>

On Fri, Jan 18, 2019 at 05:18:23PM +0100, Arnd Bergmann wrote:
> These are all for ignoring the lack of obsolete system calls,
> which have been marked the same way in scripts/checksyscall.sh,
> so these can be removed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/mips/include/asm/unistd.h   | 16 ----------------
>  arch/parisc/include/asm/unistd.h |  3 ---
>  arch/s390/include/asm/unistd.h   |  2 --
>  arch/xtensa/include/asm/unistd.h | 12 ------------
>  4 files changed, 33 deletions(-)

For the s390 bits:
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
