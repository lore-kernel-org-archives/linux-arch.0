From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] refcount: Create unchecked atomic_t implementation
Date: Wed, 21 Jun 2017 11:57:15 +0200
Message-ID: <20170621095715.zf57frodvjmhdttg@gmail.com>
References: <20170608025831.GA43608@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33866 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbdFUJ5U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2017 05:57:20 -0400
Content-Disposition: inline
In-Reply-To: <20170608025831.GA43608@beast>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Peter Zijlstra <peterz@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, arozansk@redhat.com, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartner>


* Kees Cook <keescook@chromium.org> wrote:

> Many subsystems will not use refcount_t unless there is a way to build the
> kernel so that there is no regression in speed compared to atomic_t. This
> adds CONFIG_REFCOUNT_FULL to enable the full refcount_t implementation
> which has the validation but is slightly slower. When not enabled,
> refcount_t uses the basic unchecked atomic_t routines, which results in
> no code changes compared to just using atomic_t directly.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This is v2 of this patch, which I've split from the arch-specific
> alternative implementation for x86. Getting this patch in will unblock
> atomic_t -> refcount_t conversion, and the x86 alternative implementation
> can be developed in parallel. Changes from v1: use better atomic ops,
> thanks to Elena and Peter.
> ---
>  arch/Kconfig             |  9 +++++++++
>  include/linux/refcount.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  lib/refcount.c           |  3 +++
>  3 files changed, 56 insertions(+)

Looks almost good - sans a few stylistic nits:

> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 6c00e5b00f8b..fba3bf186728 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -867,4 +867,13 @@ config STRICT_MODULE_RWX
>  config ARCH_WANT_RELAX_ORDER
>  	bool
>  
> +config REFCOUNT_FULL
> +	bool "Perform full reference count validation at the expense of speed"
> +	help
> +	  Enabling this switches the refcounting infrastructure from a fast
> +	  unchecked atomic_t implementation to a fully state checked
> +	  implementation, which can be slower but provides protections
> +	  against various use-after-free conditions that can be used in
> +	  security flaw exploits.
> +
>  source "kernel/gcov/Kconfig"
> diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> index b34aa649d204..099c32bd07b2 100644
> --- a/include/linux/refcount.h
> +++ b/include/linux/refcount.h
> @@ -41,6 +41,7 @@ static inline unsigned int refcount_read(const refcount_t *r)
>  	return atomic_read(&r->refs);
>  }
>  
> +#ifdef CONFIG_REFCOUNT_FULL
>  extern __must_check bool refcount_add_not_zero(unsigned int i, refcount_t *r);
>  extern void refcount_add(unsigned int i, refcount_t *r);
>  
> @@ -52,6 +53,49 @@ extern void refcount_sub(unsigned int i, refcount_t *r);
>  
>  extern __must_check bool refcount_dec_and_test(refcount_t *r);
>  extern void refcount_dec(refcount_t *r);
> +#else
> +static inline __must_check bool refcount_add_not_zero(unsigned int i,
> +						      refcount_t *r)

Please keep it on a single, slighly over-long line instead of the ugly line break 
in the middle of the list of parameters ...

There's other such uglies in the patch as well.

Thanks,

	Ingo
