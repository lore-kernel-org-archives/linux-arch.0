Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:4579 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751633AbWITPdp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Sep 2006 11:33:45 -0400
Date: Wed, 20 Sep 2006 09:33:44 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: generic__raw_read_trylock Considered Harmful
Message-ID: <20060920153344.GI2585@parisc-linux.org>
References: <20060831134254.GE4919@parisc-linux.org> <20060919.155317.22126004.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060919.155317.22126004.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, takata@linux-m32r.org, lethal@linux-sh.org, kkojima@rr.iij4u.or.jp, linuxsh-dev@lists.sourceforge.net, wli@holomorphy.com, sparclinux@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 19, 2006 at 03:53:17PM -0700, David Miller wrote:
> From: Matthew Wilcox <matthew@wil.cx>
> > NOTE to architecture maintainers: generic_raw_read_trylock() is
> > completely unfit for use and will cause lockups if used in interrupt
> > context.
> 
> I was about to go an fix SPARC but then looked in the tree
> for actual users, and I see one, and only one, in the lockdep
> code which tries to grab the tasklist_lock.
> 
> That's it (well.. there's one strange IA64 specific case in the MCA
> code too).
> 
> You say you were fixing up PARISC and actually hit this problem, was
> it exactly this lockdep case?  I really doubt it...

That's not quite what I said; I was chasing some problems on parisc
where we were getting read_lock deadlocks, and spotted this problem.
It's not beyond the bounds of possibility that we'll have a real user
for this function in the future.

The real bug was almost certainly elsewhere:

http://git.parisc-linux.org/?p=linux-2.6.git;a=commit;h=513b38677e9bb51d32f4cb401105bf828dfcd685
http://git.parisc-linux.org/?p=linux-2.6.git;a=commit;h=93d8d8dff74923dc9eb511c96ee3ccb918666049

Essentially, a fix for one rather subtle bug introduced a somewhat less
subtle one (which nevertheless went unfound for, er, 11 months ;-)

