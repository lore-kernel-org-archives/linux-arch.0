From: Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [PATCH v6 26/26] arm64: mte: Add Memory Tagging Extension
 documentation
Date: Thu, 9 Jul 2020 10:32:54 +0100
Message-ID: <20200709093253.GI32219@arm.com>
References: <20200703153718.16973-1-catalin.marinas@arm.com>
 <20200703153718.16973-27-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr20044.outbound.protection.outlook.com ([40.107.2.44]:35201
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbgGIJdH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Jul 2020 05:33:07 -0400
Content-Disposition: inline
In-Reply-To: <20200703153718.16973-27-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>, libc-alpha@sourceware.org, nd@arm.com

The 07/03/2020 16:37, Catalin Marinas wrote:
> +    /*
> +     * To be compiled with -march=armv8.5-a+memtag
> +     */
> +    #include <errno.h>
> +    #include <stdio.h>
> +    #include <stdlib.h>
> +    #include <unistd.h>
> +    #include <sys/auxv.h>
> +    #include <sys/mman.h>
> +    #include <sys/prctl.h>

the example should now include stdint.h

> +    #define insert_random_tag(ptr) ({                       \
> +            uint64_t __val;                                 \
> +            asm("irg %0, %1" : "=r" (__val) : "r" (ptr));   \
> +            __val;                                          \
> +    })
