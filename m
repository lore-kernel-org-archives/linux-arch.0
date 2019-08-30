Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:59158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfH3MNi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Aug 2019 08:13:38 -0400
Date: Fri, 30 Aug 2019 13:13:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 5/7] arm64: compat: vdso: Remove unused
 VDSO_HAS_32BIT_FALLBACK
Message-ID: <20190830121334.GI36992@arrakis.emea.arm.com>
References: <20190829111843.41003-1-vincenzo.frascino@arm.com>
 <20190829111843.41003-6-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829111843.41003-6-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, will@kernel.org, paul.burton@mips.com, tglx@linutronix.de, salyzyn@android.com, 0x7f454c46@gmail.com, luto@kernel.org
Message-ID: <20190830121334.6nkaLvvenm7byZ2xQL7SsefJkozaPOB7ETkbfOulU4Y@z>

On Thu, Aug 29, 2019 at 12:18:41PM +0100, Vincenzo Frascino wrote:
> As a consequence of Commit 623fa33f7bd6 ("lib:vdso: Remove
> VDSO_HAS_32BIT_FALLBACK") VDSO_HAS_32BIT_FALLBACK define is not
> required anymore hence can be removed.
> 
> Remove unused VDSO_HAS_32BIT_FALLBACK from arm64 compat vdso.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
