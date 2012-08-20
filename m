From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 21/31] arm64: 32-bit (compat) applications support
Date: Mon, 20 Aug 2012 12:53:08 +0200
Message-ID: <20120820105308.GA906@elf.ucw.cz>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-22-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52685 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab2HTKxK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Aug 2012 06:53:10 -0400
Content-Disposition: inline
In-Reply-To: <1344966752-16102-22-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>

Hi!

> This patch adds support for 32-bit applications. The vectors page is a
> binary blob mapped into the application user space at 0xffff0000 (the
> AArch64 toolchain does not support compilation of AArch32 code). Full
> compatibility with ARMv7 user space is supported. The use of deprecated
> ARMv7 functionality (SWP, CP15 barriers) has been disabled by default on
> AArch64 kernels and unaligned LDM/STM is not supported.
> 
> Please note that only the ARM 32-bit EABI is supported, so no OABI
> compatibility.

> +struct compat_statfs {
> +	int		f_type;
> +	int		f_bsize;
> +	int		f_blocks;
> +	int		f_bfree;
> +	int		f_bavail;
> +	int		f_files;
> +	int		f_ffree;
> +	compat_fsid_t	f_fsid;
> +	int		f_namelen;	/* SunOS ignores this field. */

I'm sure it does. But is it good comment?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
