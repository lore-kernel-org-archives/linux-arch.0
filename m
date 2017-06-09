From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/5] move everyone over to thin archives
Date: Fri,  9 Jun 2017 15:24:12 +1000
Message-ID: <20170609052417.561-1-npiggin@gmail.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

This has gone through 0day several times now, and I think I've
weeded out all the build breakage. Following what Linus asked
for, I did not make it a user selectable option. I kept the
option there in case we need to do a depend on !ARCH for any
reason.

Please consider for the kbuild tree.

Nicholas Piggin (5):
  kbuild: thin archives final link close --whole-archives option
  kbuild: thin archives use P option to ar
  sh: thin archives fix linking
  x86/um: thin archives build fix
  kbuild: thin archives make default for all archs

 Documentation/process/changes.rst | 9 ++++-----
 arch/Kconfig                      | 2 +-
 arch/powerpc/Kconfig              | 8 --------
 arch/sh/Makefile                  | 2 ++
 arch/sh/kernel/vsyscall/Makefile  | 2 --
 arch/x86/um/vdso/Makefile         | 2 +-
 scripts/Makefile.build            | 8 ++++----
 scripts/link-vmlinux.sh           | 6 +++---
 8 files changed, 15 insertions(+), 24 deletions(-)

-- 
2.11.0

