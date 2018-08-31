Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f42.google.com ([209.85.221.42]:40545 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeHaWhn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Aug 2018 18:37:43 -0400
Received: by mail-wr1-f42.google.com with SMTP id n2-v6so12043495wrw.7
        for <linux-arch@vger.kernel.org>; Fri, 31 Aug 2018 11:29:00 -0700 (PDT)
Date: Fri, 31 Aug 2018 20:28:46 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20180831182845.GA4673@andrea>
References: <20180831091641.GA3634@andrea>
 <Pine.LNX.4.44L0.1808311042340.4901-100000@netrider.rowland.org>
 <20180831160640.GG30626@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831160640.GG30626@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180831182846.aabhH-JzCN42spIS6ZWJxYasv4CONlv3xWEU75EFrWY@z>

> > Yes, it's true that implementing locks with atomic_cmpxchg_acquire 
> > should be correct on all existing architectures.  And Paul has invited 
> > a patch to modify the LKMM accordingly.  If you feel that such a change 
> > would be a useful enhancement to the LKMM's applicability, please write 
> > it.
> 
> Yes, please! That would be the "RmW" discussion which Andrea partially
> quoted earlier on, so getting that going independently from this patch
> sounds like a great idea to me.

That was indeed one of the proposal we discussed.  As you recalled, that
proposal only covered RmWs load-acquire (and ordinary store-release); in
particular, I realized that comments such as:

  "The atomic_cond_read_acquire() call above has provided the
   necessary acquire semantics required for locking."

   [from kernel/locking/qspinlock.c]

(for example)  would still _not have "generic validity" _if we added the
above po-unlock-rf-lock-po term... (which, again, makes me somehow uncon-
fortable);  Would to have _all_ the acquire be admissible for you?

  Andrea


> 
> Cheers,
> 
> Will
