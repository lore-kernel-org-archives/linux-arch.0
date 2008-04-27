Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:43544 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755824AbYD0SAL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 Apr 2008 14:00:11 -0400
Date: Sun, 27 Apr 2008 14:00:07 -0400
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
	architectures
Message-ID: <20080427180007.GB28483@infradead.org>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org> <20080427172235.GA2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org> <20080427174714.GB2252@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080427174714.GB2252@cs181133002.pp.htv.fi>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>
Message-ID: <20080427180007.9N1gC_ANNEbSbFZ1qtFRnHDRP97J3jmnaflb486fn1Y@z>

On Sun, Apr 27, 2008 at 08:47:14PM +0300, Adrian Bunk wrote:
> What I want instead:
> - we continue to force the compiler to always inline with "inline"
> - we remove the inline's in .c files and make too big functions in 
>   headers out-of-line

It doesn't matter whether we use inline or always_inline to force
inlining of a function, that's just syntactical sugar.  What is rather
annoying is that with the config option we'd have something marked
inline without actually meaning it's inline.  And what's even worse
is that this is depending on a user-visible config option which is
entirely stupid.
