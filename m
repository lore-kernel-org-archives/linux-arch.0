Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37430 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932888AbeCGR1O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2018 12:27:14 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w27HR7UQ088047
        for <linux-arch@vger.kernel.org>; Wed, 7 Mar 2018 12:27:14 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gjkd2350q-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 07 Mar 2018 12:27:13 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 7 Mar 2018 12:27:12 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 2/4] tools/memory-model: Remove mention of docker/gentoo image
Date: Wed,  7 Mar 2018 09:27:38 -0800
In-Reply-To: <1520443660-16858-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180307172627.GA15805@linux.vnet.ibm.com>
 <1520443660-16858-1-git-send-email-paulmck@linux.vnet.ibm.com>
Message-ID: <1520443660-16858-2-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180307172738.okfCQFC-mHE5MJnRA6LIbmrpoP8OPKR5xT4kSP8IZwI@z>

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
