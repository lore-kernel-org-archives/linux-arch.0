Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
Date: Wed, 29 Apr 2020 11:26:51 +0100
From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v3 20/23] fs: Allow copy_mount_options() to access
 user-space in a single pass
Message-ID: <20200429102650.GC30377@arm.com>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-21-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421142603.3894-21-catalin.marinas@arm.com>
Sender: owner-linux-mm@kvack.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Richard Earnshaw <Richard.Earnshaw@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429102651.sin2ygDpA57Cm2RkMB_Fjq2Y5aYisUlXVrcEIaSFAWA@z>

On Tue, Apr 21, 2020 at 03:26:00PM +0100, Catalin Marinas wrote:
> The copy_mount_options() function takes a user pointer argument but not
> a size. It tries to read up to a PAGE_SIZE. However, copy_from_user() is
> not guaranteed to return all the accessible bytes if, for example, the
> access crosses a page boundary and gets a fault on the second page. To
> work around this, the current copy_mount_options() implementations
> performs to copy_from_user() passes, first to the end of the current

implementation performs two

> page and the second to what's left in the subsequent page.
> 
> Some architectures like arm64 can guarantee an exact copy_from_user()
> depending on the size (since the arch function performs some alignment
> on the source register). Introduce an arch_has_exact_copy_from_user()
> function and allow copy_mount_options() to perform the user access in a
> single pass.
> 
> While this function is not on a critical path, the single-pass behaviour
> is required for arm64 MTE (memory tagging) support where a uaccess can
> trigger intra-page faults (tag not matching). With the current
> implementation, if this happens during the first page, the function will
> return -EFAULT.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Will Deacon <will@kernel.org>
> ---
> 
> Notes:
>     New in v3.
> 
>  arch/arm64/include/asm/uaccess.h | 11 +++++++++++
>  fs/namespace.c                   |  7 +++++--
>  include/linux/uaccess.h          |  8 ++++++++
>  3 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 32fc8061aa76..566da441eba2 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -416,6 +416,17 @@ extern unsigned long __must_check __arch_copy_in_user(void __user *to, const voi
>  #define INLINE_COPY_TO_USER
>  #define INLINE_COPY_FROM_USER
>  
> +static inline bool arch_has_exact_copy_from_user(unsigned long n)
> +{
> +	/*
> +	 * copy_from_user() aligns the source pointer if the size is greater
> +	 * than 15. Since all the loads are naturally aligned, they can only
> +	 * fail on the first byte.
> +	 */
> +	return n > 15;
> +}
> +#define arch_has_exact_copy_from_user

Did you mean:

#define arch_has_exact_copy_from_user arch_has_exact_copy_from_user

Mind you, if this expands to 1 I'd have expected copy_mount_options()
not to compile, so I may be missing something.

[...]

> diff --git a/fs/namespace.c b/fs/namespace.c
> index a28e4db075ed..8febc50dfc5d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3025,13 +3025,16 @@ void *copy_mount_options(const void __user * data)

[ Is this applying a band-aid to duct tape?

The fs presumably knows ahead of time whether it's expecting a string or
a fixed-size blob for data, so I'd hope we could just DTRT rather than
playing SEGV roulette here.

This might require more refactoring than makes sense for this series
though. ]

>  	if (!copy)
>  		return ERR_PTR(-ENOMEM);
>  
> -	size = PAGE_SIZE - offset_in_page(data);
> +	size = PAGE_SIZE;
> +	if (!arch_has_exact_copy_from_user(size))
> +		size -= offset_in_page(data);
>  
> -	if (copy_from_user(copy, data, size)) {
> +	if (copy_from_user(copy, data, size) == size) {
>  		kfree(copy);
>  		return ERR_PTR(-EFAULT);
>  	}
>  	if (size != PAGE_SIZE) {
> +		WARN_ON(1);
>  		if (copy_from_user(copy + size, data + size, PAGE_SIZE - size))
>  			memset(copy + size, 0, PAGE_SIZE - size);
>  	}

[...]

Cheers
---Dave
