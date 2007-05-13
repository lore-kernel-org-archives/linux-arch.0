Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:59296 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403AbXEMEj0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 13 May 2007 00:39:26 -0400
Received: from [172.21.56.4]([172.21.56.4]) (2046 bytes) by megami.veritas.com
	via sendmail with P:esmtp/R:smart_host/T:smtp
	(sender: <hugh@veritas.com>)
	id <m1Hn5rg-0000MYC@megami.veritas.com>
	for <linux-arch@vger.kernel.org>; Sat, 12 May 2007 21:39:24 -0700 (PDT)
	(Smail-3.2.0.101 1997-Dec-17 #15 built 2001-Aug-30)
Date: Sun, 13 May 2007 05:39:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
Subject: Re: [rfc] optimise unlock_page
In-Reply-To: <20070513033210.GA3667@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0705130535410.3015@blonde.wat.veritas.com>
References: <20070508113709.GA19294@wotan.suse.de> <20070508114003.GB19294@wotan.suse.de>
 <1178659827.14928.85.camel@localhost.localdomain> <20070508224124.GD20174@wotan.suse.de>
 <20070508225012.GF20174@wotan.suse.de> <Pine.LNX.4.64.0705091950080.2909@blonde.wat.veritas.com>
 <20070510033736.GA19196@wotan.suse.de> <Pine.LNX.4.64.0705101935590.18496@blonde.wat.veritas.com>
 <20070511085424.GA15352@wotan.suse.de> <Pine.LNX.4.64.0705111357120.3350@blonde.wat.veritas.com>
 <20070513033210.GA3667@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>
List-ID: <linux-arch.vger.kernel.org>

On Sun, 13 May 2007, Nick Piggin wrote:
> On Fri, May 11, 2007 at 02:15:03PM +0100, Hugh Dickins wrote:
> 
> > Hmm, well, I think that's fairly horrid, and would it even be
> > guaranteed to work on all architectures?  Playing with one char
> > of an unsigned long in one way, while playing with the whole of
> > the unsigned long in another way (bitops) sounds very dodgy to me.
> 
> Of course not, but they can just use a regular atomic word sized
> bitop. The problem with i386 is that its atomic ops also imply
> memory barriers that you obviously don't need on unlock.

But is it even a valid procedure on i386?

Hugh
