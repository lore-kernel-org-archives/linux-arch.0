Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40558 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfHEQVK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Aug 2019 12:21:10 -0400
Date: Mon, 5 Aug 2019 18:21:00 +0200
From: Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update e-mail address for Andrea Parri
Message-ID: <20190805162100.GA2368@aparri>
References: <20190805121517.4734-1-parri.andrea@gmail.com>
 <76010b66-a662-5b07-a21d-ed074d7d2194@gmail.com>
 <20190805151545.GA1615@aparri>
 <1565018618.3341.6.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565018618.3341.6.camel@HansenPartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190805162100.5Vminqm9ZylKvYo1_UYpAYnZB4lf4VGLAanAqiQVtJE@z>

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

Thanks for the remarks, James.  Given this, I'm okay with the submitted
version (i.e., no change to .mailmap).

  Andrea
