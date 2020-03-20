Return-Path: <SRS0=zDlA=5F=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:51478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgCTP0J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Mar 2020 11:26:09 -0400
Date: Fri, 20 Mar 2020 15:26:02 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v5 18/26] arm64: vdso32: Code clean up
Message-ID: <20200320152602.GA7448@mbp>
References: <20200320145351.32292-1-vincenzo.frascino@arm.com>
 <20200320145351.32292-19-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320145351.32292-19-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, linux-mips@vger.kernel.org, x86@kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>
Message-ID: <20200320152602.-6pxU3fa0-pS5rZ-2SmDfkMrim1JD0melLkAn5GcWOo@z>

On Fri, Mar 20, 2020 at 02:53:43PM +0000, Vincenzo Frascino wrote:
> The compat vdso library had some checks that are not anymore relevant.
> 
> Remove the unused code from the compat vDSO library.
> 
> Note: This patch is preparatory for a future one that will introduce
> asm/vdso/processor.h on arm64.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Link: https://lore.kernel.org/lkml/20200317122220.30393-19-vincenzo.frascino@arm.com

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
