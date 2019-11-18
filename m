From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ELF: warn if process starts with executable stack
Date: Mon, 18 Nov 2019 12:54:57 -0800
Message-ID: <20191118125457.778e44dfd4740d24795484c7@linux-foundation.org>
References: <20191118145114.GA9228@avx2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191118145114.GA9228@avx2>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, security@kernel.org
List-Id: linux-arch.vger.kernel.org

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
