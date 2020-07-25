From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Date: Sat, 25 Jul 2020 18:54:34 +0100
Message-ID: <20200725175434.GP2786714@ZenIV.linux.org.uk>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
 <CAHk-=wiYS3sHp9bvRn3KmkFKnK-Pb0ksL+-gRRHLK_ZjJqQf=w@mail.gmail.com>
 <CAHk-=wg4DXWjV0sHAk+5QGvkNqckJTBLLcse_U=AknqEf8r3pw@mail.gmail.com>
 <20200721211118.GB2786714@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgGYRyh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jul 2020 13:54:37 -0400
Content-Disposition: inline
In-Reply-To: <20200721211118.GB2786714@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Tue, Jul 21, 2020 at 10:11:18PM +0100, Al Viro wrote:

> Theoretically - sure.  I can post the full analysis of that stuff (starting
> with the proof that all instances of csum_partial() are OK in that respect,
> which takes care of the default instances, then instance-by-instance
> analysis of the rest); will need to collate the pieces, remove the actionable
> obscenities, etc., but I have done that analysis.  Made for rather unpleasant
> couple of weeks... ;-/

BTW, "full" in the above refers only to the cases were we do the switchover
from initial sum 0 to initial sum ~0U (csum_and_copy_..._user() and those
csum_partial_copy_nocheck() instances that share helpers with them).

However, now that I started to write that down I went to look at other
csum_partial_copy_nocheck() instances.  Turns out that c6x one is,
strictly speaking, broken - it works for all initial sum values the
kernel ever gives it, but you can come up with a combination of sum and
data that will return the wrong value.

The only reason we never hit it is that there's only one caller
(gone in this series) that ever passes non-zero, and that one caller
(icmp_push_reply()) can't get to the vulnerable values of initial sums
since on c6x the values of csum_partial_copy_nocheck() are initial_sum +
16bit unsigned, and initial sum in question is csum_add() of a csums of
fragments, possibly rotated 8 bits right.  And to get overflow in that
sucker you'd need 0xffff as the top halfword, so you'd need at least
257 fragments, including at least one at odd offset.  Which, AFAICS,
can't happen - all framing headers have even lengths.
