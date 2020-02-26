From: Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v9 07/27] Add guard pages around a Shadow Stack.
Date: Wed, 26 Feb 2020 10:17:29 -0800
Message-ID: <07ab33de-10d8-894e-a5ef-2d5618333d73@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-8-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200205181935.3712-8-yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mike Kravetz <mike.kravetz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

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

> Signed-off-by: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
