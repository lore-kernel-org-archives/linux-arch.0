Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:49674 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbYC1MqE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Mar 2008 08:46:04 -0400
Date: Fri, 28 Mar 2008 06:46:03 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: down_spin() implementation
Message-ID: <20080328124603.GR16721@parisc-linux.org>
References: <1FE6DD409037234FAB833C420AA843ECE9DF60@orsmsx424.amr.corp.intel.com> <20080327141508.GL16721@parisc-linux.org> <20080328155107.e9d8866c.sfr@canb.auug.org.au> <200803281603.34134.nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200803281603.34134.nickpiggin@yahoo.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "Luck, Tony" <tony.luck@intel.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20080328124603.6cB-KRumoxO6zeqyLvtB1Wdd1PP6zGvAokb-P3lm5cQ@z>

On Fri, Mar 28, 2008 at 04:03:33PM +1100, Nick Piggin wrote:
> On Friday 28 March 2008 15:51, Stephen Rothwell wrote:
> > Hi Willy,
> >
> > On Thu, 27 Mar 2008 08:15:08 -0600 Matthew Wilcox <matthew@wil.cx> wrote:
> > > Stephen, I've updated the 'semaphore' tag to point ot the same place as
> > > semaphore-20080327, so please change your linux-next tree from pulling
> > > semaphore-20080314 to just pulling plain 'semaphore'.  I'll use this
> > > method of tagging from now on.
> >
> > Thanks. I read this to late for today's tree, but I will fix it up for
> > the next one.
> 
> Please don't add this nasty code to semaphore.
> 
> Did my previous message to the thread get eaten by spam filters?

It didn't arrive until after Stephen's message (but it did arrive before
this one).

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
