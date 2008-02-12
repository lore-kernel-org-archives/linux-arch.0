Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:9279 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340AbYBLGV5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Feb 2008 01:21:57 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3570804rvb.1
        for <linux-arch@vger.kernel.org>; Mon, 11 Feb 2008 22:21:54 -0800 (PST)
Subject: Re: Announce: Linux-next (Or Andrew's dream :-))
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <20080211.221126.230471463.davem@davemloft.net>
References: <20080211203146.3d28d1a0@laptopd505.fenrus.org>
	 <20080212044314.GA4888@kroah.com>
	 <20080211211751.3e265754@laptopd505.fenrus.org>
	 <20080211.221126.230471463.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 11 Feb 2008 22:21:48 -0800
Message-Id: <1202797308.10004.41.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: arjan@infradead.org, greg@kroah.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org

On Mon, 2008-02-11 at 22:11 -0800, David Miller wrote:
> From: Arjan van de Ven <arjan@infradead.org>
> Date: Mon, 11 Feb 2008 21:17:51 -0800
> 
> > this is why you need specific trees for just the API change
> 
> API trees don't work, just like other changes they will have
> interdependencies on things like fixups, cleanups, etc.
> 
> This is why, with the networking, we've just tossed all of the network
> driver stuff in there too.  I can rebase freely, remove changesets,
> rework them, etc. and this causes a very low amount of pain for Jeff
> Garzik and John Linville.
> 
> This may or not be a legitimate thing to do with other heavily
> dependant subsystems.

I was hoping that eventually certain pieces will stop moving and will
become a base that we can ask people to rebase on top of.  Perhaps
even asking that stuff destined for 2.6.x+1 go into a -next branch
and the more devel quality stuff go into a -mm branch that is based
off of their -next branch.  Gradually stuff would move from -mm
to -next, getting constantly integrated against other peoples' stuff.

More disruptive changes could go in and gradually as people rebase their
trees the conflicts would hopefully get less painful.

But, let's see how things go.

Harvey

