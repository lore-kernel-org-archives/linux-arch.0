From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/3] Mark the 'current' pointer register read-only when such a
	thing exists
Date: Tue, 18 May 2010 17:45:42 +0100
Message-ID: <20100518164542.6194.451.stgit@warthog.procyon.org.uk>
References: <20100518164537.6194.73366.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59413 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758521Ab0ERRhK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 18 May 2010 13:37:10 -0400
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o4IHb9iR027030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Tue, 18 May 2010 13:37:10 -0400
In-Reply-To: <20100518164537.6194.73366.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: oleg@redhat.com, linux-arch@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>

Where the value of current is kept in a register, that register can be marked
such that the pointer value is read only, e.g.:

	register struct task_struct *const current asm("e2");

This prevents inadvertent assignment outside of assembly code.

This has been available on the MN10300 arch for a while now, and I've also
tested it on the FRV arch.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/frv/include/asm/current.h        |    2 +-
 arch/microblaze/include/asm/current.h |    2 +-
 arch/powerpc/include/asm/current.h    |    2 +-
 arch/sparc/include/asm/current.h      |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/frv/include/asm/current.h b/arch/frv/include/asm/current.h
index 86b0274..51bdaf2 100644
--- a/arch/frv/include/asm/current.h
+++ b/arch/frv/include/asm/current.h
@@ -17,7 +17,7 @@
 /*
  * dedicate GR29 to keeping the current task pointer
  */
-register struct task_struct *current asm("gr29");
+register struct task_struct *const current asm("gr29");
 
 #define get_current() current
 
diff --git a/arch/microblaze/include/asm/current.h b/arch/microblaze/include/asm/current.h
index 29303ed..b824847 100644
--- a/arch/microblaze/include/asm/current.h
+++ b/arch/microblaze/include/asm/current.h
@@ -21,7 +21,7 @@
 /*
  * Dedicate r31 to keeping the current task pointer
  */
-register struct task_struct *current asm("r31");
+register struct task_struct *const current asm("r31");
 
 # define get_current()	current
 # endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/include/asm/current.h b/arch/powerpc/include/asm/current.h
index e2c7f06..4ca5126 100644
--- a/arch/powerpc/include/asm/current.h
+++ b/arch/powerpc/include/asm/current.h
@@ -32,7 +32,7 @@ static inline struct task_struct *get_current(void)
 /*
  * We keep `current' in r2 for speed.
  */
-register struct task_struct *current asm ("r2");
+register struct task_struct *const current asm ("r2");
 
 #endif
 
diff --git a/arch/sparc/include/asm/current.h b/arch/sparc/include/asm/current.h
index f04fd6c..9ae8826 100644
--- a/arch/sparc/include/asm/current.h
+++ b/arch/sparc/include/asm/current.h
@@ -14,7 +14,7 @@
 #include <linux/thread_info.h>
 
 #ifdef CONFIG_SPARC64
-register struct task_struct *current asm("g4");
+register struct task_struct *const current asm("g4");
 #endif
 
 #ifdef CONFIG_SPARC32
