From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] ftrace: Format MCOUNT_ADDR address as type unsigned
 long
Date: Mon, 13 Jul 2015 11:04:46 -0400
Message-ID: <20150713110446.01c950ea@gandalf.local.home>
References: <1436694744-16747-1-git-send-email-mhuang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436694744-16747-1-git-send-email-mhuang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Minfei Huang <mhuang@redhat.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, Minfei Huang <mnfhuang@gmail.com>, linux-arch@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Sun, 12 Jul 2015 17:52:24 +0800
Minfei Huang <mhuang@redhat.com> wrote:

> From: Minfei Huang <mnfhuang@gmail.com>
> 
> Always we use type unsigned long to format the ip address, since the
> value of ip address is never the negative.
> 
> This patch uses type unsigned long, instead of long, to format the ip
> address. The code is more clearly to be viewed by using type unsigned
> long, although it is correct by using either unsigned long or long.
> 

The only place MCOUNT_ADDR is used in generic code is being passed into
a parameter that is already typed "unsigned long". But I'm fine with
the patch just to make it consistent. I added the appropriate Cc's for
this patch too.

-- Steve


> Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> ---
>  arch/metag/include/asm/ftrace.h      | 2 +-
>  arch/microblaze/include/asm/ftrace.h | 2 +-
>  arch/powerpc/include/asm/ftrace.h    | 2 +-
>  arch/sh/include/asm/ftrace.h         | 2 +-
>  arch/sparc/include/asm/ftrace.h      | 2 +-
>  arch/x86/include/asm/ftrace.h        | 4 ++--
>  6 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/metag/include/asm/ftrace.h b/arch/metag/include/asm/ftrace.h
> index 2901f0f..a2269d6 100644
> --- a/arch/metag/include/asm/ftrace.h
> +++ b/arch/metag/include/asm/ftrace.h
> @@ -6,7 +6,7 @@
>  
>  #ifndef __ASSEMBLY__
>  extern void mcount_wrapper(void);
> -#define MCOUNT_ADDR		((long)(mcount_wrapper))
> +#define MCOUNT_ADDR		((unsigned long)(mcount_wrapper))
>  
>  static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  {
> diff --git a/arch/microblaze/include/asm/ftrace.h b/arch/microblaze/include/asm/ftrace.h
> index fd2fa2ec..da0144f 100644
> --- a/arch/microblaze/include/asm/ftrace.h
> +++ b/arch/microblaze/include/asm/ftrace.h
> @@ -3,7 +3,7 @@
>  
>  #ifdef CONFIG_FUNCTION_TRACER
>  
> -#define MCOUNT_ADDR		((long)(_mcount))
> +#define MCOUNT_ADDR		((unsigned long)(_mcount))
>  #define MCOUNT_INSN_SIZE	8 /* sizeof mcount call */
>  
>  #ifndef __ASSEMBLY__
> diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
> index e366187..ef89b14 100644
> --- a/arch/powerpc/include/asm/ftrace.h
> +++ b/arch/powerpc/include/asm/ftrace.h
> @@ -2,7 +2,7 @@
>  #define _ASM_POWERPC_FTRACE
>  
>  #ifdef CONFIG_FUNCTION_TRACER
> -#define MCOUNT_ADDR		((long)(_mcount))
> +#define MCOUNT_ADDR		((unsigned long)(_mcount))
>  #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
>  
>  #ifdef __ASSEMBLY__
> diff --git a/arch/sh/include/asm/ftrace.h b/arch/sh/include/asm/ftrace.h
> index e79fb6e..1f157b8 100644
> --- a/arch/sh/include/asm/ftrace.h
> +++ b/arch/sh/include/asm/ftrace.h
> @@ -9,7 +9,7 @@
>  #ifndef __ASSEMBLY__
>  extern void mcount(void);
>  
> -#define MCOUNT_ADDR		((long)(mcount))
> +#define MCOUNT_ADDR		((unsigned long)(mcount))
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  #define CALL_ADDR		((long)(ftrace_call))
> diff --git a/arch/sparc/include/asm/ftrace.h b/arch/sparc/include/asm/ftrace.h
> index 9ec94ad..3192a8e 100644
> --- a/arch/sparc/include/asm/ftrace.h
> +++ b/arch/sparc/include/asm/ftrace.h
> @@ -2,7 +2,7 @@
>  #define _ASM_SPARC64_FTRACE
>  
>  #ifdef CONFIG_MCOUNT
> -#define MCOUNT_ADDR		((long)(_mcount))
> +#define MCOUNT_ADDR		((unsigned long)(_mcount))
>  #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
>  
>  #ifndef __ASSEMBLY__
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index f45acad..2493885 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -3,9 +3,9 @@
>  
>  #ifdef CONFIG_FUNCTION_TRACER
>  #ifdef CC_USING_FENTRY
> -# define MCOUNT_ADDR		((long)(__fentry__))
> +# define MCOUNT_ADDR		((unsigned long)(__fentry__))
>  #else
> -# define MCOUNT_ADDR		((long)(mcount))
> +# define MCOUNT_ADDR		((unsigned long)(mcount))
>  #endif
>  #define MCOUNT_INSN_SIZE	5 /* sizeof mcount call */
>  
