Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732373AbeGaVsu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Jul 2018 17:48:50 -0400
Date: Tue, 31 Jul 2018 16:06:40 -0400
From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH v5 00/11] hugetlb: Factorize hugetlb architecture
 primitives
Message-ID: <20180731160640.11306628@doriath>
In-Reply-To: <20180731060155.16915-1-alex@ghiti.fr>
References: <20180731060155.16915-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-mm@kvack.org, mike.kravetz@oracle.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180731200640.Bay9bktfDtPf-4KoZO2u20588oCScBsS1Ml4LkUXtK0@z>

On Tue, 31 Jul 2018 06:01:44 +0000
Alexandre Ghiti <alex@ghiti.fr> wrote:

> [CC linux-mm for inclusion in -mm tree] 
> 
> In order to reduce copy/paste of functions across architectures and then
> make riscv hugetlb port (and future ports) simpler and smaller, this
> patchset intends to factorize the numerous hugetlb primitives that are
> defined across all the architectures.

[...]

>  15 files changed, 139 insertions(+), 382 deletions(-)

I imagine you're mostly interested in non-x86 review at this point, but
as this series is looking amazing:

Reviewed-by: Luiz Capitulino <lcapitulino@redhat.com>
