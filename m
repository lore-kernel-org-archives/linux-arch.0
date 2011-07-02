From: David Howells <dhowells@redhat.com>
Subject: [PATCH 32/35] UAPI: Set up uapi/asm/Kbuild.asm
Date: Sat, 02 Jul 2011 12:12:16 +0100
Message-ID: <20110702111216.21948.21587.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5265 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201Ab1GBLMS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:12:18 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62BCIcY016834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:12:18 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

Set up uapi/asm/Kbuild.asm.  This requires the mandatory headers to be
dynamically detected.  The same goes for include/asm/Kbuild.asm.  The problem
is that the header files will be split or moved one at a time, but each header
file in Kbuild.asm's list applies to all arch headers of that name
simultaneously.

The dynamic detection of mandatory files can be undone later.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/asm-generic/Kbuild.asm |   85 ++++++++++++++++++++--------------------
 uapi/asm-generic/Kbuild.asm    |   44 +++++++++++++++++++++
 2 files changed, 86 insertions(+), 43 deletions(-)
 create mode 100644 uapi/asm-generic/Kbuild.asm

diff --git a/include/asm-generic/Kbuild.asm b/include/asm-generic/Kbuild.asm
index c5d2e5d..4923b27 100644
--- a/include/asm-generic/Kbuild.asm
+++ b/include/asm-generic/Kbuild.asm
@@ -1,45 +1,44 @@
-ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/kvm.h \
-		  $(srctree)/include/asm-$(SRCARCH)/kvm.h),)
-header-y  += kvm.h
-endif
+#
+# Headers that are optional in arch/*/include/asm/
+#
+opt-header += kvm.h
+opt-header += kvm_para.h
+opt-header += a.out.h
 
-ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/kvm_para.h \
-		  $(srctree)/include/asm-$(SRCARCH)/kvm_para.h),)
-header-y  += kvm_para.h
-endif
+#
+# Headers that are mandatory in arch/*/include/asm/
+#
+asm-headers += auxvec.h
+asm-headers += bitsperlong.h
+asm-headers += byteorder.h
+asm-headers += errno.h
+asm-headers += fcntl.h
+asm-headers += ioctl.h
+asm-headers += ioctls.h
+asm-headers += ipcbuf.h
+asm-headers += mman.h
+asm-headers += msgbuf.h
+asm-headers += param.h
+asm-headers += poll.h
+asm-headers += posix_types.h
+asm-headers += ptrace.h
+asm-headers += resource.h
+asm-headers += sembuf.h
+asm-headers += setup.h
+asm-headers += shmbuf.h
+asm-headers += sigcontext.h
+asm-headers += siginfo.h
+asm-headers += signal.h
+asm-headers += socket.h
+asm-headers += sockios.h
+asm-headers += stat.h
+asm-headers += statfs.h
+asm-headers += swab.h
+asm-headers += termbits.h
+asm-headers += termios.h
+asm-headers += types.h
+asm-headers += unistd.h
 
-ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/a.out.h \
-		  $(srctree)/include/asm-$(SRCARCH)/a.out.h),)
-header-y += a.out.h
-endif
-
-header-y += auxvec.h
-header-y += bitsperlong.h
-header-y += byteorder.h
-header-y += errno.h
-header-y += fcntl.h
-header-y += ioctl.h
-header-y += ioctls.h
-header-y += ipcbuf.h
-header-y += mman.h
-header-y += msgbuf.h
-header-y += param.h
-header-y += poll.h
-header-y += posix_types.h
-header-y += ptrace.h
-header-y += resource.h
-header-y += sembuf.h
-header-y += setup.h
-header-y += shmbuf.h
-header-y += sigcontext.h
-header-y += siginfo.h
-header-y += signal.h
-header-y += socket.h
-header-y += sockios.h
-header-y += stat.h
-header-y += statfs.h
-header-y += swab.h
-header-y += termbits.h
-header-y += termios.h
-header-y += types.h
-header-y += unistd.h
+header-y := $(foreach hdr,$(asm-headers) $(opt-headers), \
+		$(if $(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/$(hdr)), \
+		  $(hdr)))
diff --git a/uapi/asm-generic/Kbuild.asm b/uapi/asm-generic/Kbuild.asm
new file mode 100644
index 0000000..5789ed6
--- /dev/null
+++ b/uapi/asm-generic/Kbuild.asm
@@ -0,0 +1,44 @@
+#
+# Headers that are optional in arch/*/uapi/asm/
+#
+opt-header += kvm.h
+opt-header += kvm_para.h
+opt-header += a.out.h
+
+#
+# Headers that are mandatory in arch/*/uapi/asm/
+#
+asm-headers += auxvec.h
+asm-headers += bitsperlong.h
+asm-headers += byteorder.h
+asm-headers += errno.h
+asm-headers += fcntl.h
+asm-headers += ioctl.h
+asm-headers += ioctls.h
+asm-headers += ipcbuf.h
+asm-headers += mman.h
+asm-headers += msgbuf.h
+asm-headers += param.h
+asm-headers += poll.h
+asm-headers += posix_types.h
+asm-headers += ptrace.h
+asm-headers += resource.h
+asm-headers += sembuf.h
+asm-headers += setup.h
+asm-headers += shmbuf.h
+asm-headers += sigcontext.h
+asm-headers += siginfo.h
+asm-headers += signal.h
+asm-headers += socket.h
+asm-headers += sockios.h
+asm-headers += stat.h
+asm-headers += statfs.h
+asm-headers += swab.h
+asm-headers += termbits.h
+asm-headers += termios.h
+asm-headers += types.h
+asm-headers += unistd.h
+
+header-y := $(foreach hdr,$(asm-headers) $(opt-headers), \
+		$(if $(wildcard $(srctree)/arch/$(SRCARCH)/include/uapi/$(hdr)), \
+		  $(hdr)))
