Return-Path: <SRS0=ZbOS=4O=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [RFC PATCH v9 04/27] x86/cet: Add control-protection fault
 handler
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-5-yu-cheng.yu@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <0bc74a85-7058-0cca-62b8-949c8a881c62@intel.com>
Date: Wed, 26 Feb 2020 09:10:41 -0800
MIME-Version: 1.0
In-Reply-To: <20200205181935.3712-5-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200226171041.6dbT7gJRlIATUvonZqQ4YGpr4nR5MgC7biJVqJg-OII@z>

On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index 87ef69a72c52..8ed406f469e7 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -102,6 +102,10 @@ static const __initconst struct idt_data def_idts[=
] =3D {
>  #elif defined(CONFIG_X86_32)
>  	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_32),
>  #endif
> +
> +#ifdef CONFIG_X86_64
> +	INTG(X86_TRAP_CP,		control_protection),
> +#endif
>  };

This patch in particular appears to have all of its code unconditionally
compiled in.  That's in contrast to things that have Kconfig options, lik=
e:

#ifdef CONFIG_X86_MCE
        INTG(X86_TRAP_MC,               &machine_check),
#endif

or:

#ifdef CONFIG_X86_THERMAL_VECTOR
        INTG(THERMAL_APIC_VECTOR,       thermal_interrupt),
#endif

Is there a reason this code is always compiled in on 64-bit even when
the config option is off?
