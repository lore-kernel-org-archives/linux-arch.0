Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752065AbdBIKA1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Feb 2017 05:00:27 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v199xSZE059062
        for <linux-arch@vger.kernel.org>; Thu, 9 Feb 2017 05:00:14 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 28gp6a0aa5-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 09 Feb 2017 05:00:14 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 9 Feb 2017 10:00:12 -0000
Date: Thu, 9 Feb 2017 10:59:56 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFC][PATCH] treewide: Move set_memory_* functions away from
 cacheflush.h
References: <1486501816-27600-1-git-send-email-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486501816-27600-1-git-send-email-labbott@redhat.com>
Message-ID: <20170209095956.GB4159@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20170209095956.5sEGppAohJdvIqFgpDjLwdlFXHsi8QNqLSlKn_lnsyo@z>

On Tue, Feb 07, 2017 at 01:10:16PM -0800, Laura Abbott wrote:
> The set_memory_* APIs came out of a desire to have a better way to
> change memory attributes. Many of these attributes were linked to cache
> functionality so the prototypes were put in cacheflush.h. These days,
> the APIs have grown and have a much wider use than just cache APIs. To
> support this growth, split off set_memory_* and friends into a separate
> header file to avoid growing cacheflush.h for APIs that have nothing to
> do with caches.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> This came out of a comment Russell made while reviewing RODATA test cases
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/480855.html
> While the final result of that series was the rodata code was refactored into
> its own header file, the set_memory_* APIs are still out of place.
> 
> This is a simple attempt at moving all the API stubs to their own file.
> Another idea I had was throwing set_memory_{x,nx,ro,rw} in an asm-generic
> file since those are commonly used for module setting across all arches.
> 
> This is an RFC to see if this is actually beneficial. The diffstat is not
> negative unfortunately due to header guards in newer files.
> I have patches to convert call sites over to set_memory.h instead of
> cacheflush.h if there is sufficient interest.
> ---
>  arch/arm/include/asm/cacheflush.h   |  21 +-------
>  arch/arm/include/asm/set_memory.h   |  32 ++++++++++++
>  arch/arm64/include/asm/cacheflush.h |   6 +--
>  arch/arm64/include/asm/set_memory.h |  26 ++++++++++
>  arch/s390/include/asm/cacheflush.h  |   6 +--
>  arch/s390/include/asm/set_memory.h  |   9 ++++
>  arch/x86/include/asm/cacheflush.h   |  96 +---------------------------------
>  arch/x86/include/asm/set_memory.h   | 100 ++++++++++++++++++++++++++++++++++++
>  8 files changed, 171 insertions(+), 125 deletions(-)
>  create mode 100644 arch/arm/include/asm/set_memory.h
>  create mode 100644 arch/arm64/include/asm/set_memory.h
>  create mode 100644 arch/s390/include/asm/set_memory.h
>  create mode 100644 arch/x86/include/asm/set_memory.h

For s390:
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

