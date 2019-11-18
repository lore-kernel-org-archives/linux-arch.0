From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] ELF: warn if process starts with executable stack
Date: Mon, 18 Nov 2019 17:13:41 +0000
Message-ID: <1981366e-93d7-79bd-749f-d5d08d689a52@codethink.co.uk>
References: <20191118145114.GA9228@avx2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191118145114.GA9228@avx2>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, security@kernel.org
List-Id: linux-arch.vger.kernel.org

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
