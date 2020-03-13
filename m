From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v9 12/13] mm: smaps: Report arm64 guarded pages in smaps
Date: Thu, 12 Mar 2020 17:00:29 -0700
Message-ID: <202003121700.C10E9E5@keescook>
References: <20200311192608.40095-1-broonie@kernel.org>
 <20200311192608.40095-13-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200311192608.40095-13-broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudak
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 11, 2020 at 07:26:07PM +0000, Mark Brown wrote:
> From: Daniel Kiss <daniel.kiss@arm.com>
> 
> The arm64 Branch Target Identification support is activated by marking
> executable pages as guarded pages.  Report pages mapped this way in
> smaps to aid diagnostics.
> 
> Signed-off-by: Daniel Kiss <daniel.kiss@arm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/filesystems/proc.txt | 1 +
>  fs/proc/task_mmu.c                 | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> index 99ca040e3f90..ed5465d0f435 100644
> --- a/Documentation/filesystems/proc.txt
> +++ b/Documentation/filesystems/proc.txt
> @@ -519,6 +519,7 @@ manner. The codes are the following:
>      hg  - huge page advise flag
>      nh  - no-huge page advise flag
>      mg  - mergable advise flag
> +    bt  - arm64 BTI guarded page
>  
>  Note that there is no guarantee that every flag and associated mnemonic will
>  be present in all further kernel releases. Things get changed, the flags may
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 3ba9ae83bff5..1e3409c484d1 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -668,6 +668,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  		[ilog2(VM_ARCH_1)]	= "ar",
>  		[ilog2(VM_WIPEONFORK)]	= "wf",
>  		[ilog2(VM_DONTDUMP)]	= "dd",
> +#ifdef CONFIG_ARM64_BTI
> +		[ilog2(VM_ARM64_BTI)]	= "bt",
> +#endif
>  #ifdef CONFIG_MEM_SOFT_DIRTY
>  		[ilog2(VM_SOFTDIRTY)]	= "sd",
>  #endif
> -- 
> 2.20.1
> 

-- 
Kees Cook
