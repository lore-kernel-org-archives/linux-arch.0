Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728800AbfHERoA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Aug 2019 13:44:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x75HgVZP089223
        for <linux-arch@vger.kernel.org>; Mon, 5 Aug 2019 13:43:58 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u6pek84d4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 05 Aug 2019 13:43:58 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 5 Aug 2019 18:43:58 +0100
Date: Mon, 5 Aug 2019 10:43:55 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: Update e-mail address for Andrea Parri
Reply-To: paulmck@linux.ibm.com
References: <20190805121517.4734-1-parri.andrea@gmail.com>
 <76010b66-a662-5b07-a21d-ed074d7d2194@gmail.com>
 <20190805151545.GA1615@aparri>
 <1565018618.3341.6.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565018618.3341.6.camel@HansenPartnership.com>
Message-ID: <20190805174355.GJ28441@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190805174355.gN6uR6Aopk5xxmBSENcFQkEm_OcvEUx1G5YVZHEOpuI@z>

On Mon, Aug 05, 2019 at 08:23:38AM -0700, James Bottomley wrote:
> On Mon, 2019-08-05 at 17:15 +0200, Andrea Parri wrote:
> > > Why don't you also add an entry in .mailmap as Will did in commit
> > > c584b1202f2d ("MAINTAINERS: Update my email address to use
> > > @kernel.org")?
> > 
> > I considered it but could not understand its purpose...  Maybe you
> > can explain it to me?  ;-) (can resend with this change if
> > needed/desired).
> 
> man git-shortlog gives you the gory detail, but its use is to "coalesce
> together commits by the same person in the shortlog, where their name
> and/or email address was spelled differently."  The usual way this
> happens is that people have the name that appears in the From field
> with and without initials.

New one on me, thank you!  So I should have a line in .mailmap like this?

Paul E. McKenney <paulmck@linux.vnet.ibm.com> <paul.mckenney@linaro.org> <paulmck@linux.ibm.com>

							Thanx, Paul
