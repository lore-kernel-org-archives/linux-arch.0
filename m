From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [3.13.y-ckt stable] Patch "vm: add VM_FAULT_SIGSEGV handling
 support" has been added to staging queue
Date: Wed, 18 Mar 2015 21:14:48 -0700
Message-ID: <CA+55aFzVEaKWemEHF8q1sbeacbGn2WvaGCw8cR+rB30ztintCg@mail.gmail.com>
References: <1426720989-21086-1-git-send-email-kamal@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9168260018463446576=="
Return-path: <kernel-team-bounces@lists.ubuntu.com>
In-Reply-To: <1426720989-21086-1-git-send-email-kamal@canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/options/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/kernel-team>
List-Post: <mailto:kernel-team@lists.ubuntu.com>
List-Help: <mailto:kernel-team-request@lists.ubuntu.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=subscribe>
Errors-To: kernel-team-bounces@lists.ubuntu.com
Sender: kernel-team-bounces@lists.ubuntu.com
To: Kamal Mostafa <kamal@canonical.com>
Cc: linux-arch@vger.kernel.org, Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

--===============9168260018463446576==
Content-Type: multipart/alternative; boundary=047d7b343c9ccd8f7a05119c70ac

--047d7b343c9ccd8f7a05119c70ac
Content-Type: text/plain; charset=UTF-8

I hope you know that you need to backport 7fb08eca4527 too.

   Linus
On Mar 18, 2015 4:26 PM, "Kamal Mostafa" <kamal@canonical.com> wrote:

