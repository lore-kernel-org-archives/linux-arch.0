Return-Path: <SRS0=zDlA=5F=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53647 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgCTXVI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 19:21:08 -0400
Received: by mail-pj1-f65.google.com with SMTP id l36so3164607pjb.3
        for <linux-arch@vger.kernel.org>; Fri, 20 Mar 2020 16:21:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200320145351.32292-19-vincenzo.frascino@arm.com>
References: <20200320145351.32292-1-vincenzo.frascino@arm.com> <20200320145351.32292-19-vincenzo.frascino@arm.com>
Subject: Re: [PATCH v5 18/26] arm64: vdso32: Code clean up
From: Stephen Boyd <swboyd@chromium.org>
Date: Fri, 20 Mar 2020 16:21:06 -0700
Message-ID: <158474646622.125146.3263940499372231797@swboyd.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, x86@kernel.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>
Message-ID: <20200320232106.9ycDUCWWHxqkjMGuOLewMS8jyKyQv9hDda06QTQk7mE@z>

Quoting Vincenzo Frascino (2020-03-20 07:53:43)
> The compat vdso library had some checks that are not anymore relevant.

Can we get the information on why they aren't relevant anymore in the
commit text? I'd rather not find this commit three years from now and
have no idea why it was applied.

>=20
> Remove the unused code from the compat vDSO library.
>=20
> Note: This patch is preparatory for a future one that will introduce
> asm/vdso/processor.h on arm64.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Link: https://lore.kernel.org/lkml/20200317122220.30393-19-vincenzo.frasc=
ino@arm.com
