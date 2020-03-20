Return-Path: <SRS0=zDlA=5F=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39471 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCTXPi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 19:15:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so4062989pfn.6
        for <linux-arch@vger.kernel.org>; Fri, 20 Mar 2020 16:15:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200320145351.32292-27-vincenzo.frascino@arm.com>
References: <20200320145351.32292-1-vincenzo.frascino@arm.com> <20200320145351.32292-27-vincenzo.frascino@arm.com>
Subject: Re: [PATCH v5 26/26] arm64: vdso32: Enable Clang Compilation
From: Stephen Boyd <swboyd@chromium.org>
Date: Fri, 20 Mar 2020 16:15:35 -0700
Message-ID: <158474613590.125146.6442368806113128893@swboyd.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, x86@kernel.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Nathan Chancellor <natechancellor@gmail.com>
Message-ID: <20200320231535.tPt0u51uGSIk5uEefTlSaH_Srrea9m6F1c05l-H87Iw@z>

Quoting Vincenzo Frascino (2020-03-20 07:53:51)
> Enable Clang Compilation for the vdso32 library.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---

Tested-by: Stephen Boyd <swboyd@chromium.org>
