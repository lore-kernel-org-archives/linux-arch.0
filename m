Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933799AbeGDH7c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jul 2018 03:59:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w647wi2J020941
        for <linux-arch@vger.kernel.org>; Wed, 4 Jul 2018 03:59:31 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k0qae712q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 04 Jul 2018 03:59:31 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 4 Jul 2018 08:59:29 +0100
Date: Wed, 4 Jul 2018 09:59:23 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 0/8] add support for relative references in jump tables
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
Message-ID: <20180704075923.GF3701@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jessica Yu <jeyu@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20180704075923.V0GqA_wBd0gyLd_0z56HAmbJGnio80jRHy1qm0Vq7rE@z>

On Mon, Jul 02, 2018 at 08:11:37PM +0200, Ard Biesheuvel wrote:
> This series implements support for emitting the data structures associated
> with jump tables as 32-bit relative references instead of absolute
> references, which take up more space on builds that target 64-bit
> architectures, or implement self relocation [or both].
> 
> This series enables it for arm64 and x86, although other architectures
> might benefit as well.

Hello Ard,

feel free to add the patch below which adds support for s390 to your series.

> Changes since v1:
> - change the relative reference to the static key to a 64-bit wide one on 64
>   bit architectures; this is necessary on arm64, which allows modules to
>   reside anywhere within a 4 GB window covering the core kernel text, which
>   means a 32-bit signed quantity with its +/- 2 GB range is insufficient.
>   Note that x86_64 changes are in preparation that widen the relocation
>   range as well (using the PIE linker), so I assumed that the same change
>   is appropriate for x86 as well.

FWIW, kernel modules on s390 are since ages more than 2GB away from the
core kernel text. So this is required for s390 as well.
