Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:55598 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753886AbXHJXwW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Aug 2007 19:52:22 -0400
Date: Sat, 11 Aug 2007 01:52:07 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [patch 47/59] x86: optimize page faults like all other achitectures and kill notifier cruft
Message-ID: <20070810235207.GA28512@lst.de>
References: <200708102200.l7AM0CnU011952@imap1.linux-foundation.org> <200708110117.34171.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200708110117.34171.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: akpm@linux-foundation.org, hch@lst.de, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org, prasanna@in.ibm.com
List-ID: <linux-arch.vger.kernel.org>

Sorry, but this is not your call Andi.  x86 is updated to what every
other architecture does and is 100% more sensible.  These stupid hooks
aren't used either by the debugger on track into mainline (kgdb),
already in mainline (xmon) or even just commonly used (kdb), if there's
any use it's the novell piece of junk dbeugger that no one uses at
all.  Not to fortget our policy not to add exports for out of tree junk.

I'm not going to let all this crappy and uneeded code rot in kprobes.c
just because you disagree with everyone else.
