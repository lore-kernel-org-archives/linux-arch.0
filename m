From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 2/4] tools/memory-model: Remove mention of docker/gentoo image
Date: Wed,  7 Mar 2018 09:27:38 -0800
Message-ID: <1520443660-16858-2-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180307172627.GA15805@linux.vnet.ibm.com>
 <1520443660-16858-1-git-send-email-paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520443660-16858-1-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

Because the docker and gentoo images haven't been updated in quite some
time, they are likely to provide more confusion than help.  This commit
therefore removes mention of them from the README file.

Reported-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/README | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index ea950c566ffd..0b3a5f3c9ccd 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -27,21 +27,6 @@ separately:
 
 See "herdtools7/INSTALL.md" for installation instructions.
 
-Alternatively, Abhishek Bhardwaj has kindly provided a Docker image
-of these tools at "abhishek40/memory-model".  Abhishek suggests the
-following commands to install and use this image:
-
-  - Users should install Docker for their distribution.
-  - docker run -itd abhishek40/memory-model
-  - docker attach <id-emitted-from-the-previous-command>
-
-Gentoo users might wish to make use of Patrick McLean's package:
-
-  https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-util/herdtools7
-
-These packages may not be up-to-date with respect to the GitHub
-repository.
-
 
 ==================
 BASIC USAGE: HERD7
-- 
2.5.2
