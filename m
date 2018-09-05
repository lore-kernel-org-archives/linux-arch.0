From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Date: Wed, 5 Sep 2018 17:24:18 +0200
Message-ID: <20180905152418.GA8874@andrea>
References: <20180904081144.GA4137@andrea>
 <Pine.LNX.4.44L0.1809041503470.17060-100000@netrider.rowland.org>
 <20180905072151.GA3185@andrea>
 <50f0a7a7-0521-f833-34c3-132ce57dd777@gmail.com>
 <20180905150042.GA8820@andrea>
 <e8dbdd89-ff65-31ea-8d04-7e84b64a98b0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e8dbdd89-ff65-31ea-8d04-7e84b64a98b0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr
List-Id: linux-arch.vger.kernel.org

> >>>> Do you have any concrete suggestions (i.e., some actual text) for 
> >>>> improvements to the patch description?  Earlier in your message you 
> >>>> mentioned that Will's comment:
> >>>>
> >>>> 	LKMM offers stronger guarantees that can portably be relied upon
> >>>> 	in the codebase.
> >>>>
> >>>> would make a good addition.  Suitably edited, it could be added to the
> >>>> description.  I can think of a few other things myself, but I'd like to 
> >>>> hear your thoughts.  Anything else?
> >>>
> >>> Yes: I do sometimes have the impression that your "rules" for trimming
> >>> text in emails/replies are too aggressive...
> >>
> >> Andrea, by saying "Yes:", do you mean you have something else to be added?
> > 
> > Indeed (examples in the trimmed text).

"examples" of "concrete suggestions" (pros or cons) to amend the log.


> 
> So, you mean just amending commit log does not work for you?

I can't really answer this...; let's see the revisited log first.

  Andrea


> 
> > 
> > 
> >> I don't think you do, but want to make sure.
> >>
> >> I'm a bit surprised to see all you wanted was the amendment of the
> >> commit log...
> > 
> > Well, I said that it was my only current constructive argument...
> 
> This thread is getting quite hard for me to follow...
> 
>    Akira
> 
> > 
> >   Andrea
> > 
> > 
> >>
> >>   Akira
> >>
> >>>
> >>>   Andrea
> >>>
> >>>
> >>>>
> >>>> Alan
> >>>>
> >>
> 
