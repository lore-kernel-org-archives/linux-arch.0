From: "H.J. Lu" <hjl.tools@gmail.com>
Subject: Re: [RFC PATCH v9 05/27] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack protection
Date: Wed, 26 Feb 2020 17:02:28 -0800
Message-ID: <CAMe9rOouOwNC873v=LOv5rJWcbe9Zvg+od8229J33V=ZfrB1rg@mail.gmail.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com> <20200205181935.3712-6-yu-cheng.yu@intel.com>
 <d4dabb84-5636-2657-c45e-795f3f2dcbbc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38518 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgB0BDF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 20:03:05 -0500
In-Reply-To: <d4dabb84-5636-2657-c45e-795f3f2dcbbc@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>

On Wed, Feb 26, 2020 at 10:05 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> > +# Check assembler Shadow Stack suppot
>
>                                   ^ support
>
> > +ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> > +  ifeq ($(call as-instr, saveprevssp, y),)
> > +      $(error CONFIG_X86_INTEL_SHADOW_STACK_USER not supported by the assembler)
> > +  endif
> > +endif
>
> Is this *just* looking for instruction support in the assembler?
>
> We usually just .byte them, like this for pkeys:
>
>         asm volatile(".byte 0x0f,0x01,0xee\n\t"
>                      : "=a" (pkru), "=d" (edx)
>                      : "c" (ecx));
>
> That way everybody with old toolchains can still build the kernel (and
> run/test code with your config option on, btw...).

CET requires a complete new OS image from kernel, toolchain, run-time.
CET enabled kernel without the rest of updated OS won't give you CET
at all.

-- 
H.J.
