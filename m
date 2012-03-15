Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35377 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab2CODNR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 Mar 2012 23:13:17 -0400
Received: by mail-yw0-f46.google.com with SMTP id m54so2639686yhm.19
        for <linux-arch@vger.kernel.org>; Wed, 14 Mar 2012 20:13:16 -0700 (PDT)
From: Will Drewry <wad@chromium.org>
Subject: [PATCH v15 00/13] seccomp_filter: syscall filtering using BPF
Date: Wed, 14 Mar 2012 22:11:52 -0500
Message-ID: <1331781125-15658-1-git-send-email-wad@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com, netdev@vger.kernel.org, x86@kernel.org, arnd@arndb.de, davem@davemloft.net, hpa@zytor.com, mingo@redhat.com, oleg@redhat.com, peterz@infradead.org, rdunlap@xenotime.net, mcgrathr@chromium.org, tglx@linutronix.de, luto@mit.edu, eparis@redhat.com, serge.hallyn@canonical.com, djm@mindrot.org, scarybeasts@gmail.com, indan@nul.nu, pmoore@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, eric.dumazet@gmail.com, markus@chromium.org, coreyb@linux.vnet.ibm.com, keescook@chromium.org, Will Drewry <wad@chromium.org>
Message-ID: <20120315031152.jGHC_sMwA7SA8bGfR76iy7c1iAUyQ-msbi3RCvyo8u8@z>

Please see prior revisions of this patch series for a high
level blurb.

This revision makes a number of refinements and tweaks. The biggest
change is a slight renumbering of the return codes which will break
existing code using this patch series.

I believe this patch is in good shape, and I don't see the need for
any more API changes at this point.  I plan to start using this revision
more extensively, and I'd certainly appreciate any testing.

Thanks!
will


Kees Cook (1):
  seccomp: remove duplicated failure logging

Will Drewry (12):
  sk_run_filter: add BPF_S_ANC_SECCOMP_LD_W
  net/compat.c,linux/filter.h: share compat_sock_fprog
  seccomp: kill the seccomp_t typedef
  arch/x86: add syscall_get_arch to syscall.h
  asm/syscall.h: add syscall_get_arch
  seccomp: add system call filtering using BPF
  seccomp: add SECCOMP_RET_ERRNO
  signal, x86: add SIGSYS info and make it synchronous.
  seccomp: Add SECCOMP_RET_TRAP
  ptrace,seccomp: Add PTRACE_SECCOMP support
  x86: Enable HAVE_ARCH_SECCOMP_FILTER
  Documentation: prctl/seccomp_filter

 Documentation/prctl/seccomp_filter.txt |  156 +++++++++++
 arch/Kconfig                           |   24 ++
 arch/x86/Kconfig                       |    1 +
 arch/x86/ia32/ia32_signal.c            |    4 +
 arch/x86/include/asm/ia32.h            |    6 +
 arch/x86/include/asm/syscall.h         |   23 ++
 arch/x86/kernel/ptrace.c               |    7 +-
 include/asm-generic/siginfo.h          |   22 ++
 include/asm-generic/syscall.h          |   14 +
 include/linux/Kbuild                   |    1 +
 include/linux/audit.h                  |    8 +-
 include/linux/filter.h                 |   12 +
 include/linux/ptrace.h                 |    7 +-
 include/linux/sched.h                  |    2 +-
 include/linux/seccomp.h                |  105 +++++++-
 kernel/auditsc.c                       |   10 +-
 kernel/fork.c                          |    3 +
 kernel/ptrace.c                        |    3 +
 kernel/seccomp.c                       |  446 ++++++++++++++++++++++++++++++--
 kernel/signal.c                        |    9 +-
 kernel/sys.c                           |    2 +-
 net/compat.c                           |    8 -
 net/core/filter.c                      |    6 +
 samples/Makefile                       |    2 +-
 samples/seccomp/Makefile               |   38 +++
 samples/seccomp/bpf-direct.c           |  176 +++++++++++++
 samples/seccomp/bpf-fancy.c            |  102 ++++++++
 samples/seccomp/bpf-helper.c           |   89 +++++++
 samples/seccomp/bpf-helper.h           |  238 +++++++++++++++++
 samples/seccomp/dropper.c              |   68 +++++
 30 files changed, 1538 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/prctl/seccomp_filter.txt
 create mode 100644 samples/seccomp/Makefile
 create mode 100644 samples/seccomp/bpf-direct.c
 create mode 100644 samples/seccomp/bpf-fancy.c
 create mode 100644 samples/seccomp/bpf-helper.c
 create mode 100644 samples/seccomp/bpf-helper.h
 create mode 100644 samples/seccomp/dropper.c

-- 
1.7.5.4

