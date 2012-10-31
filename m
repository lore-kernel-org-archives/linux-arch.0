From: James Hogan <james.hogan@imgtec.com>
Subject: [RFC PATCH v1 22/40] metag: Basic documentation
Date: Wed, 31 Oct 2012 16:14:03 +0000
Message-ID: <1351700061-7203-23-git-send-email-james.hogan@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:49761 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423215Ab2JaQPF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 12:15:05 -0400
In-Reply-To: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>

Add basic metag documentation.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 Documentation/00-INDEX              |    2 ++
 Documentation/kernel-parameters.txt |    4 ++++
 Documentation/metag/00-INDEX        |    2 ++
 3 files changed, 8 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/metag/00-INDEX

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index 49c0513..1dadc7e 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -226,6 +226,8 @@ memory-hotplug.txt
 	- Hotpluggable memory support, how to use and current status.
 memory.txt
 	- info on typical Linux memory problems.
+metag/
+	- directory with info about Linux on Meta architecture.
 mips/
 	- directory with info about Linux on MIPS architecture.
 mmc/
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index ad7e2e5..4989844 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -958,6 +958,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			       If specified, z/VM IUCV HVC accepts connections
 			       from listed z/VM user IDs only.
 
+	hwthread_map=	[METAG] Comma-separated list of Linux cpu id to
+			        hardware thread id mappings.
+				Format: <cpu>:<hwthread>
+
 	keep_bootcon	[KNL]
 			Do not unregister boot console at start. This is only
 			useful for debugging when something happens in the window
diff --git a/Documentation/metag/00-INDEX b/Documentation/metag/00-INDEX
new file mode 100644
index 0000000..808f5d4
--- /dev/null
+++ b/Documentation/metag/00-INDEX
@@ -0,0 +1,2 @@
+00-INDEX
+	- this file
-- 
1.7.7.6
