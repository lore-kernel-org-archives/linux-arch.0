From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/3 v3] kbuild changes, thin archives, --gc-sections
Date: Wed, 24 Aug 2016 22:29:18 +1000
Message-ID: <1472041761-14414-1-git-send-email-npiggin@gmail.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

Hi Michal,

I ended up deciding to do a v3, because I had several changes
accumulated, as described in patches.

I've also left off the powerpc arch patches -- they can be found
in previous posts, for reference.

I've again tested ARM and it seems to be building okay and without
performance regression with my configurations. I think it's going
to be a matter of some toolchain options for them to go through.
arm64, x86, powerpc, and arm for me all built fine with thin archives
and --gc-sections enabled, so I can't see there being a fundamental
issue that can't be solved. Worst case, the incremental link option
can remain for a time.

Thanks,
Nick

Nicholas Piggin (2):
  kbuild: allow archs to select link dead code/data elimination
  kbuild: add arch specific post-link Makefile

Stephen Rothwell (1):
  kbuild: allow architectures to use thin archives instead of ld -r

 Documentation/kbuild/makefiles.txt | 16 +++++++++
 Makefile                           | 19 ++++++++--
 arch/Kconfig                       | 26 ++++++++++++++
 include/asm-generic/vmlinux.lds.h  | 52 ++++++++++++++++------------
 include/linux/compiler.h           | 23 ++++++++++++
 include/linux/export.h             | 30 ++++++++--------
 include/linux/init.h               | 38 +++++++-------------
 init/Makefile                      |  2 ++
 scripts/Makefile.build             | 23 +++++++++---
 scripts/Makefile.modpost           | 14 +++++---
 scripts/link-vmlinux.sh            | 71 ++++++++++++++++++++++++++++++++------
 11 files changed, 228 insertions(+), 86 deletions(-)

-- 
2.8.1

