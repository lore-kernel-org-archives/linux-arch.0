Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:36317 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727692AbeIDXgS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Sep 2018 19:36:18 -0400
Date: Tue, 4 Sep 2018 15:09:49 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
In-Reply-To: <20180904081144.GA4137@andrea>
Message-ID: <Pine.LNX.4.44L0.1809041503470.17060-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180904190949.RZOmW1i88gFsdrDjvAu--rsSZinxUFPdgdbIUirBU0c@z>

On Tue, 4 Sep 2018, Andrea Parri wrote:
> Heh, your confusion might be the reflection of mine... ;-)  That was
> indeed a long and not conclusive discussion (meaning there're pending
> issues); and I cannot claim to find "arguments" such as:
> 
>   "More than one kernel developer has expressed the opinion that
>    the LKMM should enforce ordering of writes by locking."
> 
> particularly helpful (I do tend to be convinced by arguments rather
> than by opinions).  In fact, you can take the following as my only
> current "constructive argument" against the patch [1,2]:
> 
>   THE COMMIT MESSAGE IS RIDICULOUS; PLEASE EXPAND ON IT, AND DO
>   SO BY LEVERAGING BOTH PROS AND CONS OF THE APPLIED CHANGES

Do you have any concrete suggestions (i.e., some actual text) for 
improvements to the patch description?  Earlier in your message you 
mentioned that Will's comment:

	LKMM offers stronger guarantees that can portably be relied upon
	in the codebase.

would make a good addition.  Suitably edited, it could be added to the
description.  I can think of a few other things myself, but I'd like to 
hear your thoughts.  Anything else?

Alan
