Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38183 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbeIELux (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Sep 2018 07:50:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id h33-v6so5228954edb.5
        for <linux-arch@vger.kernel.org>; Wed, 05 Sep 2018 00:22:02 -0700 (PDT)
Date: Wed, 5 Sep 2018 09:21:51 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20180905072151.GA3185@andrea>
References: <20180904081144.GA4137@andrea>
 <Pine.LNX.4.44L0.1809041503470.17060-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1809041503470.17060-100000@netrider.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180905072151.wbVZjL1DV-eV6oq0xiIzIVUlAOh2OAF03QX3djh6wAo@z>

On Tue, Sep 04, 2018 at 03:09:49PM -0400, Alan Stern wrote:
> On Tue, 4 Sep 2018, Andrea Parri wrote:
> > Heh, your confusion might be the reflection of mine... ;-)  That was
> > indeed a long and not conclusive discussion (meaning there're pending
> > issues); and I cannot claim to find "arguments" such as:
> > 
> >   "More than one kernel developer has expressed the opinion that
> >    the LKMM should enforce ordering of writes by locking."
> > 
> > particularly helpful (I do tend to be convinced by arguments rather
> > than by opinions).  In fact, you can take the following as my only
> > current "constructive argument" against the patch [1,2]:
> > 
> >   THE COMMIT MESSAGE IS RIDICULOUS; PLEASE EXPAND ON IT, AND DO
> >   SO BY LEVERAGING BOTH PROS AND CONS OF THE APPLIED CHANGES
> 
> Do you have any concrete suggestions (i.e., some actual text) for 
> improvements to the patch description?  Earlier in your message you 
> mentioned that Will's comment:
> 
> 	LKMM offers stronger guarantees that can portably be relied upon
> 	in the codebase.
> 
> would make a good addition.  Suitably edited, it could be added to the
> description.  I can think of a few other things myself, but I'd like to 
> hear your thoughts.  Anything else?

Yes: I do sometimes have the impression that your "rules" for trimming
text in emails/replies are too aggressive...

  Andrea


> 
> Alan
> 
