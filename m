Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34718 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfHSXlV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 19:41:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id d3so1733601plr.1
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 16:41:20 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 0/7] Clean up WARN() "cut here" handling
Date: Mon, 19 Aug 2019 16:41:04 -0700
Message-ID: <20190819234111.9019-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Drew Davenport <ddavenport@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190819234104.OzPZsSAUc651q5clvBhaPWkbgeBYbqCKQd6b6D4FGz8@z>

Christophe Leroy noticed that the fix for missing "cut here" in the
WARN() case was adding explicit printk() calls instead of teaching the
exception handler to add it. This refactors the bug/warn infrastructure
to pass this information as a new BUGFLAG.

Longer details repeated from the last patch in the series:


bug: Move WARN_ON() "cut here" into exception handler

The original clean up of "cut here" missed the WARN_ON() case (that
does not have a printk message), which was fixed recently by adding
an explicit printk of "cut here". This had the downside of adding a
printk() to every WARN_ON() caller, which reduces the utility of using
an instruction exception to streamline the resulting code. By making
this a new BUGFLAG, all of these can be removed and "cut here" can be
handled by the exception handler.

This was very pronounced on PowerPC, but the effect can be seen on
x86 as well. The resulting text size of a defconfig build shows some
small savings from this patch:

   text    data     bss     dec     hex filename
19691167        5134320 1646664 26472151        193eed7 vmlinux.before
19676362        5134260 1663048 26473670        193f4c6 vmlinux.after

This change also opens the door for creating something like BUG_MSG(),
where a custom printk() before issuing BUG(), without confusing the "cut
here" line.

Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: Fixes: 6b15f678fb7d ("include/asm-generic/bug.h: fix "cut here" for WARN_ON for __WARN_TAINT architectures")
Signed-off-by: Kees Cook <keescook@chromium.org>


-Kees

Kees Cook (7):
  bug: Refactor away warn_slowpath_fmt_taint()
  bug: Rename __WARN_printf_taint() to __WARN_printf()
  bug: Consolidate warn_slowpath_fmt() usage
  bug: Lift "cut here" out of __warn()
  bug: Clean up helper macros to remove __WARN_TAINT()
  bug: Consolidate __WARN_FLAGS usage
  bug: Move WARN_ON() "cut here" into exception handler

 include/asm-generic/bug.h | 53 ++++++++++++++++-----------------------
 kernel/panic.c            | 34 ++++++++-----------------
 lib/bug.c                 | 11 ++++++--
 3 files changed, 40 insertions(+), 58 deletions(-)

-- 
2.17.1
