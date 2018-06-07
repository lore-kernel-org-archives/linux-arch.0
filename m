From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
Date: Thu, 7 Jun 2018 11:48:35 -0700
Message-ID: <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607143807.3611-7-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> The following operations are provided.
>
> ARCH_CET_STATUS:
>         return the current CET status
>
> ARCH_CET_DISABLE:
>         disable CET features
>
> ARCH_CET_LOCK:
>         lock out CET features
>
> ARCH_CET_EXEC:
>         set CET features for exec()
>
> ARCH_CET_ALLOC_SHSTK:
>         allocate a new shadow stack
>
> ARCH_CET_PUSH_SHSTK:
>         put a return address on shadow stack
>
> ARCH_CET_ALLOC_SHSTK and ARCH_CET_PUSH_SHSTK are intended only for
> the implementation of GLIBC ucontext related APIs.

Please document exactly what these all do and why.  I don't understand
what purpose ARCH_CET_LOCK and ARCH_CET_EXEC serve.  CET is opt in for
each ELF program, so I think there should be no need for a magic
override.
