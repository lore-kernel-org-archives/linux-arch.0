From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 0/5] add support for relative references in special sections
Date: Mon, 14 Aug 2017 11:52:26 +0100
Message-ID: <20170814105231.14608-1-ard.biesheuvel@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34563 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752741AbdHNKw7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Aug 2017 06:52:59 -0400
Received: by mail-wr0-f175.google.com with SMTP id l9so10570671wrl.1
        for <linux-arch@vger.kernel.org>; Mon, 14 Aug 2017 03:52:58 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>, Steven Rostedt <rostedt@goodmis.org>

This adds support for emitting special sections such as initcall arrays,
PCI fixups and tracepoints as relative references rather than absolute
references. This reduces the size by 50% on 64-bit architectures, but
more importantly, it removes the need for carrying relocation metadata
for these sections in relocatables kernels (e.g., for KASLR) that need
to fix up these absolute references at boot time. On arm64, this reduces
the vmlinux footprint of such a reference by 8x (8 byte absolute reference
+ 24 byte RELA entry vs 4 byte relative reference)

Patch #2 was sent out before as a single patch. This series supersedes
the previous submission. This version makes relative ksymtab entries
dependent on the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS rather
than trying to infer from kbuild test robot replies for which architectures
it should be blacklisted.

Patch #1 introduces the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS,
and sets it for the main architectures that are expected to benefit most
from this feature, i.e., 64-bit architectures, and ones that use runtime
relocation.

Patches #3 - #5 implement relative references for initcallls, PCI fixups
and tracepoints, respectively, all of which produce sections with order
~1000 entries on an arm64 defconfig kernel with tracing enabled. This
means we save about 28 KB of vmlinux space for each of these patches.

For the arm64 kernel, all patches combined reduce the size of vmlinux
by about 300 KB.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Morris <james.l.morris@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Jessica Yu <jeyu@kernel.org>

Ard Biesheuvel (5):
  arch: enable relative relocations for arm64, power, x86, s390 and x86
  module: use relative references for __ksymtab entries
  init: allow initcall tables to be emitted using relative references
  drivers: pci: add support for relative addressing in quirk tables
  kernel: tracepoints: add support for relative references

 arch/Kconfig                    | 10 +++++
 arch/arm64/Kconfig              |  1 +
 arch/arm64/kernel/vmlinux.lds.S |  2 +-
 arch/powerpc/Kconfig            |  1 +
 arch/s390/Kconfig               |  1 +
 arch/x86/Kconfig                |  1 +
 arch/x86/include/asm/Kbuild     |  1 +
 arch/x86/include/asm/export.h   |  4 --
 drivers/pci/quirks.c            | 13 ++++--
 include/asm-generic/export.h    | 12 ++++-
 include/linux/compiler.h        | 11 +++++
 include/linux/export.h          | 47 +++++++++++++++-----
 include/linux/init.h            | 44 +++++++++++++-----
 include/linux/pci.h             | 20 +++++++++
 include/linux/tracepoint.h      | 19 ++++++--
 init/main.c                     | 32 ++++++-------
 kernel/module.c                 | 33 +++++++++++---
 kernel/printk/printk.c          |  4 +-
 kernel/tracepoint.c             | 19 +++++---
 security/security.c             |  4 +-
 20 files changed, 212 insertions(+), 67 deletions(-)
 delete mode 100644 arch/x86/include/asm/export.h

-- 
2.11.0
