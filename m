From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 00/12] Rework READ_ONCE() to improve codegen
Date: Thu, 16 Apr 2020 14:30:36 +0200
Message-ID: <809e006e-6641-c252-53a1-cc4479d2ca89@de.ibm.com>
References: <20200415165218.20251-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2635373AbgDPMap (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Apr 2020 08:30:45 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GC4Hhm018167
        for <linux-arch@vger.kernel.org>; Thu, 16 Apr 2020 08:30:44 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30efpqntwc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 16 Apr 2020 08:30:43 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 16 Apr 2020 13:30:22 +0100
In-Reply-To: <20200415165218.20251-1-will@kernel.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kernel-team@android.com, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>


On 15.04.20 18:52, Will Deacon wrote:
> Hi everyone,
> 
> This is version three of the patches I previously posted for improving
> the code generation of READ_ONCE() and moving the minimum GCC version
> to 4.8:
> 
> RFC: https://lore.kernel.org/lkml/20200110165636.28035-1-will@kernel.org
> v2:  https://lore.kernel.org/lkml/20200123153341.19947-1-will@kernel.org
> 
> Although v2 was queued up by Peter in -tip, it was found to break the
> build for m68k and sparc32. We fixed m68k during the merge window and
> I've since posted patches to fix sparc32 here:
> 
>   https://lore.kernel.org/lkml/20200414214011.2699-1-will@kernel.org
> 
> This series is a refresh on top of 5.7-rc1, the main changes being:
> 
>   * Fix another issue where 'const' is assigned to non-const via
>     WRITE_ONCE(), this time in the tls code
> 
>   * Fix READ_ONCE_NOCHECK() abuse in arm64 checksum code
> 
>   * Added Reviewed-bys and Acks from v2
> 
> Hopefully this can be considered for 5.8, along with the sparc32 changes.
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
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> 

I gave this series a try and s390 seems to compile fine and it also seems to
properly compile the the ipte_unlock_siif function in arch/s390/kvm/gaccess.c
This function was miscompiled with gcc4.6 and the trigger for replacing
ACCESS_ONCE with READ_ONCE
