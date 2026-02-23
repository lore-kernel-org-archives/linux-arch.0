Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DE134EF05;
	Mon, 23 Feb 2026 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771851406; cv=none; b=BpDYk8mm4U2dPwHcP/ka5gp5kUrWxq0A7I6sxtLPJPKyusiheEBzWd06QjDoCisj5A5I7NDFPlIz7jnBpIIE0uCAeI6ZJGl4gz4nOwFtoEIk729D4eBi8tSMNm25NG7xKK/N1VN+Wvx8upjTzjPhL7QOkEEKwMLvKzRtKnhN2oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771851406; c=relaxed/simple;
	bh=K6MxMAQ6wYI5Ry7oWZ+4SSWCN+WB9h8X6V37mTrwf8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKQbk3USvgaYuzabRTukMMPGLdCwhbwa/CYhq1Nfw0k7jMutDA1iknAVX00H4Uf9D0Mpz7qtGPgPE9WX1uXrICsH7OAwZV4Ede+25ppFd0wkoDYLigUtNK6QfaZEht/QFyW7jDW+VQ6OebCwyzEwXmM3Np/a4an8hbH7M7QmKtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D8C6339;
	Mon, 23 Feb 2026 04:56:36 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C2103F62B;
	Mon, 23 Feb 2026 04:56:40 -0800 (PST)
Date: Mon, 23 Feb 2026 12:56:27 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Guo Ren <guoren@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: use runtime constant to optimize
 handle_arch_irq access
Message-ID: <aZxOe_1XGX_gGOoK@J2N7QTR9R3>
References: <20260220090922.1506-1-jszhang@kernel.org>
 <20260220090922.1506-4-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220090922.1506-4-jszhang@kernel.org>

On Fri, Feb 20, 2026 at 05:09:22PM +0800, Jisheng Zhang wrote:
> Currently, on arm64 platforms, the handle_arch_irq is a pointer which
> is set during booting, and every irq processing needs to access it,
> so it sits in hot code path. We can use the runtime constant mechanism
> which was introduced by Linus to speed up its accessing.
> 
> Tested on Quad CA55 platform, the perf sched benchmark is improved
> by ~6.5%

That is a surprisingly large impact. :/

Does this meaningfully actually affect any real workload?

> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/arm64/kernel/entry-common.c | 4 +++-
>  arch/arm64/kernel/irq.c          | 9 ++++++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 3625797e9ee8..46a4c012e15f 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -25,6 +25,7 @@
>  #include <asm/kprobes.h>
>  #include <asm/mmu.h>
>  #include <asm/processor.h>
> +#include <asm/runtime-const.h>
>  #include <asm/sdei.h>
>  #include <asm/stacktrace.h>
>  #include <asm/sysreg.h>
> @@ -139,7 +140,8 @@ static void do_interrupt_handler(struct pt_regs *regs,
>  	set_irq_regs(old_regs);
>  }
>  
> -extern void (*handle_arch_irq)(struct pt_regs *);
> +extern void (*_handle_arch_irq)(struct pt_regs *);
> +#define handle_arch_irq runtime_const_ptr(_handle_arch_irq)
>  extern void (*handle_arch_fiq)(struct pt_regs *);

We should treat handle_arch_irq and handle_arch_fiq the same way. Either
both get this, or neither do.

>  static void noinstr __panic_unhandled(struct pt_regs *regs, const char *vector,
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index 15dedb385b9e..30629c183606 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -23,6 +23,7 @@
>  #include <asm/daifflags.h>
>  #include <asm/exception.h>
>  #include <asm/numa.h>
> +#include <asm/runtime-const.h>
>  #include <asm/softirq_stack.h>
>  #include <asm/stacktrace.h>
>  #include <asm/vmap_stack.h>
> @@ -84,15 +85,17 @@ static void default_handle_fiq(struct pt_regs *regs)
>  	panic("FIQ taken without a root FIQ handler\n");
>  }
>  
> -void (*handle_arch_irq)(struct pt_regs *) __ro_after_init = default_handle_irq;
> +void (*_handle_arch_irq)(struct pt_regs *) __ro_after_init = default_handle_irq;
> +#define handle_arch_irq runtime_const_ptr(_handle_arch_irq)

This breaks the default case, since handle_arch_irq is initialized to a
bunch of garbage hex bytes (0x0123456789abcdef).

That means that if set_handle_irq() isn't called, an IRQ will result in
a call to that bogus address rather than default_handle_irq(), which'll
be more difficult to debug.

Mark.

>  void (*handle_arch_fiq)(struct pt_regs *) __ro_after_init = default_handle_fiq;
>  
>  int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
>  {
> -	if (handle_arch_irq != default_handle_irq)
> +	if (_handle_arch_irq != default_handle_irq)
>  		return -EBUSY;
>  
> -	handle_arch_irq = handle_irq;
> +	_handle_arch_irq = handle_irq;
> +	runtime_const_init(ptr, _handle_arch_irq);
>  	pr_info("Root IRQ handler: %ps\n", handle_irq);
>  	return 0;
>  }
> -- 
> 2.51.0
> 
> 
