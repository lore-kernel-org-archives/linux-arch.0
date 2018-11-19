From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/4] powerpc: add system call table generation support
Date: Mon, 19 Nov 2018 17:48:02 +0100
Message-ID: <CAK8P3a1jnuabJ+NFm-XAzQ8dk7V991H+YEfTZ2GZjNBovuAoDw@mail.gmail.com>
References: <1542189798-27713-1-git-send-email-firoz.khan@linaro.org> <1542189798-27713-4-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542189798-27713-4-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxram@us.ibm.com, Geert Uytterhoeven <geert@linux-m68k.org>, leitao@debian.org, Boqun Feng <boqun.feng@gmail.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 14, 2018 at 11:04 AM Firoz Khan <firoz.khan@linaro.org> wrote:

> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>         - Compat entry name, if required.
>
> syscallhdr.sh and syscalltbl.sh will generate uapi header-
> unistd_32/64.h and syscall_table_32/64/c32.h files respect-
> ively. File syscall_table_32/64/c32.h is included by sys-
> call.S - the real system call table. Both .sh files will
> parse the content syscall.tbl to generate the header and
> table files.

You don't mention how this handles the SPU, which seems to be the main
difference from the other architectures.

> +# The format is:
> +# <number> <abi> <name> <entry point> <compat entry point> <spu entry point>
> +#
> +# The <abi> can be common, 64, or 32 for this file.
> +#
> +0      common  restart_syscall                 sys_restart_syscall             sys_restart_syscall
> +1      common  exit                            sys_exit                        sys_exit
> +2      common  fork                            ppc_fork                        ppc_fork
> +3      common  read                            sys_read                        sys_read                                sys_read
> +4      common  write                           sys_write                       sys_write                               sys_write
> +5      common  open                            sys_open                        compat_sys_open                         sys_open
> +6      common  close                           sys_close                       sys_close                               sys_close
> +7      common  waitpid                         sys_waitpid                     sys_waitpid                             sys_waitpid
> +8      common  creat                           sys_creat                       sys_creat                               sys_creat

The SPU syscall is always the same as the 64-bit syscall, so listing it
explictily in the last column seems to add a lot of duplication, and
makes the format different from the other architectures.

Have you considered using the <abi> field (second column) to decide whether
a syscall is used for SPU or not instead?

I would have done it like

|+0      nospu  restart_syscall                 sys_restart_syscall
         sys_restart_syscall
|+1      nospu  exit                            sys_exit
         sys_exit
|+2      nospu  fork                            ppc_fork
         ppc_fork
|+3      common  read                            sys_read
          sys_read
|+4      common  write                           sys_write
          sys_write
|+5      common  open                            sys_open
          compat_sys_open
|+6      common  close                           sys_close
          sys_close
...
|+291    32      fstatat64                       sys_fstatat64
          sys_fstatat64
|+291    64      newfstatat                      sys_newfstatat
|+291    spu      newfstatat                      sys_newfstatat
...

with 'nospu' meaning 64+32+compat.

> +9      common  link                            sys_link                        sys_link                                sys_link
> +10     common  unlink                          sys_unlink                      sys_unlink                              sys_unlink
> +11     common  execve                          sys_execve                      compat_sys_execve
> +12     common  chdir                           sys_chdir                       sys_chdir                               sys_chdir
> +13     common  time                            sys_time                        compat_sys_time                         sys_time
> +14     common  mknod                           sys_mknod                       sys_mknod                               sys_mknod
> +15     common  chmod                           sys_chmod                       sys_chmod                               sys_chmod
> +16     common  lchown                          sys_lchown                      sys_lchown                              sys_lchown
> +17     common  break                           sys_ni_syscall                  sys_ni_syscall
> +18     32      oldstat                         sys_stat                        sys_ni_syscall
> +18     64      oldstat                         sys_ni_syscall

'oldstat' seems odd. Your conversion is correct, but the existing
behavior of not
providing support for the syscall in compat mode feels wrong. We have four
calls in this category:

arch/powerpc/include/asm/systbl.h:OLDSYS(stat)
arch/powerpc/include/asm/systbl.h:OLDSYS(fstat)
arch/powerpc/include/asm/systbl.h:OLDSYS(lstat)
arch/powerpc/include/asm/systbl.h:OLDSYS(debug_setcontext)

For the first three, it seems that the 64-bit kernel ought to set
'__ARCH_WANT_OLD_STAT':

diff --git a/arch/powerpc/include/asm/unistd.h
b/arch/powerpc/include/asm/unistd.h
index 96ddce5c76c3..335dfcc47f20 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -42,9 +42,7 @@
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
-#ifdef CONFIG_PPC32
 #define __ARCH_WANT_OLD_STAT
-#endif
 #ifdef CONFIG_PPC64
 #define __ARCH_WANT_SYS_TIME32
 #define __ARCH_WANT_SYS_UTIME32
diff --git a/arch/powerpc/include/uapi/asm/stat.h
b/arch/powerpc/include/uapi/asm/stat.h
index afd25f2ff4e8..f64e47b46e4b 100644
--- a/arch/powerpc/include/uapi/asm/stat.h
+++ b/arch/powerpc/include/uapi/asm/stat.h
@@ -11,7 +11,7 @@

 #define STAT_HAVE_NSEC 1

-#ifndef __powerpc64__
+#if !defined(__powerpc64__) || defined(__KERNEL__)
 struct __old_kernel_stat {
        unsigned short st_dev;
        unsigned short st_ino;

For debug_setcontext(), I don't even know what that does, or whether the
omission was intentional, but it seems weird to have one missing syscall
in the emulation.

> +19     common  lseek                           sys_lseek                       compat_sys_lseek                        sys_lseek
> +20     common  getpid                          sys_getpid                      sys_getpid                              sys_getpid
> +21     common  mount                           sys_mount                       compat_sys_mount
> +22     32      umount                          sys_oldumount                   sys_oldumount
> +22     64      umount                          sys_ni_syscall

Note: for a future cleanup, I suppose we want to remove the '64' line
for this one and
others that simply refer to sys_ni_syscall. Your version keeps the
generated file
unchanged, so that that's great for now.

> +31     common  stty                            sys_ni_syscall                  sys_ni_syscall
> +32     common  gtty                            sys_ni_syscall                  sys_ni_syscall

same here.

> +82     32      select                          ppc_select                      sys_ni_syscall
> +82     64      select                          sys_ni_syscall

This one again is like 'stat': it lacks a compat handler, which exists in
arch/powerpc/kernel/syscalls.c, but is disabled in ppc64/compat mode
for unknown reasons. In this case, it's been like that since the compat
mode was first added.

> +106    common  stat                            sys_newstat                     compat_sys_newstat                      sys_newstat
> +107    32      lstat                           sys_newlstat                    compat_sys_newlstat                     sys_newlstat
> +107    64      lstat                           sys_lstat
> +108    32      fstat                           sys_newfstat                    compat_sys_newfstat                     sys_newfstat
> +108    64      fstat                           sys_fstat

Can you explain what is going on here? As far as I can see, those
should all be 'common'.

       Arnd
