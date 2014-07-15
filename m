From: Lennox Wu <lennox.wu@gmail.com>
Subject: Re: [PATCH 04/38] score: drop irrelevant assignment from Kbuild file
Date: Tue, 15 Jul 2014 21:57:24 +0800
Message-ID: <CAF0htA7-_50ctd9PwpGiWNVMjehomaOh1UK2f9zgwW7T+40NDg@mail.gmail.com>
References: <20140714150609.GA28358@ravnborg.org>
	<1405350546-28467-1-git-send-email-sam@ravnborg.org>
	<1405350546-28467-4-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405350546-28467-4-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Arnd Bergmann <arnd@arndb.de>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Chen Liqin <liqin.linux@gmail.com>, David Howells <dhowells@redhat.com>
List-Id: linux-arch.vger.kernel.org

Thanks :)

Acked-by: Lennox Wu<lennox.wu@gmail.com>


2014-07-14 23:08 GMT+08:00 Sam Ravnborg <sam@ravnborg.org>:
> header-y assignemnt in this file has no effect - drop it.
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Chen Liqin <liqin.linux@gmail.com>
> Cc: Lennox Wu <lennox.wu@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> ---
>  arch/score/include/asm/Kbuild | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/score/include/asm/Kbuild b/arch/score/include/asm/Kbuild
> index 2f947ab..f67b3f6 100644
> --- a/arch/score/include/asm/Kbuild
> +++ b/arch/score/include/asm/Kbuild
> @@ -1,7 +1,4 @@
>
> -header-y +=
> -
> -
>  generic-y += barrier.h
>  generic-y += clkdev.h
>  generic-y += cputime.h
> --
> 1.9.3
>
