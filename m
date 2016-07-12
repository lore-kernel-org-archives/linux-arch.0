From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/2] arm/arm64: localise objcopy flags
Date: Tue, 12 Jul 2016 13:03:27 -0400
Message-ID: <CAGXu5jLiZo18+=MDOUODVV2tJsV-okX5jtLNjG5tUs9A_3=Wpw@mail.gmail.com>
References: <1468337282-14527-1-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37079 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbcGLRDa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jul 2016 13:03:30 -0400
Received: by mail-wm0-f52.google.com with SMTP id i5so33611646wmg.0
        for <linux-arch@vger.kernel.org>; Tue, 12 Jul 2016 10:03:29 -0700 (PDT)
In-Reply-To: <1468337282-14527-1-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>

On Tue, Jul 12, 2016 at 11:28 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> Typically, architectures (including arm and arm64) define OBJCOPYFLAGS in their
> top-level makefile, for the purpose of generating a raw binaries suitable for
> booting, including Image, zImage, vmlinux.bin, etc.
>
> As this top-level arch makefile is included by the top-level kernel makefile,
> these flags are passed to other invocations of objcopy tree-wide. This can
> result in unexpected and inconsistent behaviour across architectures (e.g.
> generation of a raw binary rather than an ELF [1]).
>
> Rather than force each new user of objcopy to specially clear OBJCOPYFLAGS,
> this patch moves the existing OBJCOPYFLAGS variable definitions such that they
> only affects the cases we require them for today, leaving the global namespace
> clear.
>
> Other architectures will likely need similar treatment.

Oh excellent, thanks for doing this! I made an attempt at this back
when I ran into it with lkdtm, but I wasn't sure it was working as
intended. :)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

>
> Thanks,
> Mark.
>
> [1] http://www.openwall.com/lists/kernel-hardening/2016/06/08/2
>
> Mark Rutland (2):
>   arm64: localise Image objcopy flags
>   arm: localise objcopy flags
>
>  arch/arm/Makefile        | 1 -
>  arch/arm/boot/Makefile   | 2 ++
>  arch/arm64/Makefile      | 1 -
>  arch/arm64/boot/Makefile | 2 ++
>  4 files changed, 4 insertions(+), 2 deletions(-)
>
> --
> 1.9.1
>



-- 
Kees Cook
Chrome OS & Brillo Security
