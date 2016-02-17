From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v5 0/7] introduce post-init read-only memory
Date: Wed, 17 Feb 2016 14:41:11 -0800
Message-ID: <1455748879-21872-1-git-send-email-keescook@chromium.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33113 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423956AbcBQWlx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Feb 2016 17:41:53 -0500
Received: by mail-pa0-f48.google.com with SMTP id fl4so18733964pad.0
        for <linux-arch@vger.kernel.org>; Wed, 17 Feb 2016 14:41:53 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, David Brown <david.brown@linaro.org>, Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, Mathias Krause <minipli@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, PaX Team <pageexec@freemail.hu>, Emese Revfy <re.emese@gmail.com>, kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>

One of the easiest ways to protect the kernel from attack is to reduce
the internal attack surface exposed when a "write" flaw is available. By
making as much of the kernel read-only as possible, we reduce the
attack surface.

Many things are written to only during __init, and never changed
again. These cannot be made "const" since the compiler will do the wrong
thing (we do actually need to write to them). Instead, move these items
into a memory region that will be made read-only during mark_rodata_ro()
which happens after all kernel __init code has finished.

This introduces __ro_after_init as a way to mark such memory, and uses it
on the x86 and arm vDSO to kill an extant kernel exploitation method. Also
adds a new kernel parameter to help debug future use and adds an lkdtm
test to check the results.

-Kees

v5:
- rebased on linux-next (strtobool in -next, x86 vdso merge fixup)
- added ARM vDSO patch, david.brown
v4:
- adjust documentation for strtobool, andy.shevchenko
v3:
- conslidated mark_rodata_ro()
- make CONFIG_DEBUG_RODATA always enabled on x86, mingo
- enhanced strtobool and potential callers to use "on"/"off"
- use strtobool for rodata= param, gregkh
v2:
- renamed __read_only to __ro_after_init
