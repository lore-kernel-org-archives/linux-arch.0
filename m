Return-Path: <SRS0=yjua=5B=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:44470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730025AbgCPJR6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Mar 2020 05:17:58 -0400
Date: Mon, 16 Mar 2020 09:17:47 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 26/26] arm64: vdso32: Enable Clang Compilation
Message-ID: <20200316091730.GB3005@mbp>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-27-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313154345.56760-27-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Will Deacon <will@kernel.org>, Nathan Chancellor <natechancellor@gmail.com>
Message-ID: <20200316091747.J_IK4fBy7AF34XmZ3ITM76CSQFIgaa0Dnt33y6ZKnJg@z>

On Fri, Mar 13, 2020 at 03:43:45PM +0000, Vincenzo Frascino wrote:
> Enable Clang Compilation for the vdso32 library.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
