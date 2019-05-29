Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfE2WUW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 May 2019 18:20:22 -0400
Date: Wed, 29 May 2019 15:20:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] elf: align AT_RANDOM bytes
Message-ID: <20190529152020.c9d0ed1c6194328f751fe0f9@linux-foundation.org>
In-Reply-To: <20190529213708.GA10729@avx2>
References: <20190529213708.GA10729@avx2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>
Message-ID: <20190529222020.jZe2PEP3jqmw8noQQ2mxwRPJyz7bkalbSBg2m8u-DWI@z>

On Thu, 30 May 2019 00:37:08 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> AT_RANDOM content is always misaligned on x86_64:
> 
> 	$ LD_SHOW_AUXV=1 /bin/true | grep AT_RANDOM
> 	AT_RANDOM:       0x7fff02101019
> 
> glibc copies first few bytes for stack protector stuff, aligned
> access should be slightly faster.

I just don't understand the implications of this.  Is there
(badly-behaved) userspace out there which makes assumptions about the
current alignment?

How much faster, anyway?  How frequently is the AT_RANDOM record
accessed?

I often have questions such as these about your performance/space
tweaks :(.  Please try to address them as a matter of course when
preparing changelogs?

And let's Cc Kees, who wrote the thing.

> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -144,11 +144,15 @@ static int padzero(unsigned long elf_bss)
>  #define STACK_ALLOC(sp, len) ({ \
>  	elf_addr_t __user *old_sp = (elf_addr_t __user *)sp; sp += len; \
>  	old_sp; })
> +#define STACK_ALIGN(sp, align)	\
> +	((typeof(sp))(((unsigned long)sp + (int)align - 1) & ~((int)align - 1)))

I suspect plain old ALIGN() could be used here.

>  #else
>  #define STACK_ADD(sp, items) ((elf_addr_t __user *)(sp) - (items))
>  #define STACK_ROUND(sp, items) \
>  	(((unsigned long) (sp - items)) &~ 15UL)
>  #define STACK_ALLOC(sp, len) ({ sp -= len ; sp; })
> +#define STACK_ALIGN(sp, align)	\
> +	((typeof(sp))((unsigned long)sp & ~((int)align - 1)))

And maybe there's a helper which does this, dunno.

>  #endif
>  
>  #ifndef ELF_BASE_PLATFORM
> @@ -217,6 +221,12 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
>  			return -EFAULT;
>  	}
>  
> +	/*
> +	 * glibc copies first bytes for stack protector purposes
> +	 * which are misaligned on x86_64 because strlen("x86_64") + 1 == 7.
> +	 */
> +	p = STACK_ALIGN(p, sizeof(long));
> +
>  	/*
>  	 * Generate 16 random bytes for userspace PRNG seeding.
>  	 */
