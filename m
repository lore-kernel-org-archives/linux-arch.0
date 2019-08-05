Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44634 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727830AbfHESJd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Aug 2019 14:09:33 -0400
Message-ID: <1565028568.15050.7.camel@HansenPartnership.com>
Subject: Re: [PATCH] MAINTAINERS: Update e-mail address for Andrea Parri
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 05 Aug 2019 11:09:28 -0700
In-Reply-To: <20190805174355.GJ28441@linux.ibm.com>
References: <20190805121517.4734-1-parri.andrea@gmail.com>
         <76010b66-a662-5b07-a21d-ed074d7d2194@gmail.com>
         <20190805151545.GA1615@aparri>
         <1565018618.3341.6.camel@HansenPartnership.com>
         <20190805174355.GJ28441@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.ibm.com
Cc: Andrea Parri <parri.andrea@gmail.com>, Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190805180928.6lQ19a7R62nPhlEf7Fh5S4SER3i9CqPwhbOA0HFc3ys@z>

On Mon, 2019-08-05 at 10:43 -0700, Paul E. McKenney wrote:
> On Mon, Aug 05, 2019 at 08:23:38AM -0700, James Bottomley wrote:
> > On Mon, 2019-08-05 at 17:15 +0200, Andrea Parri wrote:
> > > > Why don't you also add an entry in .mailmap as Will did in
> > > > commit
> > > > c584b1202f2d ("MAINTAINERS: Update my email address to use
> > > > @kernel.org")?
> > > 
> > > I considered it but could not understand its purpose...  Maybe
> > > you can explain it to me?  ;-) (can resend with this change if
> > > needed/desired).
> > 
> > man git-shortlog gives you the gory detail, but its use is to
> > "coalesce together commits by the same person in the shortlog,
> > where their name and/or email address was spelled
> > differently."  The usual way this happens is that people have the
> > name that appears in the From field with and without initials.
> 
> New one on me, thank you!  So I should have a line in .mailmap like
> this?
> 
> Paul E. McKenney <paulmck@linux.vnet.ibm.com> <paul.mckenney@linaro.o
> rg> <paulmck@linux.ibm.com>

Well, you could, but there's no need.  As long as your email has 'Paul
E. McKenney' as the text prefix, git-shortlog will do the correct
aggregation without any need for a .mailmap entry.  However, if, say,
your linaro email had been

Paul McKenney <paul.mckenney@linaro.com>

Then you would need one because git-shortlog would think 'Paul
McKenney' and 'Paul E. McKenney' were two different people.

James
