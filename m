Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:51184 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757438AbXHHPUN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Aug 2007 11:20:13 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Add ability to print calltraces tighter on i386
Date: Wed, 8 Aug 2007 17:20:08 +0200
References: <46B9D08F.8080402@openvz.org> <p73zm12qc8a.fsf@bingen.suse.de> <46B9DCAE.4010009@openvz.org>
In-Reply-To: <46B9DCAE.4010009@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708081720.09034.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Pavel Emelyanov <xemul@openvz.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devel@openvz.org
List-ID: <linux-arch.vger.kernel.org>


> Not everyone likes frame buffer

You don't need the frame buffer; cards typically have text mode
fonts upto 80x50. The node numbers vary, but you can find out yours
with vga=ask

> but even with it any OOPs in  
> network code which happens in softirq, io scheduler and nearby 
> code that is called after passing through all the VFS hooks 
> and many other examples produce long oopses.
> 
> Oops-es with only the calltrace of ~50 lines do happen :)

Normally most of it bogus. I had hoped to address this with the dwarf2
unwinder, which tends to filter them out nicely,
but Linus unfortunately has developed an quite irrational aversion against it and 
it's not in.

But the problem is with bogus entries in there you have no guarantee
that the first of your call trace is any useful -- it might be all bogus.
So i don't really think your option makes much sense.

Another way would be to not dump addresses and use multiple entries
per line again. I guess that would make more sense as an option.

-Andi
