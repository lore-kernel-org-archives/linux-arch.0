From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 1/19] untangling do_mremap(), part 1
Date: Mon, 7 Dec 2009 19:43:05 +0000
Message-ID: <20091207194305.GJ14381@ZenIV.linux.org.uk>
References: <E1NHUdk-0007ul-Oc@ZenIV.linux.org.uk> <alpine.LFD.2.00.0912070911290.3560@localhost.localdomain> <20091207184438.GH14381@ZenIV.linux.org.uk> <alpine.LFD.2.00.0912071134300.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:38028 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932771AbZLGTm7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Dec 2009 14:42:59 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0912071134300.3560@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Dec 07, 2009 at 11:35:16AM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 7 Dec 2009, Al Viro wrote:
> > 
> > Which David? ;-)  All sparc-related bits seem to have been ACKed by
> > davem.
> 
> That's the David I meant. I've seen the ack, but the acks weren't actually 
> quoted in your latest series.

Hugh had just caught a lovely piece of idiocy in do_brk() patch; that
call of get_unmapped_area() in there should take MAP_FIXED, not
MAP_FIXED | flags.  Harmless (we do get MAP_FIXED anyway and the only
other flag that gets looked at by methods is MAP_SHARED, which is
ignored when file is NULL), but definitely bogus.

I'll fix that before sending a pull request.
