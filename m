From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH memory-model] Add recent references
Date: Mon, 17 Feb 2020 11:12:45 -0800
Message-ID: <20200217191245.GV2935@paulmck-ThinkPad-P72>
References: <20200214233139.GA12521@paulmck-ThinkPad-P72>
 <Pine.LNX.4.44L0.2002161158140.30459-100000@netrider.rowland.org>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbgBQTMq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Feb 2020 14:12:46 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002161158140.30459-100000@netrider.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com

On Sun, Feb 16, 2020 at 12:01:14PM -0500, Alan Stern wrote:
> On Fri, 14 Feb 2020, Paul E. McKenney wrote:
> 
> > This commit updates the list of LKMM-related publications in
> > Documentation/references.txt.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> >  o	Paul E. McKenney, Ulrich Weigand, Andrea Parri, and Boqun
> > -	Feng. 2016. "Linux-Kernel Memory Model". (6 June 2016).
> > -	http://open-std.org/JTC1/SC22/WG21/docs/papers/2016/p0124r2.html.
> > +	Feng. 2018. "Linux-Kernel Memory Model". (27 September 2018).
> > +	http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0124r6.html.
> 
> Even though this is an update, the new version referenced here is
> already out-of-date (in particular, with regard to its discussions of 
> the ordering properties of unlock-lock sequences as viewed by threads 
> not holding the lock).  And it contains a few typos scattered 
> throughout.

Indeed, 18 months is a long time for LKMM, isn't it?  ;-)

Sounds like time to update it for the next meeting.  I of course would
welcome any notes you might have taken while going through it.

							Thanx, Paul
