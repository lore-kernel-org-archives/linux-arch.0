From: Sam Ravnborg <sam@ravnborg.org>
Subject: introduce arch/$ARCH/Kbuild ?
Date: Thu, 16 Apr 2009 20:37:01 +0200
Message-ID: <20090416183701.GA5810@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:45949 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756220AbZDPSez (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Apr 2009 14:34:55 -0400
Received: from ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
	by pfepa.post.tele.dk (Postfix) with ESMTP id B03B2A50042
	for <linux-arch@vger.kernel.org>; Thu, 16 Apr 2009 20:34:52 +0200 (CEST)
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org


We have discussed privately the possiblity to cover
all of arch/x86/* with -Werror and I came up with some
suggestions so we could cover all subdirectories
with a simple:

    subdir-ccflags-y := -Werror

I will sent a separate post on this when I have a patch ready..

But doing so required us to modify a lot of Makefiles
in arch/x86 - too much for my taste.

Looking futher I realised that we could move all the core-y
stuff to a separate Kbuild file as done by the appended patch.
We would then cover all the directories with a single:

    subdir-ccflags-y := -Werror


This has the added benefit that you can now do:

    make arch/x86/

And you will build most (but not all) of the x86 files.
That alone was enough rationale for Ingo to apply it (and I agree).

What remains are the libs-y and driver-y parts.
There is no way to specify these today.

If you think this looks wortwhile for your architecture I
will be glad to help cook up a patch - albeit it is trivial
to do so yourself.

	Sam


----- Forwarded message from tip-bot for Sam Ravnborg <sam@ravnborg.org> -----

Subject: [tip:x86/kbuild] x86: standardize Kbuild rules
From: tip-bot for Sam Ravnborg <sam@ravnborg.org>
Reply-To: linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        sam@ravnborg.org, jaswinder@kernel.org, tglx@linutronix.de,
        mingo@elte.hu
Date: Thu, 16 Apr 2009 16:33:39 GMT
X-Mailer: tip-git-log-daemon
To: linux-tip-commits@vger.kernel.org
Cc: hpa@zytor.com, mingo@redhat.com, sam@ravnborg.org, jaswinder@kernel.org,
        tglx@linutronix.de, mingo@elte.hu

Commit-ID:  d1f0ae5e2e45e74cff4c3bdefb0fc77608cdfeec
Gitweb:     http://git.kernel.org/tip/d1f0ae5e2e45e74cff4c3bdefb0fc77608cdfeec
Author:     Sam Ravnborg <sam@ravnborg.org>
AuthorDate: Wed, 15 Apr 2009 21:34:55 +0200
Committer:  Ingo Molnar <mingo@elte.hu>
CommitDate: Thu, 16 Apr 2009 18:09:02 +0200

x86: standardize Kbuild rules

Introducing this Kbuild file allow us to:

    make arch/x86/

And thus building all the core part of x86.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Jaswinder Singh Rajput <jaswinder@kernel.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>


---
 arch/x86/Kbuild   |   16 ++++++++++++++++
 arch/x86/Makefile |   19 ++-----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
new file mode 100644
index 0000000..ad8ec35
--- /dev/null
+++ b/arch/x86/Kbuild
@@ -0,0 +1,16 @@
+
+obj-$(CONFIG_KVM) += kvm/
+
+# Xen paravirtualization support
+obj-$(CONFIG_XEN) += xen/
+
+# lguest paravirtualization support
+obj-$(CONFIG_LGUEST_GUEST) += lguest/
+
+obj-y += kernel/
+obj-y += mm/
+
+obj-y += crypto/
+obj-y += vdso/
+obj-$(CONFIG_IA32_EMULATION) += ia32/
+
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f05d8c9..e81f0b2 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -7,8 +7,6 @@ else
         KBUILD_DEFCONFIG := $(ARCH)_defconfig
 endif
 
-core-$(CONFIG_KVM) += arch/x86/kvm/
-
 # BITS is used as extension for files which are available in a 32 bit
 # and a 64 bit version to simplify shared Makefiles.
 # e.g.: obj-y += foo_$(BITS).o
@@ -118,21 +116,8 @@ head-y += arch/x86/kernel/init_task.o
 
 libs-y  += arch/x86/lib/
 
-# Sub architecture files that needs linking first
-core-y += $(fcore-y)
-
-# Xen paravirtualization support
-core-$(CONFIG_XEN) += arch/x86/xen/
-
-# lguest paravirtualization support
-core-$(CONFIG_LGUEST_GUEST) += arch/x86/lguest/
-
-core-y += arch/x86/kernel/
-core-y += arch/x86/mm/
-
-core-y += arch/x86/crypto/
-core-y += arch/x86/vdso/
-core-$(CONFIG_IA32_EMULATION) += arch/x86/ia32/
+# See arch/x86/Kbuild for content of core part of the kernel
+core-y += arch/x86/
 
 # drivers-y are linked after core-y
 drivers-$(CONFIG_MATH_EMULATION) += arch/x86/math-emu/

----- End forwarded message -----
