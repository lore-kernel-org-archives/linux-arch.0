From: James Hogan <james.hogan@imgtec.com>
Subject: [RFC PATCH v1 03/40] Add CONFIG_HAVE_64BIT_ALIGNED_STRUCT for taskstats
Date: Wed, 31 Oct 2012 16:13:44 +0000
Message-ID: <1351700061-7203-4-git-send-email-james.hogan@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:49628 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423216Ab2JaQPV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 12:15:21 -0400
In-Reply-To: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>, Balbir Singh <bsingharora@gmail.com>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Eric Paris <eparis@redhat.com>, Will Drewry <wad@chromium.org>, James Morris <james.l.morris@oracle.com>

On 64 bit architectures with no efficient unaligned access, taskstats
has to add some padding to a reply to prevent unaligned access warnings.
However this also needs to apply to 32 bit architectures with 64 bit
struct alignment such as metag (which has 64 bit memory accesses).

This is solved by adding a new Kconfig symbol
CONFIG_HAVE_64BIT_ALIGNED_STRUCT which defaults to CONFIG_64BIT, and can
be explicitly selected by CONFIG_METAG. Taskstats then uses this symbol
instead of CONFIG_64BIT to determine whether to add the padding.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Paris <eparis@redhat.com>
Cc: Will Drewry <wad@chromium.org>
Cc: James Morris <james.l.morris@oracle.com>
---
 arch/Kconfig       |   16 ++++++++++++++++
 kernel/taskstats.c |    3 ++-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 72f2fa1..26eba37 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -93,6 +93,22 @@ config UPROBES
 
 	  If in doubt, say "N".
 
+config HAVE_64BIT_ALIGNED_STRUCT
+	bool
+	default 64BIT
+	help
+	  Some architectures have 64bit struct alignment (64 bit
+	  architectures and some 32 bit architectures which can do
+	  64 bit accesses).
+
+	  This symbol should be selected by an architecture if it has
+	  a 64 bit struct alignment requirement even though it isn't
+	  a 64 bit architecture (64 bit architectures have this on by
+	  default).
+
+	  See Documentation/unaligned-memory-access.txt for more
+	  information on the topic of unaligned memory accesses.
+
 config HAVE_EFFICIENT_UNALIGNED_ACCESS
 	bool
 	help
diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index d0a3279..6b26c40 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -355,7 +355,8 @@ static int parse(struct nlattr *na, struct cpumask *mask)
 	return ret;
 }
 
-#if defined(CONFIG_64BIT) && !defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
+#if defined(CONFIG_HAVE_64BIT_ALIGNED_STRUCT) && \
+	!defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
 #define TASKSTATS_NEEDS_PADDING 1
 #endif
 
-- 
1.7.7.6
