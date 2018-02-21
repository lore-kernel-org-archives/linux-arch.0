Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753175AbeBUQQN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Feb 2018 11:16:13 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1LGFaIq087993
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2018 11:16:12 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2g99qxy18x-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2018 11:15:58 -0500
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 21 Feb 2018 11:15:31 -0500
Date: Wed, 21 Feb 2018 08:15:50 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/lkmm 09/12] tools/memory-model: Add required
 herd7 version to README file
Reply-To: paulmck@linux.vnet.ibm.com
References: <1519169112-20593-9-git-send-email-paulmck@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1802211009110.2032-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802211009110.2032-100000@iolanthe.rowland.org>
Message-Id: <20180221161550.GF3617@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com

On Wed, Feb 21, 2018 at 10:10:52AM -0500, Alan Stern wrote:
> On Tue, 20 Feb 2018, Paul E. McKenney wrote:
> 
> > LKMM and the herd7 tool are co-evolving, and out-of-date herd7 tools
> > produce inaccurate results, often with no obvious error messages.  This
> > commit therefore adds the required herd7 version to the LKMM README file.
> > 
> > Longer term, it would be good if .cat files could specify the required
> > version in a manner allowing herd7 to produce clear diagnostics.
> > 
> > Suggested-by: Akira Yokosawa <akiyks@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  tools/memory-model/README | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/memory-model/README b/tools/memory-model/README
> > index 91414a49fac5..ea950c566ffd 100644
> > --- a/tools/memory-model/README
> > +++ b/tools/memory-model/README
> > @@ -20,7 +20,8 @@ that litmus test to be exercised within the Linux kernel.
> >  REQUIREMENTS
> >  ============
> >  
> > -The "herd7" and "klitmus7" tools must be downloaded separately:
> > +Version 7.48 of the "herd7" and "klitmus7" tools must be downloaded
> > +separately:
> >  
> >    https://github.com/herd/herdtools7
> 
> The text immediately below this mentions the Docker image and gentoo
> package.  Aren't they both seriously out of date at this point?  In
> which case, shouldn't we remove them from the README?

Agreed, we should.  How about the following?

							Thanx, Paul

------------------------------------------------------------------------

commit b59fd89b465f0bfbfe06bf47e22c0cf160aef66b
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Wed Feb 21 08:13:48 2018 -0800

    tools/memory-model: Remove mention of docker/gentoo image
    
    Because the docker and gentoo images haven't been updated in quite some
    time, they are likely to provide more confusion than help.  This commit
    therefore removes mention of them from the README file.
    
    Reported-by: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

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
