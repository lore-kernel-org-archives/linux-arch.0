From: David Howells <dhowells@redhat.com>
Subject: [PATCH 07/13] UAPI: x86: Fix the test_get_len tool
Date: Fri, 20 Jul 2012 22:58:01 +0100
Message-ID: <20120720215800.14854.35471.stgit@warthog.procyon.org.uk>
References: <20120720215636.14854.41208.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120720215636.14854.41208.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@kernel.org, davej@redhat.com
List-Id: linux-arch.vger.kernel.org

Fix the x86 test_get_len tool to have the right include paths in the right
order (it includes a non-exported kernel header directly), otherwise errors
like the following occur:

/data/fs/linux-2.6-hdr/include/linux/types.h:18:26: error: conflicting types for 'fd_set'
/usr/include/sys/select.h:78:5: note: previous declaration of 'fd_set' was here

and

/data/fs/linux-2.6-hdr/include/linux/string.h:42:12: error: expected identifier or '(' before '__extension__'

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/tools/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/tools/Makefile b/arch/x86/tools/Makefile
index 733057b..bae601f 100644
--- a/arch/x86/tools/Makefile
+++ b/arch/x86/tools/Makefile
@@ -28,7 +28,7 @@ posttest: $(obj)/test_get_len vmlinux $(obj)/insn_sanity
 hostprogs-y	+= test_get_len insn_sanity
 
 # -I needed for generated C source and C source which in the kernel tree.
-HOSTCFLAGS_test_get_len.o := -Wall -I$(objtree)/arch/x86/lib/ -I$(srctree)/arch/x86/include/ -I$(srctree)/arch/x86/lib/ -I$(srctree)/include/
+HOSTCFLAGS_test_get_len.o := -Wall -I$(objtree)/arch/x86/lib/ -I$(srctree)/arch/x86/include/uapi/ -I$(srctree)/arch/x86/include/ -I$(srctree)/arch/x86/lib/ -I$(srctree)/include/uapi/
 
 HOSTCFLAGS_insn_sanity.o := -Wall -I$(objtree)/arch/x86/lib/ -I$(srctree)/arch/x86/include/ -I$(srctree)/arch/x86/lib/ -I$(srctree)/include/
 
