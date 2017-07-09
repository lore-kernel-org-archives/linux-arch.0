Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36570 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbdGIJF4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jul 2017 05:05:56 -0400
Date: Sun, 9 Jul 2017 11:05:51 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH] x86: enable dead code and data elimination (LTO)
Message-ID: <20170709090551.bm2c55ctt3togim7@gmail.com>
References: <20170709031333.29443-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170709031333.29443-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Paul Burton <paul.burton@imgtec.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20170709090551.chcwqijISwpgaERTk_RxS9XvITzYUIvdPfPTij0AgoA@z>


* Nicholas Piggin <npiggin@gmail.com> wrote:

> FYI, easiest way to check if you forgot to KEEP a linker table is
> to look at `readelf -S vmlinux` differences, and to see what is
> being trimmed, look at nm differences or use --print-gc-sections
> LD option to see what symbols you're trimming. Linker tables,
> boot entry, and exception entry tends to require anchoring.

Could you please add a debug build target to display all discarded 
symbols/sections? Something like:

	make lto-check

... or so?

Thanks,

	Ingo