> This is a note to let you know that I have just added a patch titled
>
>     vm: add VM_FAULT_SIGSEGV handling support
>
> to the linux-3.13.y-queue branch of the 3.13.y-ckt extended stable tree
> which can be found at:
>
>
> http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.13.y-queue
>
> This patch is scheduled to be released in version 3.13.11-ckt17.
>
> If you, or anyone else, feels it should not be added to this tree, please
> reply to this email.
>
> For more information about the 3.13.y-ckt tree, see
> https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable
>
> Thanks.
> -Kamal
>
> ------
>
> From 8dfe997e9cb21f0f279ef819c2e05a6c2f8fdfbe Mon Sep 17 00:00:00 2001
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Thu, 29 Jan 2015 10:51:32 -0800
> Subject: vm: add VM_FAULT_SIGSEGV handling support
>
> commit 33692f27597fcab536d7cbbcc8f52905133e4aa7 upstream.
>
> The core VM already knows about VM_FAULT_SIGBUS, but cannot return a
> "you should SIGSEGV" error, because the SIGSEGV case was generally
> handled by the caller - usually the architecture fault handler.
>
> That results in lots of duplication - all the architecture fault
> handlers end up doing very similar "look up vma, check permissions, do
> retries etc" - but it generally works.  However, there are cases where
> the VM actually wants to SIGSEGV, and applications _expect_ SIGSEGV.
>
> In particular, when accessing the stack guard page, libsigsegv expects a
> SIGSEGV.  And it usually got one, because the stack growth is handled by
> that duplicated architecture fault handler.
>
> However, when the generic VM layer started propagating the error return
> from the stack expansion in commit fee7e49d4514 ("mm: propagate error
> from stack expansion even for guard page"), that now exposed the
> existing VM_FAULT_SIGBUS result to user space.  And user space really
> expected SIGSEGV, not SIGBUS.
>
> To fix that case, we need to add a VM_FAULT_SIGSEGV, and teach all those
> duplicate architecture fault handlers about it.  They all already have
> the code to handle SIGSEGV, so it's about just tying that new return
> value to the existing code, but it's all a bit annoying.
>
> This is the mindless minimal patch to do this.  A more extensive patch
> would be to try to gather up the mostly shared fault handling logic into
> one generic helper routine, and long-term we really should do that
> cleanup.
>
> Just from this patch, you can generally see that most architectures just
> copied (directly or indirectly) the old x86 way of doing things, but in
> the meantime that original x86 model has been improved to hold the VM
> semaphore for shorter times etc and to handle VM_FAULT_RETRY and other
> "newer" things, so it would be a good idea to bring all those
> improvements to the generic case and teach other architectures about
> them too.
>
> Reported-and-tested-by: Takashi Iwai <tiwai@suse.de>
> Tested-by: Jan Engelhardt <jengelh@inai.de>
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> # "s390 still
> compiles and boots"
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> [ kamal: omitted for 3.13-stable:
>   arch/nios2/mm/fault.c arch/powerpc/mm/copro_fault.c mm/gup.c ]
> Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> ---
>  arch/alpha/mm/fault.c                        | 2 ++
>  arch/arc/mm/fault.c                          | 2 ++
>  arch/avr32/mm/fault.c                        | 2 ++
>  arch/cris/mm/fault.c                         | 2 ++
>  arch/frv/mm/fault.c                          | 2 ++
>  arch/ia64/mm/fault.c                         | 2 ++
>  arch/m32r/mm/fault.c                         | 2 ++
>  arch/m68k/mm/fault.c                         | 2 ++
>  arch/metag/mm/fault.c                        | 2 ++
>  arch/microblaze/mm/fault.c                   | 2 ++
>  arch/mips/mm/fault.c                         | 2 ++
>  arch/mn10300/mm/fault.c                      | 2 ++
>  arch/openrisc/mm/fault.c                     | 2 ++
>  arch/parisc/mm/fault.c                       | 2 ++
>  arch/powerpc/mm/fault.c                      | 2 ++
>  arch/s390/mm/fault.c                         | 6 ++++++
>  arch/score/mm/fault.c                        | 2 ++
>  arch/sh/mm/fault.c                           | 2 ++
>  arch/sparc/mm/fault_32.c                     | 2 ++
>  arch/sparc/mm/fault_64.c                     | 2 ++
>  arch/tile/mm/fault.c                         | 2 ++
>  arch/um/kernel/trap.c                        | 2 ++
>  arch/x86/mm/fault.c                          | 2 ++
>  arch/xtensa/mm/fault.c                       | 2 ++
>  drivers/staging/lustre/lustre/llite/vvp_io.c | 2 +-
>  include/linux/mm.h                           | 6 ++++--
>  mm/ksm.c                                     | 2 +-
>  27 files changed, 58 insertions(+), 4 deletions(-)
>
> diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
> index 98838a0..9d0ac09 100644
> --- a/arch/alpha/mm/fault.c
> +++ b/arch/alpha/mm/fault.c
> @@ -156,6 +156,8 @@ retry:
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 else if (fault & VM_FAULT_SIGBUS)
>                         goto do_sigbus;
>                 BUG();
> diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
> index 9c69552..15879a1 100644
> --- a/arch/arc/mm/fault.c
> +++ b/arch/arc/mm/fault.c
> @@ -162,6 +162,8 @@ good_area:
>         /* TBD: switch to pagefault_out_of_memory() */
>         if (fault & VM_FAULT_OOM)
>                 goto out_of_memory;
> +       else if (fault & VM_FAULT_SIGSEV)
> +               goto bad_area;
>         else if (fault & VM_FAULT_SIGBUS)
>                 goto do_sigbus;
>
> diff --git a/arch/avr32/mm/fault.c b/arch/avr32/mm/fault.c
> index 0eca933..d223a8b 100644
> --- a/arch/avr32/mm/fault.c
> +++ b/arch/avr32/mm/fault.c
> @@ -142,6 +142,8 @@ good_area:
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 else if (fault & VM_FAULT_SIGBUS)
>                         goto do_sigbus;
>                 BUG();
> diff --git a/arch/cris/mm/fault.c b/arch/cris/mm/fault.c
> index 1790f22..2686a7a 100644
> --- a/arch/cris/mm/fault.c
> +++ b/arch/cris/mm/fault.c
> @@ -176,6 +176,8 @@ retry:
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 else if (fault & VM_FAULT_SIGBUS)
>                         goto do_sigbus;
>                 BUG();
> diff --git a/arch/frv/mm/fault.c b/arch/frv/mm/fault.c
> index 9a66372..ec4917d 100644
> --- a/arch/frv/mm/fault.c
> +++ b/arch/frv/mm/fault.c
> @@ -168,6 +168,8 @@ asmlinkage void do_page_fault(int datammu, unsigned
> long esr0, unsigned long ear
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 else if (fault & VM_FAULT_SIGBUS)
>                         goto do_sigbus;
>                 BUG();
> diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
> index 7225dad..ba5ba7a 100644
> --- a/arch/ia64/mm/fault.c
> +++ b/arch/ia64/mm/fault.c
> @@ -172,6 +172,8 @@ retry:
>                  */
>                 if (fault & VM_FAULT_OOM) {
>                         goto out_of_memory;
> +               } else if (fault & VM_FAULT_SIGSEGV) {
> +                       goto bad_area;
>                 } else if (fault & VM_FAULT_SIGBUS) {
>                         signal = SIGBUS;
>                         goto bad_area;
> diff --git a/arch/m32r/mm/fault.c b/arch/m32r/mm/fault.c
> index e9c6a80..e3d4d48901 100644
> --- a/arch/m32r/mm/fault.c
> +++ b/arch/m32r/mm/fault.c
> @@ -200,6 +200,8 @@ good_area:
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 else if (fault & VM_FAULT_SIGBUS)
>                         goto do_sigbus;
>                 BUG();
> diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
> index eb1d61f..f0eef04 100644
> --- a/arch/m68k/mm/fault.c
> +++ b/arch/m68k/mm/fault.c
> @@ -153,6 +153,8 @@ good_area:
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto map_err;
>                 else if (fault & VM_FAULT_SIGBUS)
>                         goto bus_err;
>                 BUG();
> diff --git a/arch/metag/mm/fault.c b/arch/metag/mm/fault.c
> index 332680e..2de5dc6 100644
> --- a/arch/metag/mm/fault.c
> +++ b/arch/metag/mm/fault.c
> @@ -141,6 +141,8 @@ good_area:
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 else if (fault & VM_FAULT_SIGBUS)
>                         goto do_sigbus;
>                 BUG();
> diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
> index fa4cf52..d46a5eb 100644
> --- a/arch/microblaze/mm/fault.c
> +++ b/arch/microblaze/mm/fault.c
> @@ -224,6 +224,8 @@ good_area:
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 else if (fault & VM_FAULT_SIGBUS)
>                         goto do_sigbus;
>                 BUG();
> diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
> index becc42b..70ab5d6 100644
> --- a/arch/mips/mm/fault.c
> +++ b/arch/mips/mm/fault.c
> @@ -158,6 +158,8 @@ good_area:
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 else if (fault & VM_FAULT_SIGBUS)
>                         goto do_sigbus;
>                 BUG();
> diff --git a/arch/mn10300/mm/fault.c b/arch/mn10300/mm/fault.c
> index 3516cbd..0c2cc5d 100644
> --- a/arch/mn10300/mm/fault.c
> +++ b/arch/mn10300/mm/fault.c
> @@ -262,6 +262,8 @@ good_area:
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 else if (fault & VM_FAULT_SIGBUS)
>                         goto do_sigbus;
>                 BUG();
> diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
> index 0703acf..230ac20 100644
> --- a/arch/openrisc/mm/fault.c
> +++ b/arch/openrisc/mm/fault.c
> @@ -171,6 +171,8 @@ good_area:
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 else if (fault & VM_FAULT_SIGBUS)
>                         goto do_sigbus;
>                 BUG();
> diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
> index d72197f..d27e388 100644
> --- a/arch/parisc/mm/fault.c
> +++ b/arch/parisc/mm/fault.c
> @@ -256,6 +256,8 @@ good_area:
>                  */
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 else if (fault & VM_FAULT_SIGBUS)
>                         goto bad_area;
>                 BUG();
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 51ab9e7..010fabf 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -432,6 +432,8 @@ good_area:
>          */
>         fault = handle_mm_fault(mm, vma, address, flags);
>         if (unlikely(fault & (VM_FAULT_RETRY|VM_FAULT_ERROR))) {
> +               if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 rc = mm_fault_error(regs, address, fault);
>                 if (rc >= MM_FAULT_RETURN)
>                         goto bail;
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index d95265b2..8e95432 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -239,6 +239,12 @@ static noinline void do_fault_error(struct pt_regs
> *regs, int fault)
>                                 do_no_context(regs);
>                         else
>                                 pagefault_out_of_memory();
> +               } else if (fault & VM_FAULT_SIGSEGV) {
> +                       /* Kernel mode? Handle exceptions or die */
> +                       if (!user_mode(regs))
> +                               do_no_context(regs);
> +                       else
> +                               do_sigsegv(regs, SEGV_MAPERR);
>                 } else if (fault & VM_FAULT_SIGBUS) {
>                         /* Kernel mode? Handle exceptions or die */
>                         if (!user_mode(regs))
> diff --git a/arch/score/mm/fault.c b/arch/score/mm/fault.c
> index 52238983..6860beb 100644
> --- a/arch/score/mm/fault.c
> +++ b/arch/score/mm/fault.c
> @@ -114,6 +114,8 @@ good_area:
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 else if (fault & VM_FAULT_SIGBUS)
>                         goto do_sigbus;
>                 BUG();
> diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
> index 541dc61..a58fec9 100644
> --- a/arch/sh/mm/fault.c
> +++ b/arch/sh/mm/fault.c
> @@ -353,6 +353,8 @@ mm_fault_error(struct pt_regs *regs, unsigned long
> error_code,
>         } else {
>                 if (fault & VM_FAULT_SIGBUS)
>                         do_sigbus(regs, error_code, address);
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       bad_area(regs, error_code, address);
>                 else
>                         BUG();
>         }
> diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
> index 59dbd46..163c787 100644
> --- a/arch/sparc/mm/fault_32.c
> +++ b/arch/sparc/mm/fault_32.c
> @@ -252,6 +252,8 @@ good_area:
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 else if (fault & VM_FAULT_SIGBUS)
>                         goto do_sigbus;
>                 BUG();
> diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
> index 45a413e..0d6de79 100644
> --- a/arch/sparc/mm/fault_64.c
> +++ b/arch/sparc/mm/fault_64.c
> @@ -448,6 +448,8 @@ good_area:
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 else if (fault & VM_FAULT_SIGBUS)
>                         goto do_sigbus;
>                 BUG();
> diff --git a/arch/tile/mm/fault.c b/arch/tile/mm/fault.c
> index 6c05712..c6d2a76 100644
> --- a/arch/tile/mm/fault.c
> +++ b/arch/tile/mm/fault.c
> @@ -444,6 +444,8 @@ good_area:
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 else if (fault & VM_FAULT_SIGBUS)
>                         goto do_sigbus;
>                 BUG();
> diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
> index 974b874..53b8320 100644
> --- a/arch/um/kernel/trap.c
> +++ b/arch/um/kernel/trap.c
> @@ -80,6 +80,8 @@ good_area:
>                 if (unlikely(fault & VM_FAULT_ERROR)) {
>                         if (fault & VM_FAULT_OOM) {
>                                 goto out_of_memory;
> +                       } else if (fault & VM_FAULT_SIGSEGV) {
> +                               goto out;
>                         } else if (fault & VM_FAULT_SIGBUS) {
>                                 err = -EACCES;
>                                 goto out;
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 6dea040..3b5a244 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -894,6 +894,8 @@ mm_fault_error(struct pt_regs *regs, unsigned long
> error_code,
>                 if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
>                              VM_FAULT_HWPOISON_LARGE))
>                         do_sigbus(regs, error_code, address, fault);
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       bad_area_nosemaphore(regs, error_code, address);
>                 else
>                         BUG();
>         }
> diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
> index 70fa7bc..3827833 100644
> --- a/arch/xtensa/mm/fault.c
> +++ b/arch/xtensa/mm/fault.c
> @@ -117,6 +117,8 @@ good_area:
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 if (fault & VM_FAULT_OOM)
>                         goto out_of_memory;
> +               else if (fault & VM_FAULT_SIGSEGV)
> +                       goto bad_area;
>                 else if (fault & VM_FAULT_SIGBUS)
>                         goto do_sigbus;
>                 BUG();
> diff --git a/drivers/staging/lustre/lustre/llite/vvp_io.c
> b/drivers/staging/lustre/lustre/llite/vvp_io.c
> index 3ff664c..37b14f3 100644
> --- a/drivers/staging/lustre/lustre/llite/vvp_io.c
> +++ b/drivers/staging/lustre/lustre/llite/vvp_io.c
> @@ -601,7 +601,7 @@ static int vvp_io_kernel_fault(struct vvp_fault_io
> *cfio)
>                 return 0;
>         }
>
> -       if (cfio->fault.ft_flags & VM_FAULT_SIGBUS) {
> +       if (cfio->fault.ft_flags & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV)) {
>                 CDEBUG(D_PAGE, "got addr %p - SIGBUS\n",
> vmf->virtual_address);
>                 return -EFAULT;
>         }
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c61755d..bc205d8 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -972,6 +972,7 @@ static inline int page_mapped(struct page *page)
>  #define VM_FAULT_WRITE 0x0008  /* Special case for get_user_pages */
>  #define VM_FAULT_HWPOISON 0x0010       /* Hit poisoned small page */
>  #define VM_FAULT_HWPOISON_LARGE 0x0020  /* Hit poisoned large page. Index
> encoded in upper bits */
> +#define VM_FAULT_SIGSEGV 0x0040
>
>  #define VM_FAULT_NOPAGE        0x0100  /* ->fault installed the pte, not
> return page */
>  #define VM_FAULT_LOCKED        0x0200  /* ->fault locked the returned
> page */
> @@ -980,8 +981,9 @@ static inline int page_mapped(struct page *page)
>
>  #define VM_FAULT_HWPOISON_LARGE_MASK 0xf000 /* encodes hpage index for
> large hwpoison */
>
> -#define VM_FAULT_ERROR (VM_FAULT_OOM | VM_FAULT_SIGBUS |
> VM_FAULT_HWPOISON | \
> -                        VM_FAULT_FALLBACK | VM_FAULT_HWPOISON_LARGE)
> +#define VM_FAULT_ERROR (VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV
> | \
> +                        VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE | \
> +                        VM_FAULT_FALLBACK)
>
>  /* Encode hstate index for a hwpoisoned large page */
>  #define VM_FAULT_SET_HINDEX(x) ((x) << 12)
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 418b8ca..813a1d9 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -376,7 +376,7 @@ static int break_ksm(struct vm_area_struct *vma,
> unsigned long addr)
>                 else
>                         ret = VM_FAULT_WRITE;
>                 put_page(page);
> -       } while (!(ret & (VM_FAULT_WRITE | VM_FAULT_SIGBUS |
> VM_FAULT_OOM)));
> +       } while (!(ret & (VM_FAULT_WRITE | VM_FAULT_SIGBUS |
> VM_FAULT_SIGSEGV | VM_FAULT_OOM)));
>         /*
>          * We must loop because handle_mm_fault() may back out if there's
>          * any difficulty e.g. if pte accessed bit gets updated
> concurrently.
> --
> 1.9.1
>
>

--047d7b343c9ccd8f7a05119c70ac
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I hope you know that you need to backport 7fb08eca4527 too.<=
/p>
<p dir=3D"ltr">=C2=A0=C2=A0 Linus</p>
<div class=3D"gmail_quote">On Mar 18, 2015 4:26 PM, &quot;Kamal Mostafa&quo=
t; &lt;<a href=3D"mailto:kamal@canonical.com">kamal@canonical.com</a>&gt; w=
rote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This is a note=
 to let you know that I have just added a patch titled<br>
<br>
=C2=A0 =C2=A0 vm: add VM_FAULT_SIGSEGV handling support<br>
<br>
to the linux-3.13.y-queue branch of the 3.13.y-ckt extended stable tree<br>
which can be found at:<br>
<br>
=C2=A0<a href=3D"http://kernel.ubuntu.com/git?p=3Dubuntu/linux.git;a=3Dshor=
tlog;h=3Drefs/heads/linux-3.13.y-queue" target=3D"_blank">http://kernel.ubu=
ntu.com/git?p=3Dubuntu/linux.git;a=3Dshortlog;h=3Drefs/heads/linux-3.13.y-q=
ueue</a><br>
<br>
This patch is scheduled to be released in version 3.13.11-ckt17.<br>
<br>
If you, or anyone else, feels it should not be added to this tree, please<b=
r>
reply to this email.<br>
<br>
For more information about the 3.13.y-ckt tree, see<br>
<a href=3D"https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable" target=3D"_bl=
ank">https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable</a><br>
<br>
Thanks.<br>
-Kamal<br>
<br>
------<br>
<br>
From 8dfe997e9cb21f0f279ef819c2e05a6c2f8fdfbe Mon Sep 17 00:00:00 2001<br>
From: Linus Torvalds &lt;<a href=3D"mailto:torvalds@linux-foundation.org">t=
orvalds@linux-foundation.org</a>&gt;<br>
Date: Thu, 29 Jan 2015 10:51:32 -0800<br>
Subject: vm: add VM_FAULT_SIGSEGV handling support<br>
<br>
commit 33692f27597fcab536d7cbbcc8f52905133e4aa7 upstream.<br>
<br>
The core VM already knows about VM_FAULT_SIGBUS, but cannot return a<br>
&quot;you should SIGSEGV&quot; error, because the SIGSEGV case was generall=
y<br>
handled by the caller - usually the architecture fault handler.<br>
<br>
That results in lots of duplication - all the architecture fault<br>
handlers end up doing very similar &quot;look up vma, check permissions, do=
<br>
retries etc&quot; - but it generally works.=C2=A0 However, there are cases =
where<br>
the VM actually wants to SIGSEGV, and applications _expect_ SIGSEGV.<br>
<br>
In particular, when accessing the stack guard page, libsigsegv expects a<br=
>
SIGSEGV.=C2=A0 And it usually got one, because the stack growth is handled =
by<br>
that duplicated architecture fault handler.<br>
<br>
However, when the generic VM layer started propagating the error return<br>
from the stack expansion in commit fee7e49d4514 (&quot;mm: propagate error<=
br>
from stack expansion even for guard page&quot;), that now exposed the<br>
existing VM_FAULT_SIGBUS result to user space.=C2=A0 And user space really<=
br>
expected SIGSEGV, not SIGBUS.<br>
<br>
To fix that case, we need to add a VM_FAULT_SIGSEGV, and teach all those<br=
>
duplicate architecture fault handlers about it.=C2=A0 They all already have=
<br>
the code to handle SIGSEGV, so it&#39;s about just tying that new return<br=
>
value to the existing code, but it&#39;s all a bit annoying.<br>
<br>
This is the mindless minimal patch to do this.=C2=A0 A more extensive patch=
<br>
would be to try to gather up the mostly shared fault handling logic into<br=
>
one generic helper routine, and long-term we really should do that<br>
cleanup.<br>
<br>
Just from this patch, you can generally see that most architectures just<br=
>
copied (directly or indirectly) the old x86 way of doing things, but in<br>
the meantime that original x86 model has been improved to hold the VM<br>
semaphore for shorter times etc and to handle VM_FAULT_RETRY and other<br>
&quot;newer&quot; things, so it would be a good idea to bring all those<br>
improvements to the generic case and teach other architectures about<br>
them too.<br>
<br>
Reported-and-tested-by: Takashi Iwai &lt;<a href=3D"mailto:tiwai@suse.de">t=
iwai@suse.de</a>&gt;<br>
Tested-by: Jan Engelhardt &lt;<a href=3D"mailto:jengelh@inai.de">jengelh@in=
ai.de</a>&gt;<br>
Acked-by: Heiko Carstens &lt;<a href=3D"mailto:heiko.carstens@de.ibm.com">h=
eiko.carstens@de.ibm.com</a>&gt; # &quot;s390 still compiles and boots&quot=
;<br>
Cc: <a href=3D"mailto:linux-arch@vger.kernel.org">linux-arch@vger.kernel.or=
g</a><br>
Signed-off-by: Linus Torvalds &lt;<a href=3D"mailto:torvalds@linux-foundati=
on.org">torvalds@linux-foundation.org</a>&gt;<br>
[ kamal: omitted for 3.13-stable:<br>
=C2=A0 arch/nios2/mm/fault.c arch/powerpc/mm/copro_fault.c mm/gup.c ]<br>
Signed-off-by: Kamal Mostafa &lt;<a href=3D"mailto:kamal@canonical.com">kam=
al@canonical.com</a>&gt;<br>
---<br>
=C2=A0arch/alpha/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 ++<br>
=C2=A0arch/arc/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 ++<br>
=C2=A0arch/avr32/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 ++<br>
=C2=A0arch/cris/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A0arch/frv/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 ++<br>
=C2=A0arch/ia64/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A0arch/m32r/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A0arch/m68k/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A0arch/metag/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 ++<br>
=C2=A0arch/microblaze/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A0arch/mips/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A0arch/mn10300/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 ++<br>
=C2=A0arch/openrisc/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A0arch/parisc/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A0arch/powerpc/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 ++<br>
=C2=A0arch/s390/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 6 ++++++<br>
=C2=A0arch/score/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 ++<br>
=C2=A0arch/sh/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A0arch/sparc/mm/fault_32.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A0arch/sparc/mm/fault_64.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A0arch/tile/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A0arch/um/kernel/trap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 ++<br>
=C2=A0arch/x86/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 ++<br>
=C2=A0arch/xtensa/mm/fault.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A0drivers/staging/lustre/lustre/llite/vvp_io.c | 2 +-<br>
=C2=A0include/linux/mm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 6 ++++--<br>
=C2=A0mm/ksm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
2 +-<br>
=C2=A027 files changed, 58 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c<br>
index 98838a0..9d0ac09 100644<br>
--- a/arch/alpha/mm/fault.c<br>
+++ b/arch/alpha/mm/fault.c<br>
@@ -156,6 +156,8 @@ retry:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault &amp; VM_FAULT_ERROR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp=
; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto do_sigbus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();<br>
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c<br>
index 9c69552..15879a1 100644<br>
--- a/arch/arc/mm/fault.c<br>
+++ b/arch/arc/mm/fault.c<br>
@@ -162,6 +162,8 @@ good_area:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TBD: switch to pagefault_out_of_memory() */<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_of_memory;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp; VM_FAULT_SIGSEV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto do_sigbus;<br>
<br>
diff --git a/arch/avr32/mm/fault.c b/arch/avr32/mm/fault.c<br>
index 0eca933..d223a8b 100644<br>
--- a/arch/avr32/mm/fault.c<br>
+++ b/arch/avr32/mm/fault.c<br>
@@ -142,6 +142,8 @@ good_area:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault &amp; VM_FAULT_ERROR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp=
; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto do_sigbus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();<br>
diff --git a/arch/cris/mm/fault.c b/arch/cris/mm/fault.c<br>
index 1790f22..2686a7a 100644<br>
--- a/arch/cris/mm/fault.c<br>
+++ b/arch/cris/mm/fault.c<br>
@@ -176,6 +176,8 @@ retry:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault &amp; VM_FAULT_ERROR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp=
; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto do_sigbus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();<br>
diff --git a/arch/frv/mm/fault.c b/arch/frv/mm/fault.c<br>
index 9a66372..ec4917d 100644<br>
--- a/arch/frv/mm/fault.c<br>
+++ b/arch/frv/mm/fault.c<br>
@@ -168,6 +168,8 @@ asmlinkage void do_page_fault(int datammu, unsigned lon=
g esr0, unsigned long ear<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault &amp; VM_FAULT_ERROR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp=
; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto do_sigbus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();<br>
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c<br>
index 7225dad..ba5ba7a 100644<br>
--- a/arch/ia64/mm/fault.c<br>
+++ b/arch/ia64/mm/fault.c<br>
@@ -172,6 +172,8 @@ retry:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (fault &a=
mp; VM_FAULT_SIGSEGV) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (fault &a=
mp; VM_FAULT_SIGBUS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 signal =3D SIGBUS;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto bad_area;<br>
diff --git a/arch/m32r/mm/fault.c b/arch/m32r/mm/fault.c<br>
index e9c6a80..e3d4d48901 100644<br>
--- a/arch/m32r/mm/fault.c<br>
+++ b/arch/m32r/mm/fault.c<br>
@@ -200,6 +200,8 @@ good_area:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault &amp; VM_FAULT_ERROR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp=
; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto do_sigbus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();<br>
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c<br>
index eb1d61f..f0eef04 100644<br>
--- a/arch/m68k/mm/fault.c<br>
+++ b/arch/m68k/mm/fault.c<br>
@@ -153,6 +153,8 @@ good_area:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault &amp; VM_FAULT_ERROR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto map_err;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp=
; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto bus_err;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();<br>
diff --git a/arch/metag/mm/fault.c b/arch/metag/mm/fault.c<br>
index 332680e..2de5dc6 100644<br>
--- a/arch/metag/mm/fault.c<br>
+++ b/arch/metag/mm/fault.c<br>
@@ -141,6 +141,8 @@ good_area:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault &amp; VM_FAULT_ERROR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp=
; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto do_sigbus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();<br>
diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c<br>
index fa4cf52..d46a5eb 100644<br>
--- a/arch/microblaze/mm/fault.c<br>
+++ b/arch/microblaze/mm/fault.c<br>
@@ -224,6 +224,8 @@ good_area:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault &amp; VM_FAULT_ERROR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp=
; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto do_sigbus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();<br>
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c<br>
index becc42b..70ab5d6 100644<br>
--- a/arch/mips/mm/fault.c<br>
+++ b/arch/mips/mm/fault.c<br>
@@ -158,6 +158,8 @@ good_area:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault &amp; VM_FAULT_ERROR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp=
; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto do_sigbus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();<br>
diff --git a/arch/mn10300/mm/fault.c b/arch/mn10300/mm/fault.c<br>
index 3516cbd..0c2cc5d 100644<br>
--- a/arch/mn10300/mm/fault.c<br>
+++ b/arch/mn10300/mm/fault.c<br>
@@ -262,6 +262,8 @@ good_area:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault &amp; VM_FAULT_ERROR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp=
; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto do_sigbus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();<br>
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c<br>
index 0703acf..230ac20 100644<br>
--- a/arch/openrisc/mm/fault.c<br>
+++ b/arch/openrisc/mm/fault.c<br>
@@ -171,6 +171,8 @@ good_area:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault &amp; VM_FAULT_ERROR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp=
; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto do_sigbus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();<br>
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c<br>
index d72197f..d27e388 100644<br>
--- a/arch/parisc/mm/fault.c<br>
+++ b/arch/parisc/mm/fault.c<br>
@@ -256,6 +256,8 @@ good_area:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp=
; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();<br>
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c<br>
index 51ab9e7..010fabf 100644<br>
--- a/arch/powerpc/mm/fault.c<br>
+++ b/arch/powerpc/mm/fault.c<br>
@@ -432,6 +432,8 @@ good_area:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fault =3D handle_mm_fault(mm, vma, address, fla=
gs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault &amp; (VM_FAULT_RETRY|VM_FAU=
LT_ERROR))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fault &amp; VM_=
FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D mm_fault_err=
or(regs, address, fault);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc &gt;=3D MM_F=
AULT_RETURN)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto bail;<br>
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c<br>
index d95265b2..8e95432 100644<br>
--- a/arch/s390/mm/fault.c<br>
+++ b/arch/s390/mm/fault.c<br>
@@ -239,6 +239,12 @@ static noinline void do_fault_error(struct pt_regs *re=
gs, int fault)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_no_context(regs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pagefault_out_of_memory();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (fault &a=
mp; VM_FAULT_SIGSEGV) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Kernel mode? Handle exceptions or die */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!user_mode(regs))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_no_context(regs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_sigsegv(regs, SEGV_MAPERR);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (fault &a=
mp; VM_FAULT_SIGBUS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Kernel mode? Handle exceptions or die */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (!user_mode(regs))<br>
diff --git a/arch/score/mm/fault.c b/arch/score/mm/fault.c<br>
index 52238983..6860beb 100644<br>
--- a/arch/score/mm/fault.c<br>
+++ b/arch/score/mm/fault.c<br>
@@ -114,6 +114,8 @@ good_area:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault &amp; VM_FAULT_ERROR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp=
; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto do_sigbus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();<br>
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c<br>
index 541dc61..a58fec9 100644<br>
--- a/arch/sh/mm/fault.c<br>
+++ b/arch/sh/mm/fault.c<br>
@@ -353,6 +353,8 @@ mm_fault_error(struct pt_regs *regs, unsigned long erro=
r_code,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 do_sigbus(regs, error_code, address);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bad_area(regs, error_code, address);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 BUG();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c<br>
index 59dbd46..163c787 100644<br>
--- a/arch/sparc/mm/fault_32.c<br>
+++ b/arch/sparc/mm/fault_32.c<br>
@@ -252,6 +252,8 @@ good_area:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault &amp; VM_FAULT_ERROR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp=
; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto do_sigbus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();<br>
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c<br>
index 45a413e..0d6de79 100644<br>
--- a/arch/sparc/mm/fault_64.c<br>
+++ b/arch/sparc/mm/fault_64.c<br>
@@ -448,6 +448,8 @@ good_area:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault &amp; VM_FAULT_ERROR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp=
; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto do_sigbus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();<br>
diff --git a/arch/tile/mm/fault.c b/arch/tile/mm/fault.c<br>
index 6c05712..c6d2a76 100644<br>
--- a/arch/tile/mm/fault.c<br>
+++ b/arch/tile/mm/fault.c<br>
@@ -444,6 +444,8 @@ good_area:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault &amp; VM_FAULT_ERROR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp=
; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto do_sigbus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();<br>
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c<br>
index 974b874..53b8320 100644<br>
--- a/arch/um/kernel/trap.c<br>
+++ b/arch/um/kernel/trap.c<br>
@@ -80,6 +80,8 @@ good_area:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault =
&amp; VM_FAULT_ERROR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (fault &amp; VM_FAULT_OOM) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0} else if (fault &amp; VM_FAULT_SIGSEGV) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 } else if (fault &amp; VM_FAULT_SIGBUS) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EACCES;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c<br>
index 6dea040..3b5a244 100644<br>
--- a/arch/x86/mm/fault.c<br>
+++ b/arch/x86/mm/fault.c<br>
@@ -894,6 +894,8 @@ mm_fault_error(struct pt_regs *regs, unsigned long erro=
r_code,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; (VM=
_FAULT_SIGBUS|VM_FAULT_HWPOISON|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VM_FAULT_HWPOISON_LARGE))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 do_sigbus(regs, error_code, address, fault);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bad_area_nosemaphore(regs, error_code, address);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 BUG();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c<br>
index 70fa7bc..3827833 100644<br>
--- a/arch/xtensa/mm/fault.c<br>
+++ b/arch/xtensa/mm/fault.c<br>
@@ -117,6 +117,8 @@ good_area:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(fault &amp; VM_FAULT_ERROR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fault &amp; VM_=
FAULT_OOM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_of_memory;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fault &amp=
; VM_FAULT_SIGSEGV)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto bad_area;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (fault &amp=
; VM_FAULT_SIGBUS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto do_sigbus;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();<br>
diff --git a/drivers/staging/lustre/lustre/llite/vvp_io.c b/drivers/staging=
/lustre/lustre/llite/vvp_io.c<br>
index 3ff664c..37b14f3 100644<br>
--- a/drivers/staging/lustre/lustre/llite/vvp_io.c<br>
+++ b/drivers/staging/lustre/lustre/llite/vvp_io.c<br>
@@ -601,7 +601,7 @@ static int vvp_io_kernel_fault(struct vvp_fault_io *cfi=
o)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cfio-&gt;fault.ft_flags &amp; VM_FAULT_SIGB=
US) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cfio-&gt;fault.ft_flags &amp; (VM_FAULT_SIG=
BUS | VM_FAULT_SIGSEGV)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CDEBUG(D_PAGE, &quo=
t;got addr %p - SIGBUS\n&quot;, vmf-&gt;virtual_address);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
diff --git a/include/linux/mm.h b/include/linux/mm.h<br>
index c61755d..bc205d8 100644<br>
--- a/include/linux/mm.h<br>
+++ b/include/linux/mm.h<br>
@@ -972,6 +972,7 @@ static inline int page_mapped(struct page *page)<br>
=C2=A0#define VM_FAULT_WRITE 0x0008=C2=A0 /* Special case for get_user_page=
s */<br>
=C2=A0#define VM_FAULT_HWPOISON 0x0010=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Hit poi=
soned small page */<br>
=C2=A0#define VM_FAULT_HWPOISON_LARGE 0x0020=C2=A0 /* Hit poisoned large pa=
ge. Index encoded in upper bits */<br>
+#define VM_FAULT_SIGSEGV 0x0040<br>
<br>
=C2=A0#define VM_FAULT_NOPAGE=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0100=C2=A0 /* -&=
gt;fault installed the pte, not return page */<br>
=C2=A0#define VM_FAULT_LOCKED=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0200=C2=A0 /* -&=
gt;fault locked the returned page */<br>
@@ -980,8 +981,9 @@ static inline int page_mapped(struct page *page)<br>
<br>
=C2=A0#define VM_FAULT_HWPOISON_LARGE_MASK 0xf000 /* encodes hpage index fo=
r large hwpoison */<br>
<br>
-#define VM_FAULT_ERROR (VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_HWPOISON=
 | \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 VM_FAULT_FALLBACK | VM_FAULT_HWPOISON_LARGE)<br>
+#define VM_FAULT_ERROR (VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV =
| \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE | \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 VM_FAULT_FALLBACK)<br>
<br>
=C2=A0/* Encode hstate index for a hwpoisoned large page */<br>
=C2=A0#define VM_FAULT_SET_HINDEX(x) ((x) &lt;&lt; 12)<br>
diff --git a/mm/ksm.c b/mm/ksm.c<br>
index 418b8ca..813a1d9 100644<br>
--- a/mm/ksm.c<br>
+++ b/mm/ksm.c<br>
@@ -376,7 +376,7 @@ static int break_ksm(struct vm_area_struct *vma, unsign=
ed long addr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ret =3D VM_FAULT_WRITE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 put_page(page);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} while (!(ret &amp; (VM_FAULT_WRITE | VM_FAULT=
_SIGBUS | VM_FAULT_OOM)));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} while (!(ret &amp; (VM_FAULT_WRITE | VM_FAULT=
_SIGBUS | VM_FAULT_SIGSEGV | VM_FAULT_OOM)));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We must loop because handle_mm_fault() =
may back out if there&#39;s<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* any difficulty e.g. if pte accessed bit=
 gets updated concurrently.<br>
--<br>
1.9.1<br>
<br>
</blockquote></div>

--047d7b343c9ccd8f7a05119c70ac--


--===============9168260018463446576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9168260018463446576==--
