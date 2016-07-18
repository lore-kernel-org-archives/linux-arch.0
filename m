From: Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH 0/2] arm/arm64: localise objcopy flags
Date: Mon, 18 Jul 2016 16:16:34 -0700
Message-ID: <a1441405-5a3a-731c-2693-b66cd42edc99@redhat.com>
References: <1468337282-14527-1-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33903 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbcGRXQj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 Jul 2016 19:16:39 -0400
Received: by mail-yw0-f171.google.com with SMTP id i12so1557804ywa.1
        for <linux-arch@vger.kernel.org>; Mon, 18 Jul 2016 16:16:38 -0700 (PDT)
In-Reply-To: <1468337282-14527-1-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, catalin.marinas@arm.com, keescook@chromium.org, linux@armlinux.org.uk, will.deacon@arm.com

On 07/12/2016 08:28 AM, Mark Rutland wrote:
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

Kees' lkdtm tests compile and boot successfully with this patch for
both arm and arm64 so you can add

Tested-by: Laura Abbott <labbott@redhat.com>

Thanks,
Laura
