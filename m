Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4355 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423524AbXEATUs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 May 2007 15:20:48 -0400
Received: from flint.arm.linux.org.uk ([2002:d993:5cf9:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.62)
	(envelope-from <rmk@arm.linux.org.uk>)
	id 1Hixtx-0002hk-UZ
	for linux-arch@vger.kernel.org; Tue, 01 May 2007 20:20:44 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.62)
	(envelope-from <rmk@flint.arm.linux.org.uk>)
	id 1Hixtu-0007DH-BH
	for linux-arch@vger.kernel.org; Tue, 01 May 2007 20:20:38 +0100
Date: Tue, 1 May 2007 20:20:37 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: You might need vmalloc_sync_all()
Message-ID: <20070501192037.GD19872@flint.arm.linux.org.uk>
References: <20070501042655.GL25929@bingen.suse.de> <20070501074419.GA8120@flint.arm.linux.org.uk> <20070501113733.GW25929@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070501113733.GW25929@bingen.suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, May 01, 2007 at 01:37:33PM +0200, Andi Kleen wrote:
> > What's this?
> 
> Hmm, when I look now at your source I don't see one either. Maybe
> the reporter had a strangely patched kernel.
> 
> Anyways, point stands -- for on demand module mappings you likely
> want vmalloc_sync_all to avoid nested faults. If you think you 
> can handle the nested faults safely then ignore it @)
> 
> > 
> > > Apparently at least ARM has this problem.
> > 
> > Is there a bug report?
> 
> Forwarded it.

For the record here, Andi forwarded the report about kprobes on ARM
causing recursive page faults.  In essence, my opinion is that the
kprobes hook is probably incorrectly placed - probably far too early
in the data exception processing.

Since the data exception path is used for all sorts of things (missing
page table entries, permission, ECC errors, hardware errors, alignment
faults, etc) putting a call designed to intercept page faults early
will pick up all this other noise.

If it's placed in the same way as i386 then there shouldn't be an issue.

Since I haven't seen the code which adds this hook to ARM, I can only
speculate at the time being.  So I feel that until the hook comes up
as a candidate for merging, there's no point in fixing a problem in
mainline which doesn't yet exist there.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
