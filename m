From: YunQiang Su <syq-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] binfmt_misc: pass binfmt_misc flags to the interpreter
Date: Sun, 1 Mar 2020 08:47:23 +0800
Message-ID: <CAKcpw6W8_a3LPMPTph1asU3dCfjXk-xh5_7+MCEFicwTph+EKg@mail.gmail.com>
References: <20200128132539.782286-1-laurent@vivier.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200128132539.782286-1-laurent-Rq8OgNgcdU6HXe+LvDLADg@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Vivier <laurent-Rq8OgNgcdU6HXe+LvDLADg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, James Bottomley <James.Bottomley-JuX6DAaQMKPCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>, libc-alpha-9JcytcrH/bA+uJoB2kUjGw@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Laurent Vivier <laurent-Rq8OgNgcdU6HXe+LvDLADg@public.gmane.org> 于2020年1月28日周二 下午9:25写道：
>
> It can be useful to the interpreter to know which flags are in use.
>
> For instance, knowing if the preserve-argv[0] is in use would
> allow to skip the pathname argument.
>
> This patch uses an unused auxiliary vector, AT_FLAGS, to add a
> flag to inform interpreter if the preserve-argv[0] is enabled.
>

I am suggested to post linux-arch and/or linux-api.

> Signed-off-by: Laurent Vivier <laurent-Rq8OgNgcdU6HXe+LvDLADg@public.gmane.org>
> ---
>
> Notes:
>     This can be tested with QEMU from my branch:
>
>       https://github.com/vivier/qemu/commits/binfmt-argv0
>
>     With something like:
>
>       # cp ..../qemu-ppc /chroot/powerpc/jessie
>
>       # qemu-binfmt-conf.sh --qemu-path / --systemd ppc --credential yes \
>                             --persistent no --preserve-argv0 yes
>       # systemctl restart systemd-binfmt.service
>       # cat /proc/sys/fs/binfmt_misc/qemu-ppc
>       enabled
>       interpreter //qemu-ppc
>       flags: POC
>       offset 0
>       magic 7f454c4601020100000000000000000000020014
>       mask ffffffffffffff00fffffffffffffffffffeffff
>       # chroot /chroot/powerpc/jessie  sh -c 'echo $0'
>       sh
>
>       # qemu-binfmt-conf.sh --qemu-path / --systemd ppc --credential yes \
>                             --persistent no --preserve-argv0 no
>       # systemctl restart systemd-binfmt.service
>       # cat /proc/sys/fs/binfmt_misc/qemu-ppc
>       enabled
>       interpreter //qemu-ppc
>       flags: OC
>       offset 0
>       magic 7f454c4601020100000000000000000000020014
>       mask ffffffffffffff00fffffffffffffffffffeffff
>       # chroot /chroot/powerpc/jessie  sh -c 'echo $0'
>       /bin/sh
>
>     v3: mix my patch with one from YunQiang Su and my comments on it
>         introduce a new flag in the uabi for the AT_FLAGS
>     v2: only pass special flags (remove Magic and Enabled flags)
>
>  fs/binfmt_elf.c              | 5 ++++-
>  fs/binfmt_elf_fdpic.c        | 5 ++++-
>  fs/binfmt_misc.c             | 4 +++-
>  include/linux/binfmts.h      | 4 ++++
>  include/uapi/linux/binfmts.h | 4 ++++
>  5 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index ecd8d2698515..ff918042ceed 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -176,6 +176,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
>         unsigned char k_rand_bytes[16];
>         int items;
>         elf_addr_t *elf_info;
> +       elf_addr_t flags = 0;
>         int ei_index = 0;
>         const struct cred *cred = current_cred();
>         struct vm_area_struct *vma;
> @@ -250,7 +251,9 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
>         NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
>         NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
>         NEW_AUX_ENT(AT_BASE, interp_load_addr);
> -       NEW_AUX_ENT(AT_FLAGS, 0);
> +       if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
> +               flags |= AT_FLAGS_PRESERVE_ARGV0;
> +       NEW_AUX_ENT(AT_FLAGS, flags);
>         NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
>         NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
>         NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 240f66663543..abb90d82aa58 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -507,6 +507,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>         char __user *u_platform, *u_base_platform, *p;
>         int loop;
>         int nr; /* reset for each csp adjustment */
> +       unsigned long flags = 0;
>
>  #ifdef CONFIG_MMU
>         /* In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
> @@ -647,7 +648,9 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>         NEW_AUX_ENT(AT_PHENT,   sizeof(struct elf_phdr));
>         NEW_AUX_ENT(AT_PHNUM,   exec_params->hdr.e_phnum);
>         NEW_AUX_ENT(AT_BASE,    interp_params->elfhdr_addr);
> -       NEW_AUX_ENT(AT_FLAGS,   0);
> +       if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
> +               flags |= AT_FLAGS_PRESERVE_ARGV0;
> +       NEW_AUX_ENT(AT_FLAGS,   flags);
>         NEW_AUX_ENT(AT_ENTRY,   exec_params->entry_addr);
>         NEW_AUX_ENT(AT_UID,     (elf_addr_t) from_kuid_munged(cred->user_ns, cred->uid));
>         NEW_AUX_ENT(AT_EUID,    (elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index cdb45829354d..b9acdd26a654 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -154,7 +154,9 @@ static int load_misc_binary(struct linux_binprm *bprm)
>         if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
>                 goto ret;
>
> -       if (!(fmt->flags & MISC_FMT_PRESERVE_ARGV0)) {
> +       if (fmt->flags & MISC_FMT_PRESERVE_ARGV0) {
> +               bprm->interp_flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
> +       } else {
>                 retval = remove_arg_zero(bprm);
>                 if (retval)
>                         goto ret;
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index b40fc633f3be..265b80d5fd6f 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -78,6 +78,10 @@ struct linux_binprm {
>  #define BINPRM_FLAGS_PATH_INACCESSIBLE_BIT 2
>  #define BINPRM_FLAGS_PATH_INACCESSIBLE (1 << BINPRM_FLAGS_PATH_INACCESSIBLE_BIT)
>
> +/* if preserve the argv0 for the interpreter  */
> +#define BINPRM_FLAGS_PRESERVE_ARGV0_BIT 3
> +#define BINPRM_FLAGS_PRESERVE_ARGV0 (1 << BINPRM_FLAGS_PRESERVE_ARGV0_BIT)
> +
>  /* Function parameter for binfmt->coredump */
>  struct coredump_params {
>         const kernel_siginfo_t *siginfo;
> diff --git a/include/uapi/linux/binfmts.h b/include/uapi/linux/binfmts.h
> index 689025d9c185..a70747416130 100644
> --- a/include/uapi/linux/binfmts.h
> +++ b/include/uapi/linux/binfmts.h
> @@ -18,4 +18,8 @@ struct pt_regs;
>  /* sizeof(linux_binprm->buf) */
>  #define BINPRM_BUF_SIZE 256
>
> +/* if preserve the argv0 for the interpreter  */
> +#define AT_FLAGS_PRESERVE_ARGV0_BIT 0
> +#define AT_FLAGS_PRESERVE_ARGV0 (1 << AT_FLAGS_PRESERVE_ARGV0_BIT)
> +
>  #endif /* _UAPI_LINUX_BINFMTS_H */
> --
> 2.24.1
>
