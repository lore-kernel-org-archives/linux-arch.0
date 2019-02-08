From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] x86/mpx: tweak header name
Date: Fri, 8 Feb 2019 16:42:39 +0100
Message-ID: <20190208154239.GI674@zn.tnic>
References: <20190124142448.23243-1-mst@redhat.com>
 <20190124142448.23243-2-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190124142448.23243-2-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 08, 2019 at 01:02:53AM -0500, Michael S. Tsirkin wrote:
> Use linux/mman.h to make sure we get all mmap flags we need.

Why, asm/mman.h is not enough or is this fixing a build issue or what is that
patch supposed to address?

> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/x86/mm/mpx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/mpx.c b/arch/x86/mm/mpx.c
> index de1851d15699..c805db6236b4 100644
> --- a/arch/x86/mm/mpx.c
> +++ b/arch/x86/mm/mpx.c
> @@ -9,12 +9,12 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/mm_types.h>
> +#include <linux/mman.h>
>  #include <linux/syscalls.h>
>  #include <linux/sched/sysctl.h>
>  
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
> -#include <asm/mman.h>
>  #include <asm/mmu_context.h>
>  #include <asm/mpx.h>
>  #include <asm/processor.h>
> -- 

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
