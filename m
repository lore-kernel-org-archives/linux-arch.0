Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390930AbfHVW4N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Aug 2019 18:56:13 -0400
Date: Thu, 22 Aug 2019 15:56:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception
 handler
Message-ID: <20190822155611.a1a6e26db99ba0876ba9c8bd@linux-foundation.org>
In-Reply-To: <201908200943.601DD59DCE@keescook>
References: <201908200943.601DD59DCE@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 20190819234111.9019-8-keescook@chromium.org
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, Drew Davenport <ddavenport@chromium.org>, Arnd Bergmann <arnd@arndb.de>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190822225611.0Kb_8U6Flk_5ufasRfJzfMWExyygP8nr83WXRCu1p0o@z>

On Tue, 20 Aug 2019 09:47:55 -0700 Kees Cook <keescook@chromium.org> wrote:

> Reply-To: 20190819234111.9019-8-keescook@chromium.org

Really?

> Subject: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception handler

It's strange to receive a standalone [7/7] patch.

> Date:   Tue, 20 Aug 2019 09:47:55 -0700
> Sender: linux-kernel-owner@vger.kernel.org
> 
> The original clean up of "cut here" missed the WARN_ON() case (that
> does not have a printk message), which was fixed recently by adding
> an explicit printk of "cut here". This had the downside of adding a
> printk() to every WARN_ON() caller, which reduces the utility of using
> an instruction exception to streamline the resulting code. By making
> this a new BUGFLAG, all of these can be removed and "cut here" can be
> handled by the exception handler.
> 
> This was very pronounced on PowerPC, but the effect can be seen on
> x86 as well. The resulting text size of a defconfig build shows some
> small savings from this patch:
> 
>    text    data     bss     dec     hex filename
> 19691167        5134320 1646664 26472151        193eed7 vmlinux.before
> 19676362        5134260 1663048 26473670        193f4c6 vmlinux.after
> 
> This change also opens the door for creating something like BUG_MSG(),
> where a custom printk() before issuing BUG(), without confusing the "cut
> here" line.

I can't get this to apply to anything, so I guess that [1/7]-[6/7]
mattered ;)

> Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Fixes: Fixes: 6b15f678fb7d ("include/asm-generic/bug.h: fix "cut here" for WARN_ON for __WARN_TAINT architectures")

I'm seeing double.

> Signed-off-by: Kees Cook <keescook@chromium.org>
