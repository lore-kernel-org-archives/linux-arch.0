Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50126 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732AbZGFK4n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 6 Jul 2009 06:56:43 -0400
Subject: Re: handle_mm_fault() calling convention cleanup..
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090706073148.GJ2714@wotan.suse.de>
References: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain>
	 <1246664107.7551.11.camel@pasglop>
	 <alpine.LFD.2.01.0907040937040.3210@localhost.localdomain>
	 <1246741718.7551.22.camel@pasglop>  <20090706073148.GJ2714@wotan.suse.de>
Content-Type: text/plain
Date: Mon, 06 Jul 2009 20:56:16 +1000
Message-ID: <1246877776.22625.39.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Wu Fengguang <fengguang.wu@intel.com>, Ingo Molnar <mingo@elte.hu>
Message-ID: <20090706105616.Bgl0B2l0QZvNb8Md_2DfY1IeHyoAGjoP-SO-e_zES60@z>

On Mon, 2009-07-06 at 09:31 +0200, Nick Piggin wrote:
> I have no problems with that. I'd always intended to have flags
> go further up the call chain like Linus did (since we'd discussed
> perhaps making faults interruptible and requiring an extra flag
> to distinguish get_user_pages callers that were not interruptible).
> 
> So yes adding more flags to improve code or make things simpler
> is fine by me :)
> 
That's before you see my evil plan of bringing the flags all the way
down to set_pte_at() :-)

Cheers,
Ben.


