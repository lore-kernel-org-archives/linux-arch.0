Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:45353 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbeGZNCr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Jul 2018 09:02:47 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture primitives
In-Reply-To: <75195a7d-3d0f-4e55-92cc-4ad772683c75@oracle.com>
References: <20180705110716.3919-1-alex@ghiti.fr> <20180709141621.GD22297@dhcp22.suse.cz> <2173685f-7f85-7acb-4685-2383210c5fa2@ghiti.fr> <75195a7d-3d0f-4e55-92cc-4ad772683c75@oracle.com>
Date: Thu, 26 Jul 2018 21:46:00 +1000
Message-ID: <87tvomgqyv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>, Alex Ghiti <alex@ghiti.fr>, Michal Hocko <mhocko@kernel.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Message-ID: <20180726114600.gLL-Lz0YCc1wn609kBPtHJUS3_M_HeCKkP8DHPmz0PY@z>

Mike Kravetz <mike.kravetz@oracle.com> writes:

> On 07/20/2018 11:37 AM, Alex Ghiti wrote:
>> Does anyone have any suggestion about those patches ?
>
> I only took a quick look.  From the hugetlb perspective, I like the
> idea of moving routines to a common file.  If any of the arch owners
> (or anyone else) agree, I can do a review of the series.

The conversions look pretty good to me. If you want to give it a review
then from my point of view it could go in -mm to shake out any bugs.

cheers
