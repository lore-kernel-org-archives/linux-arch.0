Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:43528 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755743AbYD0R6E (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 Apr 2008 13:58:04 -0400
Date: Sun, 27 Apr 2008 13:57:54 -0400
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
	architectures
Message-ID: <20080427175754.GA28483@infradead.org>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org> <20080427172235.GA2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adrian Bunk <bunk@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>
Message-ID: <20080427175754.Mc8xgKX0jaGk0-jjqZKnYULx80CBR2-3xOhvoFTfVAs@z>

On Sun, Apr 27, 2008 at 10:32:28AM -0700, Linus Torvalds wrote:
> Modern versions of gcc may do the right thing. Note the two very important 
> code-words: "modern" and "may".

It's even worse than that, that may not even get it right.  That's why
we need always_inline to force it when we know we need it.  Now for the
cases where we don't know know that we either need or really really
strongly want it we should just not mark it inline at all.

