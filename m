From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 7/9] x86/mm: Shadow stack page fault error checking
Date: Thu, 7 Jun 2018 09:26:36 -0700
Message-ID: <CALCETrXA--XrVNvPM4-Cv6-E6OFd=TZ5Gw_MWePt7MtqCBBqRg@mail.gmail.com>
References: <20180607143705.3531-1-yu-cheng.yu@intel.com> <20180607143705.3531-8-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607143705.3531-8-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 7, 2018 at 7:40 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> If a page fault is triggered by a shadow stack access (e.g.
> call/ret) or shadow stack management instructions (e.g.
> wrussq), then bit[6] of the page fault error code is set.
>
> In access_error(), we check if a shadow stack page fault
> is within a shadow stack memory area.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 73bd8c95ac71..2b3b9170109c 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1166,6 +1166,17 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
>                                        (error_code & X86_PF_INSTR), foreign))
>                 return 1;
>
> +       /*
> +        * Verify X86_PF_SHSTK is within a shadow stack VMA.
> +        * It is always an error if there is a shadow stack
> +        * fault outside a shadow stack VMA.
> +        */
> +       if (error_code & X86_PF_SHSTK) {
> +               if (!(vma->vm_flags & VM_SHSTK))
> +                       return 1;
> +               return 0;
> +       }
> +

What, if anything, would go wrong without this change?  It seems like
it might be purely an optimization.  If so, can you mention that in
the comment?
