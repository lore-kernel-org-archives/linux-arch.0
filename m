Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfDAOoA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Apr 2019 10:44:00 -0400
Date: Mon, 1 Apr 2019 15:43:56 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/4] arm64: compat: Refactor aarch32_alloc_vdso_pages()
Message-ID: <20190401144355.GI14874@arrakis.emea.arm.com>
References: <20190401112025.40807-1-vincenzo.frascino@arm.com>
 <20190401112025.40807-4-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401112025.40807-4-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20190401144356.5aDxi1Z6CJe9d0ZscZLBwCYhv2aff5l0zAx8IP7dFyM@z>

On Mon, Apr 01, 2019 at 12:20:24PM +0100, Vincenzo Frascino wrote:
> +static int __init aarch32_alloc_vdso_pages(void)
> +{
> +	return aarch32_alloc_kuser_vdso_page() &
> +	       aarch32_alloc_sigreturn_vdso_page();
>  }
>  arch_initcall(aarch32_alloc_vdso_pages);

It probably doesn't matter much but I'd rather not bit-and two error
codes. Just return the non-zero one or pick the first (your choice) if
both are wrong.

(normally, if you want a non-zero random value if any of them failed,
you'd use bit-or)

-- 
Catalin
