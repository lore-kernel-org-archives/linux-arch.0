Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933419AbeE2MJd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 May 2018 08:09:33 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4TC4ach124301
        for <linux-arch@vger.kernel.org>; Tue, 29 May 2018 08:09:33 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j93kqrdqg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 29 May 2018 08:09:32 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 29 May 2018 08:09:30 -0400
Date: Tue, 29 May 2018 05:11:07 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/memory-model] Add litmus-test naming scheme
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180525191020.GA5914@linux.vnet.ibm.com>
 <20180529093050.GB6533@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529093050.GB6533@arm.com>
Message-ID: <20180529121107.GF3803@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, mingo@kernel.org
Message-ID: <20180529121107.XQZvPhvd3HIsJvXsvpfr6u63QS9KWXzuZHv5EAOOwNY@z>

On Tue, May 29, 2018 at 10:30:50AM +0100, Will Deacon wrote:
> Hi Paul,
> 
> On Fri, May 25, 2018 at 12:10:20PM -0700, Paul E. McKenney wrote:
> > This commit documents the scheme used to generate the names for the
> > litmus tests.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  README |  136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 135 insertions(+), 1 deletion(-)
> 
> Whilst I think documentation like this is extremely important for users,
> this feels like it's documenting how to drive parts of diy and I'm not
> convinced that it belongs in the kernel source tree as long as the projects
> remain separate.
> 
> Why not contribute this to the herdtools7 documentation, then just reference
> that from here? That would also be helpful for other people interested in
> memory models, but perhaps not interested in Linux (assuming such people
> exist ;).

We would still need at least a pointer from the Linux kernel to that
documentation, but I am happy either way.  We probably need examples of
the common cases, but probably not a full exposition of all the available
herd7 edges.

Should this be in the herdtools7 documentation, or as added detail
from a variation on the "diyone7 -bell linux-kernel.bell -show edges"
command?  If the latter, I suppose that the ones coming from the .bell
file might simply be labelled as such.

							Thanx, Paul
