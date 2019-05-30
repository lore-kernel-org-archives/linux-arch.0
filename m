Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727360AbfE3Omh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:42:37 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEfQx3059090
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:36 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stfacduyv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:42:33 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:42:30 +0100
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 22/33] tools/memory-model: Keep assembly-language litmus tests
Date: Thu, 30 May 2019 07:42:14 -0700
In-Reply-To: <20190530144202.GA26201@linux.ibm.com>
References: <20190530144202.GA26201@linux.ibm.com>
Message-ID: <20190530144225.27624-22-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190530144214.V8_EFkYIWmYRamSqoIAes8Z-n3ebRGj92aPLIKow9Ow@z>

This commit retains the assembly-language litmus tests generated from
the C-language litmus tests, appending the hardware tag to the original
C-language litmus test's filename.  Thus, S+poonceonces.litmus.AArch64
contains the Armv8 assembly language corresponding to the C-language
S+poonceonces.litmus test.

This commit also updates the .gitignore to avoid commiting these
automatically generated assembly-language litmus tests.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/litmus-tests/.gitignore | 2 +-
 tools/memory-model/scripts/runlitmus.sh    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/litmus-tests/.gitignore b/tools/memory-model/litmus-tests/.gitignore
index f47cb2045f13..848e62d2a9b3 100644
--- a/tools/memory-model/litmus-tests/.gitignore
+++ b/tools/memory-model/litmus-tests/.gitignore
@@ -1 +1 @@
-*.out
+*.litmus.*
diff --git a/tools/memory-model/scripts/runlitmus.sh b/tools/memory-model/scripts/runlitmus.sh
index c84124b32bee..62b47c7e1ba9 100755
--- a/tools/memory-model/scripts/runlitmus.sh
+++ b/tools/memory-model/scripts/runlitmus.sh
@@ -69,7 +69,7 @@ fi
 
 # Generate the assembly code and run herd7 on it.
 gen_theme7 -n 10 -map $mapfile -call Linux.call > $themefile
-jingle7 -theme $themefile $litmus > $T/$hwlitmusfile 2> $T/$hwlitmusfile.jingle7.out
-/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $T/$hwlitmusfile > $LKMM_DESTDIR/$hwlitmus.out 2>&1
+jingle7 -theme $themefile $litmus > $LKMM_DESTDIR/$hwlitmus 2> $T/$hwlitmusfile.jingle7.out
+/usr/bin/time $LKMM_TIMEOUT_CMD herd7 -model $catfile $LKMM_DESTDIR/$hwlitmus > $LKMM_DESTDIR/$hwlitmus.out 2>&1
 
 exit $?
-- 
2.17.1
