Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.outflux.net ([198.145.64.163]:43258 "EHLO smtp.outflux.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753703AbbLIVoV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 9 Dec 2015 16:44:21 -0500
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 0/8] introduce post-init read-only memory
Date: Wed,  9 Dec 2015 13:43:16 -0800
Message-ID: <1449697404-21076-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, Mathias Krause <minipli@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, PaX Team <pageexec@freemail.hu>, Emese Revfy <re.emese@gmail.com>, kernel-hardening@lists.openwall.com, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20151209214316.PIKY5_pITJjM_BMEcbJZy7JCKCRU7_U6D_A9wg5sPJ8@z>

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

v3:
- conslidated mark_rodata_ro()
- make CONFIG_DEBUG_RODATA always enabled on x86, mingo
- enhanced strtobool and potential callers to use "on"/"off"
- use strtobool for rodata= param, gregkh
v2:
- renamed __read_only to __ro_after_init

