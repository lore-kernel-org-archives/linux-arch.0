Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfKRUy6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Nov 2019 15:54:58 -0500
Date: Mon, 18 Nov 2019 12:54:57 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ELF: warn if process starts with executable stack
Message-ID: <20191118125457.778e44dfd4740d24795484c7@linux-foundation.org>
In-Reply-To: <20191118145114.GA9228@avx2>
References: <20191118145114.GA9228@avx2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, security@kernel.org
Message-ID: <20191118205457.xntj2OTs2yIfa8R5FXR1Ta-lyXXn3nkuBv03jFdOtYU@z>

On Mon, 18 Nov 2019 17:51:15 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> PT_GNU_STACK is fail open design,

Not sure what this means.  Please expand on the motivation for this
change.

> at least warn people that something
> isn't right.

People who use an executable stack get a kernel splat.  How is that
useful?

> ...
>
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -762,6 +762,13 @@ int setup_arg_pages(struct linux_binprm *bprm,
>  		goto out_unlock;
>  	BUG_ON(prev != vma);
>  
> +#ifdef CONFIG_MMU
> +	if (vm_flags & VM_EXEC) {
> +		pr_warn_once("process '%s'/%u started with executable stack\n",
> +			     current->comm, current->pid);
> +	}
> +#endif
>
>  	/* Move stack pages down in memory. */
>  	if (stack_shift) {
>  		ret = shift_arg_pages(vma, stack_shift);
