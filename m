Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:28675 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbYC1NYP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 28 Mar 2008 09:24:15 -0400
Date: Fri, 28 Mar 2008 14:24:10 +0100
From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: down_spin() implementation
Message-ID: <20080328132410.GM12346@kernel.dk>
References: <1FE6DD409037234FAB833C420AA843ECE9DF60@orsmsx424.amr.corp.intel.com> <20080326123239.GG16721@parisc-linux.org> <1FE6DD409037234FAB833C420AA843ECE9EB1C@orsmsx424.amr.corp.intel.com> <20080327141508.GL16721@parisc-linux.org> <20080328125104.GK12346@kernel.dk> <20080328131750.GT16721@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080328131750.GT16721@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: "Luck, Tony" <tony.luck@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20080328132410.xC6WGn3PRIZ0kMSYfVs6_44UsrWxM2Tgzoh_kl5qxRE@z>

On Fri, Mar 28 2008, Matthew Wilcox wrote:
> On Fri, Mar 28, 2008 at 01:51:04PM +0100, Jens Axboe wrote:
> > It used to be illegal to pass flags as parameters. IIRC, sparc did some
> > trickery with it. That may still be the case, I haven't checked in a
> > long time.
> 
> That problem was removed before 2.6 started, iirc.  At least the chapter
> on 'The Fucked Up Sparc' [1] was removed before 2.6.12-rc2 (the
> beginning of git history and I can't be bothered to pinpoint it more
> precisely).

OK

> > Why not just fold __down_spin() into down_spin() and get rid of that
> > nasty anyway?
> 
> Could have done.  It's moot now that Nick's pointed out how unsafe it
> is to mix down_spin() with plain down().
> 
> [1] http://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/x467.html

Yeah saw that after replying, so no problem then :)

-- 
Jens Axboe

