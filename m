Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389491AbfHAWVL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2019 18:21:11 -0400
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH RFC memory-model 01/31] tools/memory-model: Make scripts be executable
Date: Thu,  1 Aug 2019 15:20:26 -0700
Message-ID: <20190801222056.12144-1-paulmck@linux.ibm.com>
In-Reply-To: <20190801222026.GA11315@linux.ibm.com>
References: <20190801222026.GA11315@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190801222026.Tj-TPDEoijFOYrDox5Un4UzNHoPvehq0RTQ8xgnu8vw@z>

This commit simplifies life a bit by making all of the scripts in
tools/memory-model/scripts be executable.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/checkghlitmus.sh   | 0
 tools/memory-model/scripts/checklitmushist.sh | 0
 tools/memory-model/scripts/cmplitmushist.sh   | 0
 tools/memory-model/scripts/initlitmushist.sh  | 0
 tools/memory-model/scripts/judgelitmus.sh     | 0
 tools/memory-model/scripts/newlitmushist.sh   | 0
 tools/memory-model/scripts/parseargs.sh       | 0
 tools/memory-model/scripts/runlitmushist.sh   | 0
 8 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/memory-model/scripts/checkghlitmus.sh
 mode change 100644 => 100755 tools/memory-model/scripts/checklitmushist.sh
 mode change 100644 => 100755 tools/memory-model/scripts/cmplitmushist.sh
 mode change 100644 => 100755 tools/memory-model/scripts/initlitmushist.sh
 mode change 100644 => 100755 tools/memory-model/scripts/judgelitmus.sh
 mode change 100644 => 100755 tools/memory-model/scripts/newlitmushist.sh
 mode change 100644 => 100755 tools/memory-model/scripts/parseargs.sh
 mode change 100644 => 100755 tools/memory-model/scripts/runlitmushist.sh

diff --git a/tools/memory-model/scripts/checkghlitmus.sh b/tools/memory-model/scripts/checkghlitmus.sh
old mode 100644
new mode 100755
diff --git a/tools/memory-model/scripts/checklitmushist.sh b/tools/memory-model/scripts/checklitmushist.sh
old mode 100644
new mode 100755
diff --git a/tools/memory-model/scripts/cmplitmushist.sh b/tools/memory-model/scripts/cmplitmushist.sh
old mode 100644
new mode 100755
diff --git a/tools/memory-model/scripts/initlitmushist.sh b/tools/memory-model/scripts/initlitmushist.sh
old mode 100644
new mode 100755
diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
old mode 100644
new mode 100755
diff --git a/tools/memory-model/scripts/newlitmushist.sh b/tools/memory-model/scripts/newlitmushist.sh
old mode 100644
new mode 100755
diff --git a/tools/memory-model/scripts/parseargs.sh b/tools/memory-model/scripts/parseargs.sh
old mode 100644
new mode 100755
diff --git a/tools/memory-model/scripts/runlitmushist.sh b/tools/memory-model/scripts/runlitmushist.sh
old mode 100644
new mode 100755
-- 
2.17.1
