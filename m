Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:46795 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966847AbeE2VQg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 May 2018 17:16:36 -0400
MIME-Version: 1.0
References: <20180529190332.GO3803@linux.vnet.ibm.com> <Pine.LNX.4.44L0.1805291521570.1458-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1805291521570.1458-100000@iolanthe.rowland.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 29 May 2018 16:10:02 -0500
Message-ID: <CA+55aFzYca7EBTEbhJMoJcGspVGhmty243WQR_w7Eykmw9HX9w@mail.gmail.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, andrea.parri@amarulasolutions.com, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nick Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Ingo Molnar <mingo@kernel.org>, Roman Pen <roman.penyaev@profitbricks.com>
Message-ID: <20180529211002.Lqthfs_qqHRg71bRfmPMlelgGljSD4Lc6o9lTu0TUgo@z>

On Tue, May 29, 2018 at 3:49 PM Alan Stern <stern@rowland.harvard.edu>
wrote:

> Putting this into herd would be extremely difficult, if not impossible,
> because it involves analyzing code that was not executed.

Does it?

Can't we simplify the whole sequence as basically

     A
     if (!B)
         D

for that "not B" case, and just think about that. IOW, let's ignore the
whole "not executed" code.

If B depends on A like you state, then that already implies that the write
in D cannot come before the read of A.

You fundamentally cannot do a conditional write before the read that the
write condition depends on. So *any* write after a conditional is dependent
on the read.

So the existence of C - whether it has a barrier or not - is entirely
immaterial at run-time.

Now, the *compiler* can use the whole existence of that memory barrier in C
to determine whether it can re-order the write to D or not, of course, but
that's a separate issue, and then the whole "code that isn't executed" is
not the issue any more. The compiler obviously sees all code, whether
executing or not.

Or am I being stupid and missing something entirely? That's possible.

               Linus
