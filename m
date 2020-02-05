Return-Path: <linux-doc-owner@vger.kernel.org>
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v9 0/7] Control-flow Enforcement: Indirect Branch Tracking
Date: Wed,  5 Feb 2020 10:23:01 -0800
Message-ID: <20200205182308.4028-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-doc-owner@vger.kernel.org
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200205182301.mkLlXwEIHiOF6w-2CGmruRUB9CDWELDs8xw6L2HTOpE@z>

Control-flow Enforcement (CET) is a new Intel processor feature that blocks
return/jump-oriented programming attacks.  Details can be found in "Intel
64 and IA-32 Architectures Software Developer's Manual" [1].

This is the second half of CET and enables Indirect Branch Tracking (IBT).

Changes from v8:

- Remove a patch that adds the legacy bitmap size to memory accounting,
  since the bitmap is now dynamically allocated.
- Change the legacy bitmap from a pre-defined address to
  get_unmapped_area().
- Fix mis-handling of WAIT_ENDBR in signals
- Split out PTRACE, VDSO, opcode map, and Makefile changes and submit
  separately.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual:

    https://software.intel.com/en-us/download/intel-64-and-ia-32-
    architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

[2] CET patches v8:

    https://lkml.kernel.org/r/20190813205225.12032-1-yu-cheng.yu@intel.com/
    https://lkml.kernel.org/r/20190813205359.12196-1-yu-cheng.yu@intel.com/

H.J. Lu (1):
  x86/cet/ibt: Add arch_prctl functions for Indirect Branch Tracking

Yu-cheng Yu (6):
  x86/cet/ibt: Add Kconfig option for user-mode Indirect Branch Tracking
  x86/cet/ibt: User-mode Indirect Branch Tracking support
  x86/cet/ibt: Handle signals for Indirect Branch Tracking
  x86/cet/ibt: ELF header parsing for Indirect Branch Tracking
  mm: Update alloc_set_pte() for zero page
  x86/cet/ibt: Introduce arch_prctl(ARCH_X86_CET_MARK_LEGACY_CODE)

 arch/x86/Kconfig                              |  17 ++
 arch/x86/Makefile                             |   7 +
 arch/x86/include/asm/cet.h                    |   7 +
 arch/x86/include/asm/disabled-features.h      |   8 +-
 arch/x86/include/uapi/asm/prctl.h             |   3 +
 arch/x86/kernel/Makefile                      |   2 +-
 arch/x86/kernel/cet.c                         |  58 ++++-
 arch/x86/kernel/cet_bitmap.c                  | 226 ++++++++++++++++++
 arch/x86/kernel/cet_prctl.c                   |  19 ++
 arch/x86/kernel/cpu/common.c                  |  17 ++
 arch/x86/kernel/fpu/signal.c                  |   8 +-
 arch/x86/kernel/process_64.c                  |   5 +
 mm/memory.c                                   |   8 +
 .../arch/x86/include/asm/disabled-features.h  |   8 +-
 14 files changed, 385 insertions(+), 8 deletions(-)
 create mode 100644 arch/x86/kernel/cet_bitmap.c

-- 
2.21.0
