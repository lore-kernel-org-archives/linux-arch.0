From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v5 0/6] arch/x86: kprobes: Remove MODULES dependency
Date: Fri, 24 Jul 2020 13:26:41 +0300
Message-ID: <20200724102641.GC2831654@kernel.org>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbgGXK0v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jul 2020 06:26:51 -0400
Content-Disposition: inline
In-Reply-To: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Jessica Yu <jeyu@kernel.org>, linux-arch@vger.kernel.org

(cc people whi particpaged in v2 disuccsion)

On Fri, Jul 24, 2020 at 08:05:47AM +0300, Jarkko Sakkinen wrote:
> Remove MODULES dependency by migrating from module_alloc() to the new
> text_alloc() API. Essentially these changes provide preliminaries for
> allowing to compile a static kernel with a proper tracing support.
> 
> The same API can be used later on in other sites that allocate space for
> trampolines, and trivially scaled to other arch's. An arch can inform
> with CONFIG_ARCH_HAS_TEXT_ALLOC that it's providing implementation for
> text_alloc().
> 
> Cc: linux-mm@kvack.org
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> 
> v4:
> * Squash lock_modules() patches into one.
> * Remove fallback versions of text_alloc() and text_free(). Instead, use
>   ARCH_HAS_TEXT_ALLOC at site when required.
> * Use lockdep_assert_irqs_enabled() in text_free() instead of
>   WARN_ON(in_interrupt()).
> 
> v3:
> * Make text_alloc() API disjoint.
> * Remove all the possible extra clutter not absolutely required and
>   split into more logical pieces.
> 
> Jarkko Sakkinen (6):
>   kprobes: Remove dependency to the module_mutex
>   vmalloc: Add text_alloc() and text_free()
>   arch/x86: Implement text_alloc() and text_free()
>   arch/x86: kprobes: Use text_alloc() and text_free()
>   kprobes: Use text_alloc() and text_free()
>   kprobes: Remove CONFIG_MODULES dependency
> 
>  arch/Kconfig                   |  2 +-
>  arch/x86/Kconfig               |  3 ++
>  arch/x86/kernel/Makefile       |  1 +
>  arch/x86/kernel/kprobes/core.c |  4 +--
>  arch/x86/kernel/text_alloc.c   | 41 +++++++++++++++++++++++
>  include/linux/module.h         | 32 ++++++++++++++----
>  include/linux/vmalloc.h        | 17 ++++++++++
>  kernel/kprobes.c               | 61 +++++++++++++++++++++++-----------
>  kernel/trace/trace_kprobe.c    | 20 ++++++++---
>  9 files changed, 147 insertions(+), 34 deletions(-)
>  create mode 100644 arch/x86/kernel/text_alloc.c
> 
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
