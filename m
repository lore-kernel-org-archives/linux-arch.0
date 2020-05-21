From: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 0/5] Update selftests/x86 for CET
Date: Thu, 21 May 2020 14:17:15 -0700
Message-ID: <20200521211720.20236-1-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mike Kravetz <mike.kravetz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Nadav Amit <nadav.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

When CET is enabled for selftests/x86, two tests need updates.

- The test 'sigreturn_64' does a sigreturn() from a 64-bit context into a
  32-bit context.  The task's 64-bit shadow stack pointer certainly
  triggers a fault.  Fix it by allocating and switching to a new shadow
  stack in the 32-bit address range.

  The arch_ptrcl(ARCH_X86_CET_ALLOC_SHSTK) is updated for taking a bit from
  the input parameter to indicate the desire of MAP_32BIT.  I am proposing
  this change to minimize API changes, but open to any alternatives.

- The test 'sysret_rip' fails because the assembly code needs ENDBR
  opcodes.  Fix it by adding just that.  My latest CET submission (v10)
  does not include the IBT patches.  My purpose of posting this now is to
  show the changes needed in x86 tests.  Since ENDBR is nop when IBT is not
  enabled, this patch can be applied now or split out and merged with the
  IBT patches.

- The makefile changes add "-fcf-protection -mshstk" to the gcc command,
  when those are available.

- Introduce cet_quick_test that checks the system's CET capabilities.

This series is based on my CET series:

https://lore.kernel.org/lkml/20200429220732.31602-2-yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org/

Yu-cheng Yu (5):
  x86/cet/shstk: Modify ARCH_X86_CET_ALLOC_SHSTK for 32-bit address
    range
  selftest/x86: Enable CET for selftests/x86
  selftest/x86: Fix sigreturn_64 test.
  selftest/x86: Fix sysret_rip with ENDBR
  selftest/x86: Add CET quick test

 arch/x86/include/asm/cet.h                   |   2 +-
 arch/x86/include/uapi/asm/prctl.h            |   2 +
 arch/x86/kernel/cet.c                        |  19 ++-
 arch/x86/kernel/cet_prctl.c                  |   6 +-
 tools/testing/selftests/x86/Makefile         |   7 +-
 tools/testing/selftests/x86/cet_quick_test.c | 128 +++++++++++++++++++
 tools/testing/selftests/x86/sigreturn.c      |  28 ++++
 tools/testing/selftests/x86/sysret_rip.c     |   5 +-
 8 files changed, 185 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/x86/cet_quick_test.c

-- 
2.21.0
