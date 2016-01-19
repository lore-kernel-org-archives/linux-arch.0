Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35221 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932579AbcASSI4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2016 13:08:56 -0500
Received: by mail-pf0-f179.google.com with SMTP id 65so179161774pff.2
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2016 10:08:56 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v4 0/8] introduce post-init read-only memory
Date: Tue, 19 Jan 2016 10:08:34 -0800
Message-ID: <1453226922-16831-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, Mathias Krause <minipli@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, PaX Team <pageexec@freemail.hu>, Emese Revfy <re.emese@gmail.com>, kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20160119180834.Y2lLweJmUFi5L5xLsOC-07obF6Z2wSUSIZgszNzD_8M@z>

One of the easiest ways to protect the kernel from attack is to reduce
the internal attack surface exposed when a "write" flaw is available. By
making as much of the kernel read-only as possible, we reduce the
attack surface.

Many things are written to only during __init, and never changed
again. These cannot be made "const" since the compiler will do the wrong
thing (we do actually need to write to them). Instead, move these items
into a memory region that will be made read-only during mark_rodata_ro()
which happens after all kernel __init code has finished.

This introduces __ro_after_init as a way to mark such memory, and uses
it on the x86 vDSO to kill an extant kernel exploitation method. Also
adds a new kernel parameter to help debug future use and adds an lkdtm
test to check the results.

-Kees

v4:
- rebased
v3:
- conslidated mark_rodata_ro()
- make CONFIG_DEBUG_RODATA always enabled on x86, mingo
- enhanced strtobool and potential callers to use "on"/"off"
- use strtobool for rodata= param, gregkh
v2:
- renamed __read_only to __ro_after_init

