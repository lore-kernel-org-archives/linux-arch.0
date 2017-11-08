From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 0/3] bug: Fix "cut here" location for __WARN_TAINT
Date: Tue,  7 Nov 2017 16:27:46 -0800
Message-ID: <1510100869-73751-1-git-send-email-keescook@chromium.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f47.google.com ([209.85.160.47]:45673 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756787AbdKHA17 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Nov 2017 19:27:59 -0500
Received: by mail-pl0-f47.google.com with SMTP id 30so139492pla.2
        for <linux-arch@vger.kernel.org>; Tue, 07 Nov 2017 16:27:59 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Joe Perches <joe@perches.com>, Fengguang Wu <fengguang.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-am33-list@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Quoting the last patch in the series:

Prior to v4.11, x86 used warn_slowpath_fmt() for handling WARN()s. After
WARN() was moved to using UD0 on x86, the warning text started appearing
_before_ the "cut here" line. This appears to have been a long-standing
bug on architectures that used __WARN_TAINT, but it didn't get fixed.

v4.11 and earlier on x86:

[    7.944142] ------------[ cut here ]------------
[    7.945631] WARNING: CPU: 0 PID: 2956 at drivers/misc/lkdtm_bugs.c:65 lkdtm_WARNING+0x21/0x30
[    7.947453] This is a warning message
[    7.948357] Modules linked in:

v4.12 and later on x86:

[    8.973063] This is a warning message
[    8.973885] ------------[ cut here ]------------
[    8.974867] WARNING: CPU: 1 PID: 2982 at drivers/misc/lkdtm_bugs.c:68 lkdtm_WARNING+0x15/0x20
[    8.976563] Modules linked in:

With this fix:

[    9.157133] ------------[ cut here ]------------
[    9.158143] This is a warning message
[    9.159099] WARNING: CPU: 3 PID: 3009 at drivers/misc/lkdtm_bugs.c:67 lkdtm_WARNING+0x15/0x20

Since the __FILE__ reporting happens as part of the UD0 handler, it isn't
trivial to move the message to after the WARNING line, but at least we can
fix the position of the "cut here" line so all the various logging tools
will start including the actual runtime warning message again, when they
follow the instruction and "cut here".

Fixes: 9a93848fe787 ("x86/debug: Implement __WARN() using UD0")

Thanks!

-Kees
