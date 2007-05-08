Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:50169 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967080AbXEHVH6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2007 17:07:58 -0400
Received: from blonde.wat.veritas.com([10.10.97.163]) (1541 bytes) by megami.veritas.com
	via sendmail with P:esmtp/R:smart_host/T:smtp
	(sender: <hugh@veritas.com>)
	id <m1HlVyz-0000MYC@megami.veritas.com>
	for <linux-arch@vger.kernel.org>; Tue, 8 May 2007 13:08:25 -0700 (PDT)
	(Smail-3.2.0.101 1997-Dec-17 #15 built 2001-Aug-30)
Date: Tue, 8 May 2007 21:08:09 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
Subject: Re: [rfc] optimise unlock_page
In-Reply-To: <20070508114003.GB19294@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0705082054500.18925@blonde.wat.veritas.com>
References: <20070508113709.GA19294@wotan.suse.de> <20070508114003.GB19294@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 8 May 2007, Nick Piggin wrote:

> This patch trades a page flag for a significant improvement in the unlock_page
> fastpath. Various problems in the previous version were spotted by Hugh and
> Ben (and fixed in this one).
> 
> Comments?

Seems there's still a bug there.  I get hangs on the page lock, on
i386 and on x86_64 and on powerpc: sometimes they unhang themselves
after a while (presume other activity does the wakeup).  Obvious even
while booting (Starting udevd).  Sorry, not had time to investigate.

Hugh
