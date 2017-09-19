From: Borislav Petkov <bp@suse.de>
Subject: Re: [Part1 PATCH v4 15/17] percpu: introduce
 DEFINE_PER_CPU_UNENCRYPTED
Date: Tue, 19 Sep 2017 12:39:06 +0200
Message-ID: <20170919103906.GM4733@nazgul.tnic>
References: <20170916123418.37807-1-brijesh.singh@amd.com>
 <20170916123418.37807-16-brijesh.singh@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170916123418.37807-16-brijesh.singh@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, Sep 16, 2017 at 07:34:16AM -0500, Brijesh Singh wrote:
> When SEV is active, memory is encrypted with guest-specific key, and if

					  with a

> guest OS wants to share the memory region with hypervisor then it must

the guest OS ...			    with the hypervisor ...

> clear the C-bit (i.e set unencrypted) before sharing it.
> 
> DEFINE_PER_CPU_UNENCRYPTED can be used to define the per-cpu variables
> which will be shared between guest and hypervisor. Currently, KVM defines

		       between a guest and a hypervisor.

> three variables (steal-time, apf_reason, and avic_eio) which are shared
> with hypervisor.

This sentence should be the opening sentence of your commit message.

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: linux-arch@vger.kernel.org
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 11 +++++++++++
>  include/linux/percpu-defs.h       | 15 +++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 8acfc1e099e1..363858f43cbc 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -777,6 +777,16 @@
>  #define INIT_RAM_FS
>  #endif
>  
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +#define PERCPU_UNENCRYPTED_SECTION					\
> +	. = ALIGN(PAGE_SIZE);						\
> +	*(.data..percpu..unencrypted)					\
> +	. = ALIGN(PAGE_SIZE);
> +#else
> +#define PERCPU_UNENCRYPTED_SECTION
> +#endif
> +
> +
>  /*
>   * Default discarded sections.
>   *
> @@ -815,6 +825,7 @@
>  	. = ALIGN(cacheline);						\
>  	*(.data..percpu)						\
>  	*(.data..percpu..shared_aligned)				\
> +	PERCPU_UNENCRYPTED_SECTION					\
>  	VMLINUX_SYMBOL(__per_cpu_end) = .;

So looking at this more: I'm wondering if we can simply reuse the
PER_CPU_SHARED_ALIGNED_SECTION definition which is for shared per-CPU
sections. Instead of introducing a special section which is going to be
used only by SEV, practically.

Because "shared" also kinda implies that it is shared by multiple agents
and those agents can just as well be guest and hypervisor. And then that
patch is gone too.

Hmmm...?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
