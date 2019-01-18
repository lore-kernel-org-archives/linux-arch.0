Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from atl4mhfb04.myregisteredsite.com ([209.17.115.120]:45028 "EHLO
        atl4mhfb04.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727823AbfARRET (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Jan 2019 12:04:19 -0500
Received: from atl4mhob21.registeredsite.com (atl4mhob21.registeredsite.com [209.17.115.115])
        by atl4mhfb04.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id x0IGvTBb016540
        for <linux-arch@vger.kernel.org>; Fri, 18 Jan 2019 11:57:29 -0500
Received: from mailpod.hostingplatform.com (atl4qobmail01pod2.registeredsite.com [10.30.77.35])
        by atl4mhob21.registeredsite.com (8.14.4/8.14.4) with ESMTP id x0IGvRh7039332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-arch@vger.kernel.org>; Fri, 18 Jan 2019 11:57:27 -0500
Subject: Re: [PATCH v2 00/29] y2038: add time64 syscalls
References: <20190118161835.2259170-1-arnd@arndb.de>
From: Dennis Clarke <dclarke@blastwave.org>
Message-ID: <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
Date: Fri, 18 Jan 2019 11:57:24 -0500
MIME-Version: 1.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com, deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org, davem@davemloft.net, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jcmvbkbc@gmail.com, akpm@linux-foundation.org, deepa.kernel@gmail.com, ebiederm@xmission.com, firoz.khan@linaro.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-m68k@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <20190118165724.dYxyR-vWAt_JitRbDtHubfX7_fRSm3oCKJT4AZJXZAI@z>

On 1/18/19 11:18 AM, Arnd Bergmann wrote:
> This is a minor update of the patches I posted last week, I
> would like to add this into linux-next now, but would still do
> changes if there are concerns about the contents. The first
> version did not see a lot of replies, which could mean that
> either everyone is happy with it, or that it was largely ignored.
> 
> See also the article at https://lwn.net/Articles/776435/.

I would be happy to read "Approaching the kernel year-2038 end game"
however it is behind a pay wall.  Perhaps it may be best to just
host interesting articles about open source idea elsewhere.

Dennis Clarke
