Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from imap1.codethink.co.uk ([176.9.8.82]:47408 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfKRRNo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Nov 2019 12:13:44 -0500
Subject: Re: [PATCH] ELF: warn if process starts with executable stack
References: <20191118145114.GA9228@avx2>
From: Ben Dooks <ben.dooks@codethink.co.uk>
Message-ID: <1981366e-93d7-79bd-749f-d5d08d689a52@codethink.co.uk>
Date: Mon, 18 Nov 2019 17:13:41 +0000
MIME-Version: 1.0
In-Reply-To: <20191118145114.GA9228@avx2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, security@kernel.org
Message-ID: <20191118171341.Nj4pkRnwBgoMjYX_kmuBarv3LZLz-nz7FrMW4n79kTY@z>

On 18/11/2019 14:51, Alexey Dobriyan wrote:
> PT_GNU_STACK is fail open design, at least warn people that something
> isn't right.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>   fs/exec.c |    7 +++++++
>   1 file changed, 7 insertions(+)
> 
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -762,6 +762,13 @@ int setup_arg_pages(struct linux_binprm *bprm,
>   		goto out_unlock;
>   	BUG_ON(prev != vma);
>   

it might be worth to use:
  if (IS_ENABLED(CONFIG_MMU) && vm_flags & VM_EXEC) {

instead of the #ifdef


> +#ifdef CONFIG_MMU
> +	if (vm_flags & VM_EXEC) {
> +		pr_warn_once("process '%s'/%u started with executable stack\n",
> +			     current->comm, current->pid);
> +	}
> +#endif
> +
>   	/* Move stack pages down in memory. */
>   	if (stack_shift) {
>   		ret = shift_arg_pages(vma, stack_shift);
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
