From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 1/7] asm-generic: consolidate mark_rodata_ro()
Date: Fri, 19 Feb 2016 14:38:36 +0000
Message-ID: <20160219143836.GK27062@arm.com>
References: <1455748879-21872-1-git-send-email-keescook@chromium.org>
 <1455748879-21872-2-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46460 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964960AbcBSOib (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Feb 2016 09:38:31 -0500
Content-Disposition: inline
In-Reply-To: <1455748879-21872-2-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, David Brown <david.brown@linaro.org>, Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, Mathias Krause <minipli@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, PaX Team <pageexec@freemail.hu>, Emese Revfy <re.emese@gmail.com>, kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>

On Wed, Feb 17, 2016 at 02:41:12PM -0800, Kees Cook wrote:
> Instead of defining mark_rodata_ro() in each architecture, consolidate it.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
> ---
>  arch/arm/include/asm/cacheflush.h    | 1 -
>  arch/arm64/include/asm/cacheflush.h  | 4 ----
>  arch/parisc/include/asm/cacheflush.h | 4 ----
>  arch/x86/include/asm/cacheflush.h    | 1 -
>  include/linux/init.h                 | 4 ++++
>  5 files changed, 4 insertions(+), 10 deletions(-)

If you need it:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
