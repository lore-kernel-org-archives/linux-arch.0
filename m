Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43802 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfEaTvR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 15:51:17 -0400
MIME-Version: 1.0
References: <20190531191204.4044-1-palmer@sifive.com> <20190531191204.4044-3-palmer@sifive.com>
In-Reply-To: <20190531191204.4044-3-palmer@sifive.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 31 May 2019 21:51:00 +0200
Message-ID: <CAK8P3a3HPeVq29k3Zk5rSk4bddiUQFrdEgDZUgdNnYZK+8QpGw@mail.gmail.com>
Subject: Re: [PATCH 2/5] Add fchmodat4(), a new syscall
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <20190531195100._J7sqKM9_YmHp5QyEFK2VEDWQ4tJKGIzEADML7NhCkA@z>

On Fri, May 31, 2019 at 9:23 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> man 3p says that fchmodat() takes a flags argument, but the Linux
> syscall does not.  There doesn't appear to be a good userspace
> workaround for this issue but the implementation in the kernel is pretty
> straight-forward.  The specific use case where the missing flags came up
> was WRT a fuse filesystem implemenation, but the functionality is pretty
> generic so I'm assuming there would be other use cases.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  fs/open.c                | 21 +++++++++++++++++++--
>  include/linux/syscalls.h |  5 +++++
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/fs/open.c b/fs/open.c
> index a00350018a47..cfad7684e8d3 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -568,11 +568,17 @@ SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
>         return ksys_fchmod(fd, mode);
>  }
>
> -int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
> +int do_fchmodat4(int dfd, const char __user *filename, umode_t mode, int flags)
...
> +
> +int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
> +{
> +       return do_fchmodat4(dfd, filename, mode, 0);
> +}
> +

There is only one external caller of do_fchmodat(), so just change that
to pass the extra argument here, and keep a single do_fchmodat()
function used by the sys_fchmod(), sys_fchmod4(), sys_chmod()
and ksys_chmod().

        Arnd
