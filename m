From: Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH v2 10/10] gcov: Remove old GCC 3.4 support
Date: Tue, 28 Jan 2020 15:56:06 +0100
Message-ID: <28e3e35c-1a26-5f87-064e-39f8a1fc9105@linux.ibm.com>
References: <20200123153341.19947-1-will@kernel.org>
 <20200123153341.19947-11-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726634AbgA1O4Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Jan 2020 09:56:16 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SEoxJY070370
        for <linux-arch@vger.kernel.org>; Tue, 28 Jan 2020 09:56:15 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrj72kug5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 28 Jan 2020 09:56:14 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Tue, 28 Jan 2020 14:56:12 -0000
In-Reply-To: <20200123153341.19947-11-will@kernel.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kernel-team@android.com, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

On 23.01.2020 16:33, Will Deacon wrote:
> The kernel requires at least GCC 4.8 in order to build, and so there is
> no need to cater for the pre-4.7 gcov format.
> 
> Remove the obsolete code.
> 
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/gcov/Kconfig   |  24 --
>  kernel/gcov/Makefile  |   3 +-
>  kernel/gcov/gcc_3_4.c | 573 ------------------------------------------
>  3 files changed, 1 insertion(+), 599 deletions(-)
>  delete mode 100644 kernel/gcov/gcc_3_4.c

Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Compiles, boots, produces coverage output on a s390 system with a
recent-ish GCC version, so that change is fine by me.

There's a final reference to the gcc_3_4.c file in the gcc_4_7.c header
comment, but its probably not worth the extra effort to adjust that as well.

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
