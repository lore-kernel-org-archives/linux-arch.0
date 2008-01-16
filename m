Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:58942 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbYAPFsd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 Jan 2008 00:48:33 -0500
Date: Wed, 16 Jan 2008 06:48:31 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
Message-ID: <20080116054831.GD14049@wotan.suse.de>
References: <alpine.LFD.1.00.0801151944120.2806@woody.linux-foundation.org> <20080116043728.GA7684@wotan.suse.de> <alpine.LFD.1.00.0801152040310.2806@woody.linux-foundation.org> <20080115.205152.153390863.davem@davemloft.net> <alpine.LFD.1.00.0801152119000.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801152119000.2806@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, hugh@veritas.com, jaredeh@gmail.com, cotte@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-arch@vger.kernel.org

On Tue, Jan 15, 2008 at 09:23:57PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 15 Jan 2008, David Miller wrote:
> >
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> > Date: Tue, 15 Jan 2008 20:48:42 -0800 (PST)
> > 
> > > Can you give a pointer to some browsable archive?
> > 
> > http://marc.info/?l=linux-arch
> 
> .. and the discussion itself that actually explains why ARM has problems 
> and why S390 suddenly _does_ have a bit for this after all?
> 
> (Not that I consider marc to be really "browsable" in the first place.. )
> 
> 		Linus


I sent you an exact link to the thread on marc in an earlier message...
not many others archive linux-arch or linux-mm unfortunately.

But no I didn't see a discussion of why s390 does have a bit, beyond the
s390 devs just asserting there is one, and providing a patch ;) I never
saw any of the discussions concluding that s390 does *not* have a bit
spare. Do you recall if they were public?

