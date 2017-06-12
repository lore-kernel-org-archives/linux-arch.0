From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH REPOST] fs: Preventing READ_IMPLIES_EXEC Propagation
Date: Mon, 12 Jun 2017 14:41:05 +0100
Message-ID: <20170612134105.apx373745ozsc47z@localhost>
References: <2414e3b3-03f6-bd6c-5aa4-ad58c66b5aa5@huawei.com>
 <481124c6-07ba-4cb8-ca56-fb228b05f796@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <481124c6-07ba-4cb8-ca56-fb228b05f796@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "dongbo (E)" <dongbo4@huawei.com>
Cc: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, will.deacon@arm.com, arm-mail-list <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 25, 2017 at 02:58:01PM +0800, dongbo (E) wrote:
> From: Dong Bo <dongbo4@huawei.com>
> 
> In load_elf_binary(), once the READ_IMPLIES_EXEC flag is set,
> the flag is propagated to its child processes, even the elf
> files are marked as not requiring executable stack. It may
> cause superfluous operations on some arch, e.g.
> __sync_icache_dcache on aarch64 due to a PROT_READ mmap is
> also marked as PROT_EXEC.
> 
> This patch was originally posted and discussed here:
> https://patchwork.kernel.org/patch/9685891/
> 
> Signed-off-by: Dong Bo <dongbo4@huawei.com>
> ---
>  fs/binfmt_elf.c       | 2 ++
>  fs/binfmt_elf_fdpic.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 5075fd5..c52e670 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -863,6 +863,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	SET_PERSONALITY2(loc->elf_ex, &arch_state);
>  	if (elf_read_implies_exec(loc->elf_ex, executable_stack))
>  		current->personality |= READ_IMPLIES_EXEC;
> +	else
> +		current->personality &= ~READ_IMPLIES_EXEC;
>   	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
>  		current->flags |= PF_RANDOMIZE;
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index cf93a4f..c4bc4d0 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -354,6 +354,8 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>  		set_personality(PER_LINUX);
>  	if (elf_read_implies_exec(&exec_params.hdr, executable_stack))
>  		current->personality |= READ_IMPLIES_EXEC;
> +	else
> +		current->personality &= ~READ_IMPLIES_EXEC;
>   	setup_new_exec(bprm);
>  -- 1.9.1

FWIW, we queued the arm64-equivalent patch (commit 48f99c8ec0b25 in
linux-next). It doesn't change the behaviour for compat tasks since
we want to keep the same behaviour with arch/arm. If the above generic
patch gets merged, we'll drop the arm64-specific one.

-- 
Catalin
