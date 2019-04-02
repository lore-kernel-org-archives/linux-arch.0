From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] arm64: compat: Reduce address limit
Date: Tue, 2 Apr 2019 16:23:05 +0100
Message-ID: <20190402152305.b43qnvavrhnnavgi@mbp>
References: <20190401113014.20866-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190401113014.20866-1-vincenzo.frascino@arm.com>
Sender: stable-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Jann Horn <jannh@google.com>, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
