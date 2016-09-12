Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:41045 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755843AbcILMRo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Sep 2016 08:17:44 -0400
Date: Mon, 12 Sep 2016 14:17:40 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 16/20] x86: Check for memory encryption on the APs
Message-ID: <20160912121739.rwuumwpwo5megmd7@pd.tnic>
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223829.29880.10341.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822223829.29880.10341.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160912121740.NAQKhl-jne51cUxLDUFx2DLw1SrFOfnJy-Cy2FCtt6I@z>

On Mon, Aug 22, 2016 at 05:38:29PM -0500, Tom Lendacky wrote:
> Add support to check if memory encryption is active in the kernel and that
> it has been enabled on the AP. If memory encryption is active in the kernel
> but has not been enabled on the AP then do not allow the AP to continue
> start up.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h     |    2 ++
>  arch/x86/include/asm/realmode.h      |   12 ++++++++++++
>  arch/x86/realmode/init.c             |    4 ++++
>  arch/x86/realmode/rm/trampoline_64.S |   19 +++++++++++++++++++
>  4 files changed, 37 insertions(+)

...

> diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
> index dac7b20..94e29f4 100644
> --- a/arch/x86/realmode/rm/trampoline_64.S
> +++ b/arch/x86/realmode/rm/trampoline_64.S
> @@ -30,6 +30,7 @@
>  #include <asm/msr.h>
>  #include <asm/segment.h>
>  #include <asm/processor-flags.h>
> +#include <asm/realmode.h>
>  #include "realmode.h"
>  
>  	.text
> @@ -92,6 +93,23 @@ ENTRY(startup_32)
>  	movl	%edx, %fs
>  	movl	%edx, %gs
>  
> +	/* Check for memory encryption support */
> +	bt	$TH_FLAGS_SME_ENABLE_BIT, pa_tr_flags
> +	jnc	.Ldone
> +	movl	$MSR_K8_SYSCFG, %ecx
> +	rdmsr
> +	bt	$MSR_K8_SYSCFG_MEM_ENCRYPT_BIT, %eax
> +	jc	.Ldone
> +
> +	/*
> +	 * Memory encryption is enabled but the MSR has not been set on this
> +	 * CPU so we can't continue

Hmm, let me try to parse this correctly: BSP has SME enabled but the
BIOS might not've set this on the AP? Really? Is that even possible?

Because if SME is enabled, that means that MSR_K8_SYSCFG[23] on the BSP
is set, right?

Also, I want to rule out here simple BIOS idiocy: if the only problem
with the bit not being set in the AP is because some BIOS monkey forgot
to do so, then we should try to set it ourselves and not die for no real
reason.

Or is there another issue?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
