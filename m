Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:53575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729510AbeGZOS7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Jul 2018 10:18:59 -0400
Date: Thu, 26 Jul 2018 14:59:40 +0200
From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
Message-ID: <20180726125940.GA15033@ls3530>
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180709141621.GD22297@dhcp22.suse.cz>
 <2173685f-7f85-7acb-4685-2383210c5fa2@ghiti.fr>
 <87d0vehx16.fsf@concordia.ellerman.id.au>
 <67aba0f0-c0d4-b06f-5fbc-f4d113ce5033@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67aba0f0-c0d4-b06f-5fbc-f4d113ce5033@ghiti.fr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Ghiti <alex@ghiti.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <20180726125940.HwUecYy59zPQbnH5rF37yKmPCaXBzPiyT0ZfjXPkL-U@z>

* Alex Ghiti <alex@ghiti.fr>:
> This is the result of the build for all arches tackled in this series
> rebased on 4.18-rc6:
> ...
> parisc:
>         generic-64bit_defconfig: with huge page does not link
>         generic-64bit_defconfig: without huge page does not link
>         BUT not because of this series, any feedback welcome.
Strange, but I will check that later....

Anyway, I applied your v4-patch to my parisc64 tree, built the kernel,
started it and ran some hugetlb LTP testcases sucessfully.
So, please add:

Tested-by: Helge Deller <deller@gmx.de> # parisc

Helge
