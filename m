From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC PATCH 0/8] Rework READ_ONCE() to improve codegen
Date: Mon, 13 Jan 2020 13:40:16 +0100
Message-ID: <c076476f-96c2-8a5a-117c-e5f709a9ebaf@de.ibm.com>
References: <20200110165636.28035-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbgAMMk0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jan 2020 07:40:26 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DCawQB081977
        for <linux-arch@vger.kernel.org>; Mon, 13 Jan 2020 07:40:25 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfvsyb12k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 13 Jan 2020 07:40:25 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 13 Jan 2020 12:40:22 -0000
In-Reply-To: <20200110165636.28035-1-will@kernel.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kernel-team@android.com, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>



On 10.01.20 17:56, Will Deacon wrote:
> Hi all,
> 
> This is a follow-up RFC to the discussions we had on the mailing list at
> the end of last year:
> 
> https://lore.kernel.org/lkml/875zimp0ay.fsf@mpe.ellerman.id.au
> 
> Unfortunately, we didn't get a "silver bullet" solution out of that
> long thread, but I've tried to piece together some of the bits and
> pieces we discussed and I've ended up with this series, which does at
> least solve the pressing problem with the bitops for arm64.
> 
> The rough summary of the series is:
> 
>   * Drop the GCC 4.8 workarounds, so that READ_ONCE() is a
>     straightforward dereference of a cast-to-volatile pointer.
> 
>   * Require that the access is either 1, 2, 4 or 8 bytes in size
>     (even 32-bit architectures tend to use 8-byte accesses here).
> 
>   * Introduce __READ_ONCE() for tearing operations with no size
>     restriction.
> 
>   * Drop pointer qualifiers from scalar types, so that volatile scalars
>     don't generate horrible stack-spilling mess. This is pretty ugly,
>     but it's also mechanical and wrapped up in a macro.
> 
>   * Convert acquire/release accessors to perform the same qualifier
>     stripping.
> 
> I gave up trying to prevent READ_ONCE() on aggregates because it is
> pervasive, particularly within the mm/ layer on things like pmd_t.
> Thankfully, these don't tend to be volatile.
> 
> I have more patches in this area because I'm trying to move all the
> read_barrier_depends() magic into arch/alpha/, but I'm holding off until
> we agree on this part first.
> 
> Cheers,
> 
> Will
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Looks sane on s390. I also checked that the problematic sequence in
arch/s390/kvm/gaccess.c is not miscompiled (the binary code for the
ipte_lock function is almost the same, just different addresses due
to a different start address.)

The kernel seems to get slighly larger though.
Mostly due to different inlining decisions it seems.
Total: Before=14133361, After=14135643, chg +0.02%
