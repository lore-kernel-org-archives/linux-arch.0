From: Lennox Wu <lennox.wu@gmail.com>
Subject: Re: [PATCH 31/38] score: clean-up uapi Kbuild file
Date: Fri, 18 Jul 2014 23:19:19 +0800
Message-ID: <CAF0htA4ZWAfvUdu6HvrAZc1-D2cwWZ8v9dHcYQVS6p6UM9M7Uw@mail.gmail.com>
References: <20140714150609.GA28358@ravnborg.org>
	<1405350546-28467-1-git-send-email-sam@ravnborg.org>
	<1405350546-28467-31-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405350546-28467-31-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Chen Liqin <liqin.linux@gmail.com>
List-Id: linux-arch.vger.kernel.org

 Acked-by: Lennox Wu <lennox.wu@gamil.com>

2014-07-14 23:08 GMT+08:00 Sam Ravnborg <sam@ravnborg.org>:
> Remove redundant assignments.
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Chen Liqin <liqin.linux@gmail.com>
> Cc: Lennox Wu <lennox.wu@gmail.com>
> ---
>  arch/score/include/uapi/asm/Kbuild | 32 --------------------------------
>  1 file changed, 32 deletions(-)
>
> diff --git a/arch/score/include/uapi/asm/Kbuild b/arch/score/include/uapi/asm/Kbuild
> index 040178c..b15bf6b 100644
> --- a/arch/score/include/uapi/asm/Kbuild
> +++ b/arch/score/include/uapi/asm/Kbuild
> @@ -1,34 +1,2 @@
>  # UAPI Header export list
>  include include/uapi/asm-generic/Kbuild.asm
> -
> -header-y += auxvec.h
> -header-y += bitsperlong.h
> -header-y += byteorder.h
> -header-y += errno.h
> -header-y += fcntl.h
> -header-y += ioctl.h
> -header-y += ioctls.h
> -header-y += ipcbuf.h
> -header-y += kvm_para.h
> -header-y += mman.h
> -header-y += msgbuf.h
> -header-y += param.h
> -header-y += poll.h
> -header-y += posix_types.h
> -header-y += ptrace.h
> -header-y += resource.h
> -header-y += sembuf.h
> -header-y += setup.h
> -header-y += shmbuf.h
> -header-y += sigcontext.h
> -header-y += siginfo.h
> -header-y += signal.h
> -header-y += socket.h
> -header-y += sockios.h
> -header-y += stat.h
> -header-y += statfs.h
> -header-y += swab.h
> -header-y += termbits.h
> -header-y += termios.h
> -header-y += types.h
> -header-y += unistd.h
> --
> 1.9.3
>
