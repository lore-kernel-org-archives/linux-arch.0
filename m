Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751914AbeBTXZE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Feb 2018 18:25:04 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1KNNprL061633
        for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2018 18:25:04 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g8tk7wnhr-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2018 18:25:03 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 20 Feb 2018 18:25:02 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/lkmm 02/12] MAINTAINERS: Add the Memory Consistency Model subsystem
Date: Tue, 20 Feb 2018 15:25:02 -0800
In-Reply-To: <20180220232405.GA19274@linux.vnet.ibm.com>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
Message-Id: <1519169112-20593-2-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

From: Andrea Parri <parri.andrea@gmail.com>

Move the contents of tools/memory-model/MAINTAINERS into the main
MAINTAINERS file, removing tools/memory-model/MAINTAINERS. This
allows get_maintainer.pl to correctly identify the maintainers of
tools/memory-model/.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 MAINTAINERS                    | 16 ++++++++++++++++
 tools/memory-model/MAINTAINERS | 15 ---------------
 2 files changed, 16 insertions(+), 15 deletions(-)
 delete mode 100644 tools/memory-model/MAINTAINERS

diff --git a/MAINTAINERS b/MAINTAINERS
index e3581413420c..50bcedbdca86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8086,6 +8086,22 @@ M:	Kees Cook <keescook@chromium.org>
 S:	Maintained
 F:	drivers/misc/lkdtm*
 
+LINUX KERNEL MEMORY CONSISTENCY MODEL (LKMM)
+M:	Alan Stern <stern@rowland.harvard.edu>
+M:	Andrea Parri <parri.andrea@gmail.com>
+M:	Will Deacon <will.deacon@arm.com>
+M:	Peter Zijlstra <peterz@infradead.org>
+M:	Boqun Feng <boqun.feng@gmail.com>
+M:	Nicholas Piggin <npiggin@gmail.com>
+M:	David Howells <dhowells@redhat.com>
+M:	Jade Alglave <j.alglave@ucl.ac.uk>
+M:	Luc Maranget <luc.maranget@inria.fr>
+M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
+F:	tools/memory-model/
+
 LINUX SECURITY MODULE (LSM) FRAMEWORK
 M:	Chris Wright <chrisw@sous-sol.org>
 L:	linux-security-module@vger.kernel.org
diff --git a/tools/memory-model/MAINTAINERS b/tools/memory-model/MAINTAINERS
deleted file mode 100644
index db3bd3fc0435..000000000000
--- a/tools/memory-model/MAINTAINERS
+++ /dev/null
@@ -1,15 +0,0 @@
-LINUX KERNEL MEMORY CONSISTENCY MODEL
-M:	Alan Stern <stern@rowland.harvard.edu>
-M:	Andrea Parri <parri.andrea@gmail.com>
-M:	Will Deacon <will.deacon@arm.com>
-M:	Peter Zijlstra <peterz@infradead.org>
-M:	Boqun Feng <boqun.feng@gmail.com>
-M:	Nicholas Piggin <npiggin@gmail.com>
-M:	David Howells <dhowells@redhat.com>
-M:	Jade Alglave <j.alglave@ucl.ac.uk>
-M:	Luc Maranget <luc.maranget@inria.fr>
-M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
-L:	linux-kernel@vger.kernel.org
-S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
-F:	tools/memory-model/
-- 
2.5.2
