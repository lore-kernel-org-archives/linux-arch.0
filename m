From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/9] x86/cet: Add Kconfig option for user-mode shadow stack
Date: Thu, 7 Jun 2018 08:47:28 -0700
Message-ID: <CALCETrWwGCZ+Fbk+O8T6S48teHj60bQQiHQ49=SsKUOpm8VLBA@mail.gmail.com>
References: <20180607143705.3531-1-yu-cheng.yu@intel.com> <20180607143705.3531-3-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607143705.3531-3-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 7, 2018 at 7:40 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> Introduce Kconfig option X86_INTEL_SHADOW_STACK_USER.
>
> An application has shadow stack protection when all the following are
> true:
>
>   (1) The kernel has X86_INTEL_SHADOW_STACK_USER enabled,
>   (2) The running processor supports the shadow stack,
>   (3) The application is built with shadow stack enabled tools & libs
>       and, and at runtime, all dependent shared libs can support shadow
>       stack.
>
> If this kernel config option is enabled, but (2) or (3) above is not
> true, the application runs without the shadow stack protection.
> Existing legacy applications will continue to work without the shadow
> stack protection.
>
> The user-mode shadow stack protection is only implemented for the
> 64-bit kernel.  Thirty-two bit applications are supported under the
> compatibility mode.
>

The 64-bit only part seems entirely reasonable.  So please make the
code 64-bit only :)
