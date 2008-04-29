Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:50154
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755076AbYD2K4I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Apr 2008 06:56:08 -0400
Date: Tue, 29 Apr 2008 03:56:07 -0700 (PDT)
Message-ID: <20080429.035607.224699531.davem@davemloft.net>
Subject: Re: [rfc] data race in page table setup/walking?
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080429050054.GC21795@wotan.suse.de>
References: <20080429050054.GC21795@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: torvalds@linux-foundation.org, hugh@veritas.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, benh@kernel.crashing.org
Message-ID: <20080429105607.4UcnzLalyQSmUHZx72rGpW5oF61cMFAuMyNy1ZlzYck@z>

From: Nick Piggin <npiggin@suse.de>
Date: Tue, 29 Apr 2008 07:00:54 +0200

> So anyway... comments, please? Am I dreaming the whole thing up? I suspect
> that if I'm not, then powerpc at least might have been impacted by the race,
> but as far as I know of, they haven't seen stability problems around there...
> Might just be terribly rare, though. I'd like to try to make a test program
> to reproduce the problem if I can get access to a box...

This definitely does look like a real problem, albeit pretty hard to
trigger I would say. :-)

Thanks for looking into this.
