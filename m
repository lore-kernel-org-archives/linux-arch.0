Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:37834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfHTJ5u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 05:57:50 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 0/2] ELF: Alternate program property parser
Date: Tue, 20 Aug 2019 10:57:41 +0100
Message-ID: <1566295063-7387-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20190820095741.9noSB8XHBD4Axz3pzE9u0cUf1ErpgVrobGoO-jMW5GM@z>

This series is an experimental reimplementation of ELF property parsing
(see NT_GNU_PROPERTY_TYPE_0, [1]) for the ELF loader.

This is intended for comparison / merging with [2] (or could replace it,
if people think this approach is better).

Either way, I'd like to get something in place so that we can build
AArch64 BTI support on top of it.

Any thoughts?


Key differences from [2]:

 * Scanning for the PT_PROGRAM_PROPERTY program header is intergrated
   into the existing scan loops, rather than being done separately.

 * In keeping with the rest of the ELF loader code, error checks are
   kept to a minimum.  Except to avoid buffer overruns, the ELF file is
   not checked for well-formedness.

   As a sanity check, the code still checks for a correct
   NT_GNU_PROPERTY_TYPE_0 note header at the start of the
   PT_PROGRAM_PROPERTY segment, but perhaps this isn't needed either.

 * 1K is statically allocated on the stack for the properties, and if
   the ELF properties are larger than that, the ELF file is rejected
   with ENOEXEC.

   There is no limit defined in [1] for the total size of the
   properties, but common sense seems suggests that 1K is likely to be
   ample space.

 * The properties are found, read and parsed exactly once.  [2] does
   this once _per property_ requested by the arch code: that's not a
   problem today, but it will become inefficient with there are multiple
   properties in the file that the kernel needs to look at.

   Instead, the arch arch_parse_elf_property() hook is called once per
   property found.  To minimise overhead, the arch code can implement
   this hook inline.

   This approach assumes that the number of properties in a given ELF is
   say, no more than 20 or so.  The code could be redesigned in the
   future if/when this iteration becomes an overhead (i.e., probably
   never).


[1] Linux Extensions to gABI
https://github.com/hjl-tools/linux-abi/wiki/Linux-Extensions-to-gABI

[2] [PATCH v8 22/27] binfmt_elf: Extract .note.gnu.property from an ELF file
https://lore.kernel.org/lkml/20190813205225.12032-23-yu-cheng.yu@intel.com/


Dave Martin (2):
  ELF: UAPI and Kconfig additions for ELF program properties
  ELF: Add ELF program property parsing support

 fs/Kconfig.binfmt        |   3 ++
 fs/binfmt_elf.c          | 109 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/compat_binfmt_elf.c   |   4 ++
 include/linux/elf.h      |  21 +++++++++
 include/uapi/linux/elf.h |  11 +++++
 5 files changed, 148 insertions(+)

-- 
2.1.4
