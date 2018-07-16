From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 13/14] memory-model/Documentation: Fix typo, smb->smp
Date: Mon, 16 Jul 2018 11:06:04 -0700
Message-ID: <20180716180605.16115-13-paulmck@linux.vnet.ibm.com>
References: <20180716180540.GA14222@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716180540.GA14222@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Yauheni Kaliuta <yauheni.kaliuta@redhat.com>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>

The tools/memory-model/Documentation/explanation.txt file says
"For each other CPU C', smb_wmb() forces all po-earlier stores"
This commit therefore replaces the "smb_wmb()" with "smp_wmb()".

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 tools/memory-model/Documentation/explanation.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 1b09f3175a1f..0cbd1ef8f86d 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -804,7 +804,7 @@ type of fence:
 Second, some types of fence affect the way the memory subsystem
 propagates stores.  When a fence instruction is executed on CPU C:
 
-	For each other CPU C', smb_wmb() forces all po-earlier stores
+	For each other CPU C', smp_wmb() forces all po-earlier stores
 	on C to propagate to C' before any po-later stores do.
 
 	For each other CPU C', any store which propagates to C before
-- 
2.17.1
