From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 04/18] csum_and_copy_..._user(): pass 0xffffffff instead
 of 0 as initial sum
Date: Thu, 23 Jul 2020 16:21:01 +0100
Message-ID: <20200723152101.GI2786714@ZenIV.linux.org.uk>
References: <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
 <20200721202549.4150745-4-viro@ZenIV.linux.org.uk>
 <2d85ebb8ea2248c8a14f038a0c60297e@AcuMS.aculab.com>
 <20200722144213.GE2786714@ZenIV.linux.org.uk>
 <4e03cce8ed184d40bb0ea40fd3d51000@AcuMS.aculab.com>
 <20200722155452.GF2786714@ZenIV.linux.org.uk>
 <a55679c8d4dc4fb08d1e1782b5fc572c@AcuMS.aculab.com>
 <20200722173903.GG2786714@ZenIV.linux.org.uk>
 <02938acd78fd40beb02ffc5a1b803d85@AcuMS.aculab.com>
 <20200723145342.GH2786714@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgGWPVE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 11:21:04 -0400
Content-Disposition: inline
In-Reply-To: <20200723145342.GH2786714@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Thu, Jul 23, 2020 at 03:53:42PM +0100, Al Viro wrote:

> Said that, what you've printed for 1-byte segments (and that's going to be
> seriously affected by the setup costs in csum-copy.S, sensitive to calling
> convention changes) is time to run the 16-iteration loop divided by 1 * 16 / 8;
> IOW, your difference for 16 iterations here is 37*2 = 74 cycles.  With
> per-iteration diff being a bit under 5 cycles.  Which is not implausible,
> but
> 	1) extrapolating to other compiler versions, flags, etc. is not obvious
> 	2) the effects of calling convention changes need to be taken into account
> 	3) for copying to/from userland the effects of calling convention changes
> are be even larger, and kernel is certainly not going to issue kvec iters of _that_
> sort, TYVM.

To clarify it a bit: the effects of calling conventions change are mostly due
to not passing (and saving) those error pointers, and that could be had with
"pass the initial sum in" - just start these iov_iter.c loops with sum = ~0U
and we get the same warranties re not getting 0 in absence of faults.

The point is, your "~4.5 cycles per vector" is pretty much noise and the
difference between the 3-argument and 4-argument variants could easily be
in the same range.  It might be a valid microoptimization, it might be not.
3-argument variant is simpler and IMO in absence of strong data we ought
to go with that.
