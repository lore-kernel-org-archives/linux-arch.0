From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/6 v2] kbuild changes, thin archives, --gc-sections
Date: Thu, 11 Aug 2016 20:16:14 +1000
Message-ID: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

Hi,

I would like to submit the kbuild changes in patches 1-3 for
consideration.

I've taken on the feedback, so thanks everybody for that. The
biggest change since last time is a more general way for
architectures to do a post-link pass in patch 3.

On the question of whether to enable thin archives unconditionally,
I prefer to have architectures enable them as they are tested. But
I would like to see everybody moved as soon as possible and the
incremental linking removed.

All patches should be basically noops without arch enablement,
so I include initial powerpc enablement in patches 4-6 for
reference, but I will submit those via powerpc maintainer if
the kbuild changes are merged.

Thanks,
Nick

Nicholas Piggin (4):
  kbuild: allow archs to select build for link dead code/data
    elimination
  kbuild: add arch specific post-link pass
  powerpc/64: use linker dce
  powerpc: use the new post-link pass to check relocations

Stephen Rothwell (2):
  kbuild: allow architectures to use thin archives instead of ld -r
  powerpc: switch to using thin archives

 Documentation/kbuild/makefiles.txt     | 10 +++++
 Makefile                               |  9 ++++
 arch/Kconfig                           | 26 ++++++++++++
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/Makefile                  | 17 ++------
 arch/powerpc/Makefile.postlink         | 31 ++++++++++++++
 arch/powerpc/kernel/Makefile           |  3 ++
 arch/powerpc/kernel/vmlinux.lds.S      |  2 +-
 arch/powerpc/platforms/Kconfig.cputype |  2 +
 arch/x86/entry/vdso/Makefile           |  6 +--
 include/asm-generic/vmlinux.lds.h      | 52 ++++++++++++-----------
 include/linux/compiler.h               | 23 +++++++++++
 include/linux/export.h                 | 30 +++++++-------
 include/linux/init.h                   | 38 ++++++-----------
 init/Makefile                          |  2 +
 kernel/Makefile                        |  3 --
 scripts/Makefile.build                 | 25 +++++++++---
 scripts/Makefile.modpost               |  3 ++
 scripts/link-vmlinux.sh                | 75 +++++++++++++++++++++++++++++-----
 19 files changed, 258 insertions(+), 100 deletions(-)
 create mode 100644 arch/powerpc/Makefile.postlink

-- 
2.8.1

