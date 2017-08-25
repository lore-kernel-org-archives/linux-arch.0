From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v8 02/28] x86/boot: Relocate definition of the initial
 state of CR0
Date: Fri, 25 Aug 2017 19:41:34 +0200
Message-ID: <20170825174133.r5xhcv5utfipsujo@pd.tnic>
References: <20170819002809.111312-1-ricardo.neri-calderon@linux.intel.com>
 <20170819002809.111312-3-ricardo.neri-calderon@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757454AbdHYRlp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Aug 2017 13:41:45 -0400
Content-Disposition: inline
In-Reply-To: <20170819002809.111312-3-ricardo.neri-calderon@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Brian Gerst <brgerst@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Liang Z Li <liang.z.li@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, Huang Rui <ray.huang@amd.com>, Jiri Slaby <jslaby@suse.cz>, Jonathan Corbet <corbet@lwn.net>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Vlastimil Babka <vbabka@suse.cz>, Chen Yucong <slaoub@gmail.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Shua

On Fri, Aug 18, 2017 at 05:27:43PM -0700, Ricardo Neri wrote:
> Both head_32.S and head_64.S utilize the same value to initialize the
> control register CR0. Also, other parts of the kernel might want to access
> to this initial definition (e.g., emulation code for User-Mode Instruction

s/to //

> Prevention uses this state to provide a sane dummy value for CR0 when
> emulating the smsw instruction). Thus, relocate this definition to a
> header file from which it can be conveniently accessed.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Denys Vlasenko <dvlasenk@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  arch/x86/include/uapi/asm/processor-flags.h | 6 ++++++
>  arch/x86/kernel/head_32.S                   | 3 ---
>  arch/x86/kernel/head_64.S                   | 3 ---
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
> index 185f3d10c194..aae1f2aa7563 100644
> --- a/arch/x86/include/uapi/asm/processor-flags.h
> +++ b/arch/x86/include/uapi/asm/processor-flags.h
> @@ -151,5 +151,11 @@
>  #define CX86_ARR_BASE	0xc4
>  #define CX86_RCR_BASE	0xdc
>  
> +/*
> + * Initial state of CR0 for head_32/64.S
> + */

No need for that comment.

With the minor nitpicks addressed, you can add:

Reviewed-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
