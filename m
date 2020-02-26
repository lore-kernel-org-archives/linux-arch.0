Return-Path: <SRS0=hCVk=4O=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:38723 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgBZSRc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 13:17:32 -0500
Subject: Re: [RFC PATCH v9 07/27] Add guard pages around a Shadow Stack.
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-8-yu-cheng.yu@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <07ab33de-10d8-894e-a5ef-2d5618333d73@intel.com>
Date: Wed, 26 Feb 2020 10:17:29 -0800
MIME-Version: 1.0
In-Reply-To: <20200205181935.3712-8-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Message-ID: <20200226181729.vVgRINNRMztSPy0QuY8FjuJLinCRLDZD7Fa829uyTdM@z>

On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> INCSSPD/INCSSPQ instruction is used to unwind a Shadow Stack (SHSTK).  It
> performs 'pop and discard' of the first and last element from SHSTK in the
> range specified in the operand.

This implies, but does not directly hit on an important detail: these
instructions *touch* memory.  They don't just mess with the shadow stack
pointer, they actually dereference memory.  This makes them very
different from just manipulating %rsp and are what actually make this
guard page thing work in the first place.

> The maximum value of the operand is 255,
> and the maximum moving distance of the SHSTK pointer is 255 * 4 for
> INCSSPD, 255 * 8 for INCSSPQ.

You could also be kind and do the math for us, reminding us that ~1k and
~2k are both very far away from the 4k guard page size.

> Since SHSTK has a fixed size, creating a guard page above prevents
> INCSSP/RET from moving beyond.

What does this have to do with being a fixed size?  Also, this seems
incongruous with an API that takes a size as an argument.  It sounds
like shadow stacks are fixed in size *after* allocation, which is really
different from being truly fixed in size.

> Likewise, creating a guard page below
> prevents CALL from underflowing the SHSTK.

The language here is goofy.  I think of any "stack overflow" as the
condition where a stack grows too large.  I don't call too-large
grows-down stacks underflows, even though they are going down in their
addressing.

> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  include/linux/mm.h | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b5145fbe102e..75de07674649 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2464,9 +2464,15 @@ static inline struct vm_area_struct * find_vma_intersection(struct mm_struct * m
>  static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
>  {
>  	unsigned long vm_start = vma->vm_start;
> +	unsigned long gap = 0;
>  
> -	if (vma->vm_flags & VM_GROWSDOWN) {
> -		vm_start -= stack_guard_gap;
> +	if (vma->vm_flags & VM_GROWSDOWN)
> +		gap = stack_guard_gap;
> +	else if (vma->vm_flags & VM_SHSTK)
> +		gap = PAGE_SIZE;

Comments, please.  There is also a *lot* of stuff that has to go right
to make PAGE_SIZE OK here, including the rather funky architecture of a
single instruction.

It seems cruel and unusual punishment to future generations to make them
chase git logs for the logic rather than look at a nice code comment.

I think it's probably also best to have this be

	gap = ARCH_SHADOW_STACK_GUARD_GAP;

and then you can give the full rundown about the sizing logic inside the
arch/x86/include definition.
