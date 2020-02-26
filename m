From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v9 05/27] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack protection
Date: Wed, 26 Feb 2020 10:05:50 -0800
Message-ID: <d4dabb84-5636-2657-c45e-795f3f2dcbbc@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-6-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200205181935.3712-6-yu-cheng.yu@intel.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>
List-Id: linux-arch.vger.kernel.org

On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> +# Check assembler Shadow Stack suppot

				  ^ support

> +ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> +  ifeq ($(call as-instr, saveprevssp, y),)
> +      $(error CONFIG_X86_INTEL_SHADOW_STACK_USER not supported by the assembler)
> +  endif
> +endif

Is this *just* looking for instruction support in the assembler?

We usually just .byte them, like this for pkeys:

        asm volatile(".byte 0x0f,0x01,0xee\n\t"
                     : "=a" (pkru), "=d" (edx)
                     : "c" (ecx));

That way everybody with old toolchains can still build the kernel (and
run/test code with your config option on, btw...).
