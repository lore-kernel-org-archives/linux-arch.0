From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 4/7] mips: Use lib/{ashldi3,ashrdi3,cmpdi2,lshrdi3,ucmpdi2}.c
Date: Fri, 02 Jun 2017 19:18:08 -0700 (PDT)
Message-ID: <mhng-fc1d65cf-1943-4c73-8fae-b13ee8349d2f@palmer-si-x1c4>
References: <a870bfb8-a1c8-220e-460c-baa03b3fd554@imgtec.com>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36395 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdFCCSK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jun 2017 22:18:10 -0400
Received: by mail-pf0-f194.google.com with SMTP id n23so14318036pfb.3
        for <linux-arch@vger.kernel.org>; Fri, 02 Jun 2017 19:18:09 -0700 (PDT)
In-Reply-To: <a870bfb8-a1c8-220e-460c-baa03b3fd554@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: matt.redfearn@imgtec.com
Cc: monstr@monstr.eu, ralf@linux-mips.org, liqin.linux@gmail.com, lennox.wu@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, 24 May 2017 02:01:39 PDT (-0700), matt.redfearn@imgtec.com wrote:
> Hi Palmer,
> This patch doesn't quite match the subject, since it only removes the
> mips specific implementation of __ucmpdi2. The following patch removes
> all of the intrinsics that you added to lib/ from arch/mips/lib. I've
> built & boot tested this on a MIPS pistachio platform.
> Note that this patch will require rebasing on linux-next, since it will
> conflict with other changes in arch/mips/Kconfig
>
> Thanks,
> Matt
>
> [PATCH] MIPS: Use generic libgcc intrinsics
>
> These routines in arch/mips/lib/ are functionally identical to those
> recently added to lib/ so remove them and select the generic ones.
>
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
>   arch/mips/Kconfig       |  5 +++++
>   arch/mips/lib/Makefile  |  2 +-
>   arch/mips/lib/ashldi3.c | 29 -----------------------------
>   arch/mips/lib/ashrdi3.c | 31 -------------------------------
>   arch/mips/lib/cmpdi2.c  | 27 ---------------------------
>   arch/mips/lib/libgcc.h  | 25 -------------------------
>   arch/mips/lib/lshrdi3.c | 29 -----------------------------
>   arch/mips/lib/ucmpdi2.c | 21 ---------------------
>   8 files changed, 6 insertions(+), 163 deletions(-)
>   delete mode 100644 arch/mips/lib/ashldi3.c
>   delete mode 100644 arch/mips/lib/ashrdi3.c
>   delete mode 100644 arch/mips/lib/cmpdi2.c
>   delete mode 100644 arch/mips/lib/libgcc.h
>   delete mode 100644 arch/mips/lib/lshrdi3.c
>   delete mode 100644 arch/mips/lib/ucmpdi2.c

Sorry about that, I'll take your version and submit a v2.
