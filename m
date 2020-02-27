From: "H.J. Lu" <hjl.tools@gmail.com>
Subject: Re: [RFC PATCH v9 05/27] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack protection
Date: Wed, 26 Feb 2020 18:11:17 -0800
Message-ID: <CAMe9rOqhf4y+e6h8i7P8+70pwLSg8n=ise6LEqABNPKarECdeA@mail.gmail.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com> <20200205181935.3712-6-yu-cheng.yu@intel.com>
 <d4dabb84-5636-2657-c45e-795f3f2dcbbc@intel.com> <CAMe9rOouOwNC873v=LOv5rJWcbe9Zvg+od8229J33V=ZfrB1rg@mail.gmail.com>
 <71791bbf-7ee3-fa70-b569-ae643151646e@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <71791bbf-7ee3-fa70-b569-ae643151646e@intel.com>
Sender: linux-doc-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 26, 2020 at 5:16 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/26/20 5:02 PM, H.J. Lu wrote:
> >> That way everybody with old toolchains can still build the kernel (and
> >> run/test code with your config option on, btw...).
> > CET requires a complete new OS image from kernel, toolchain, run-time.
> > CET enabled kernel without the rest of updated OS won't give you CET
> > at all.
>
> If you require a new toolchain, nobody even builds your fancy feature.
> Probably including 0day and all of the lazy maintainers with crufty old
> distros.

GCC 8 or above is needed since vDSO must be compiled with
--fcf-protection=branch.

> The point isn't to actually run CET at all.  The point is to get as many
> people as possible testing as much of it as possible.  Testing includes
> compile testing, static analysis and bloat watching.  It also includes
> functional and performance testing when you've got the feature compiled
> in but unavailable at runtime.  Did this hurt anything even when I'm not
> using it?
>

I will leave the CET toolchain issue to Yu-cheng.

-- 
H.J.
