From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH memory-model] Add recent references
Date: Sun, 16 Feb 2020 12:01:14 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.2002161158140.30459-100000@netrider.rowland.org>
References: <20200214233139.GA12521@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:60851 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728386AbgBPRBP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Feb 2020 12:01:15 -0500
In-Reply-To: <20200214233139.GA12521@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com

On Fri, 14 Feb 2020, Paul E. McKenney wrote:

> This commit updates the list of LKMM-related publications in
> Documentation/references.txt.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

>  o	Paul E. McKenney, Ulrich Weigand, Andrea Parri, and Boqun
> -	Feng. 2016. "Linux-Kernel Memory Model". (6 June 2016).
> -	http://open-std.org/JTC1/SC22/WG21/docs/papers/2016/p0124r2.html.
> +	Feng. 2018. "Linux-Kernel Memory Model". (27 September 2018).
> +	http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0124r6.html.

Even though this is an update, the new version referenced here is
already out-of-date (in particular, with regard to its discussions of 
the ordering properties of unlock-lock sequences as viewed by threads 
not holding the lock).  And it contains a few typos scattered 
throughout.

Alan
