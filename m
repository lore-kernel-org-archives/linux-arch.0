Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfDBPXO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Apr 2019 11:23:14 -0400
Date: Tue, 2 Apr 2019 16:23:05 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] arm64: compat: Reduce address limit
Message-ID: <20190402152305.b43qnvavrhnnavgi@mbp>
References: <20190401113014.20866-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401113014.20866-1-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Jann Horn <jannh@google.com>, stable@vger.kernel.org
Message-ID: <20190402152305.WETaet88p-uxKrpJ0_pvBh04k3814I1JfbVZNrjYjJY@z>

On Mon, Apr 01, 2019 at 12:30:14PM +0100, Vincenzo Frascino wrote:
> Currently, compat tasks running on arm64 can allocate memory up to
> TASK_SIZE_32 (UL(0x100000000)).
> 
> This means that mmap() allocations, if we treat them as returning an
> array, are not compliant with the sections 6.5.8 of the C standard
> (C99) which states that: "If the expression P points to an element of
> an array object and the expression Q points to the last element of the
> same array object, the pointer expression Q+1 compares greater than P".
> 
> Redefine TASK_SIZE_32 to address the issue.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: <stable@vger.kernel.org>
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

I'll queue this patch for -rc4.

-- 
Catalin
