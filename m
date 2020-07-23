From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v10 03/26] x86/fpu/xstate: Introduce CET MSR XSAVES
 supervisor states
Date: Thu, 23 Jul 2020 09:10:39 -0700
Message-ID: <20200723161039.GE21891@linux.intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200429220732.31602-4-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:10382 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgGWQKl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jul 2020 12:10:41 -0400
Content-Disposition: inline
In-Reply-To: <20200429220732.31602-4-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>

On Wed, Apr 29, 2020 at 03:07:09PM -0700, Yu-cheng Yu wrote:
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 12c9684d59ba..47f603729543 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -885,4 +885,22 @@
>  #define MSR_VM_IGNNE                    0xc0010115
>  #define MSR_VM_HSAVE_PA                 0xc0010117
>  
> +/* Control-flow Enforcement Technology MSRs */
> +#define MSR_IA32_U_CET		0x6a0 /* user mode cet setting */
> +#define MSR_IA32_S_CET		0x6a2 /* kernel mode cet setting */
> +#define MSR_IA32_PL0_SSP	0x6a4 /* kernel shstk pointer */
> +#define MSR_IA32_PL1_SSP	0x6a5 /* ring-1 shstk pointer */
> +#define MSR_IA32_PL2_SSP	0x6a6 /* ring-2 shstk pointer */
> +#define MSR_IA32_PL3_SSP	0x6a7 /* user shstk pointer */
> +#define MSR_IA32_INT_SSP_TAB	0x6a8 /* exception shstk table */
> +
> +/* MSR_IA32_U_CET and MSR_IA32_S_CET bits */
> +#define MSR_IA32_CET_SHSTK_EN		0x0000000000000001ULL

Can we drop the MSR_IA32 prefix for the individual bits?  Mostly to yield
shorter line lengths, but also because it's more or less redundant info,
and in some ways unhelpful as it's hard to quickly differentiate between
"this is an MSR index" and "this is a bit/mask for an MSR".

My vote would also be to use BIT() or BIT_ULL().  The SDM defines the flags
by their (decimal) bit number.  Manually converting the bits to masks makes
it difficult to check for correctness.

E.g.

#define CET_SHSTK_EN		BIT(0)
#define CET_WRSS_EN		BIT(1)
#define CET_ENDBR_EN		BIT(2)
#define CET_LEG_IW_EN		BIT(3)
#define CET_NO_TRACK_EN		BIT(4)
#define CET_WAIT_ENDBR		BIT(5)

> +#define MSR_IA32_CET_WRSS_EN		0x0000000000000002ULL
> +#define MSR_IA32_CET_ENDBR_EN		0x0000000000000004ULL
> +#define MSR_IA32_CET_LEG_IW_EN		0x0000000000000008ULL
> +#define MSR_IA32_CET_NO_TRACK_EN	0x0000000000000010ULL
> +#define MSR_IA32_CET_WAIT_ENDBR	0x00000000000000800UL
> +#define MSR_IA32_CET_BITMAP_MASK	0xfffffffffffff000ULL

This particular define, the so called BITMAP_MASK, is no longer used in the
IBT series.  IMO it'd be better off dropping this mask as it's not clear
from the name that this is really nothing more than a mask for a virtual
address, e.g. at first glance (for someone without CET knowledge) it looks
like bits 63:12 hold a bitmap as opposed to holding a pointer to a bitmap.
