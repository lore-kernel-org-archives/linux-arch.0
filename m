Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42450 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933653AbeE2McY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 May 2018 08:32:24 -0400
Received: by mail-wr0-f194.google.com with SMTP id w10-v6so25224631wrk.9
        for <linux-arch@vger.kernel.org>; Tue, 29 May 2018 05:32:23 -0700 (PDT)
Date: Tue, 29 May 2018 14:32:16 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH RFC tools/memory-model] Add litmus-test naming scheme
Message-ID: <20180529123216.GA11608@andrea>
References: <20180525191020.GA5914@linux.vnet.ibm.com>
 <20180528112010.GA8801@andrea>
 <20180528214838.GZ3803@linux.vnet.ibm.com>
 <20180529093350.GA5803@andrea>
 <20180529121941.GG3803@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529121941.GG3803@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, mingo@kernel.org
Message-ID: <20180529123216.8z0HcqfeGjZUHFxzcXOrGp0PiEExKXFnnwN_K1-QrIg@z>

[...]

> > Right, thanks.  Ah, maybe we should strive to meet the 80-chars bound
> > by splitting the command with "\"?
> 
> We could, but combined with your later request for indentation, we end
> up with something like this:
> 
> 	$ norm7 -bell linux-kernel.bell \
> 		Rfi Once PodRR Once Fre Once Rfi Once PodRR Once Fre Once | \
> 	  sed -e 's/:.*//g'
> 	SB+rfionceonce-poonceonces
> 
> In the immortal words of MSDOS, are you sure?  ;-)

I find it more readable, but it's just taste ;-)  Commands are indented
with 2 spaces in the other README.


> > Well, "Rfi" produces "rfi" while "PosWR" produces "pos" for a name...
> 
> Right you are!  How about this, then?
> 
> Rfi: Read-from internal.  The current process wrote a variable and then
>         immediately read the value back from it.  For the purposes of
>         litmus-test code generation, Rfi acts identically to PosWR.
>         However, they differ for purposes of naming, and they also result
>         in different "exists" clauses.
> 	Example:  ???

LGTM, thanks.

  Andrea
