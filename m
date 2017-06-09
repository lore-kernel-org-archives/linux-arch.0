From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/5] sh: thin archives fix linking
Date: Fri,  9 Jun 2017 15:24:15 +1000
Message-ID: <20170609052417.561-4-npiggin@gmail.com>
References: <20170609052417.561-1-npiggin@gmail.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20170609052417.561-1-npiggin@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The VDSO symbols can't be linked into built-in.o when building with
thin archives, so change this to linking them into the final link.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Arch maintainers please give an ack if we can take this through
the kbuild tree.

Thanks,
Nick

 arch/sh/Makefile                 | 2 ++
 arch/sh/kernel/vsyscall/Makefile | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 280bbff12102..a907366f0352 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -97,6 +97,8 @@ defaultimage-$(CONFIG_SH_7619_SOLUTION_ENGINE)	:= vmlinux
 boot := arch/sh/boot
 KBUILD_IMAGE		:= $(boot)/$(defaultimage-y)
 
+LDFLAGS_vmlinux		+= -R arch/sh/kernel/vsyscall/vsyscall-syms.o
+
 #
 # Choosing incompatible machines durings configuration will result in
 # error messages during linking.
diff --git a/arch/sh/kernel/vsyscall/Makefile b/arch/sh/kernel/vsyscall/Makefile
index 8f0ea5fc835c..b82d13eb8d30 100644
--- a/arch/sh/kernel/vsyscall/Makefile
+++ b/arch/sh/kernel/vsyscall/Makefile
@@ -27,8 +27,6 @@ $(obj)/vsyscall-%.so: $(src)/vsyscall.lds $(obj)/vsyscall-%.o FORCE
 # table and layout of the linked DSO.  With ld -R we can then refer to
 # these symbols in the kernel code rather than hand-coded addresses.
 extra-y += vsyscall-syms.o
-$(obj)/built-in.o: $(obj)/vsyscall-syms.o
-$(obj)/built-in.o: ld_flags += -R $(obj)/vsyscall-syms.o
 
 SYSCFLAGS_vsyscall-syms.o = -r
 $(obj)/vsyscall-syms.o: $(src)/vsyscall.lds \
-- 
2.11.0

