From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip 0/4] Add section address checking helper
Date: Thu, 17 Aug 2017 16:12:48 +0900
Message-ID: <150295395797.14424.968407208436624832.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbdHQHNk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Aug 2017 03:13:40 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Thierry Reding <treding@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>

Hi,

This series adds some address checking helpers in sections.h
so that each one doesn't need to implement it individually.
This series contains basically cleanup patches. Each patch
replaces some checking code with helper function but changes
no behavior.

 - [1/4]: x86: add in_entry_text() helper to cleanup kprobes
	  and unwind_frame code.
 - [2/4]: arm: move in_exception_text() to asm/sections.h and
	  cleanup using memory_contains().
 - [3/4]: arm64: move in_exception_text() to asm/sections.h and
	  cleanup using memory_contains().
 - [4/4]: add in_init_text() and in_core_text() and use it in
	  kernel/extable.c and kernel/kallsyms.c, also this
	  cleanup core_kernel_data using memory_contains().

By the way, I found core_kernel_text() and is_kernel_text()
has different behavior, is_kernel_text() checks arch dependent
text area and in_gate_area_no_mm(), but core_kernel_text()
doesn't. (and core_kernel_text() checks inittext section
while booting up)
Can we ignore this difference or better to merge it?

Thank you,
---

Masami Hiramatsu (4):
      x86: Add in_entry_text() helper function
      arm: Cleanup in_exception_text() and move it in asm/sections.h
      arm64: Cleanup in_exception_text() and move it in asm/sections.h
      extable: kallsyms: Add in_init_text() and in_core_text() helper


 arch/arm/include/asm/sections.h   |   17 +++++++++++++++++
 arch/arm/include/asm/traps.h      |   22 +---------------------
 arch/arm64/include/asm/sections.h |   16 ++++++++++++++++
 arch/arm64/include/asm/traps.h    |   16 ----------------
 arch/x86/include/asm/sections.h   |   15 +++++++++++++++
 arch/x86/kernel/kprobes/opt.c     |    5 +----
 arch/x86/kernel/unwind_frame.c    |   15 +--------------
 include/asm-generic/sections.h    |   24 ++++++++++++++++++++++++
 kernel/extable.c                  |   18 ++++--------------
 kernel/kallsyms.c                 |   14 +++-----------
 10 files changed, 82 insertions(+), 80 deletions(-)
