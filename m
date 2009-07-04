Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36717 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbZGDVLe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 4 Jul 2009 17:11:34 -0400
Subject: Re: handle_mm_fault() calling convention cleanup..
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <alpine.LFD.2.01.0907040937040.3210@localhost.localdomain>
References: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain>
	 <1246664107.7551.11.camel@pasglop>
	 <alpine.LFD.2.01.0907040937040.3210@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 05 Jul 2009 07:08:38 +1000
Message-ID: <1246741718.7551.22.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Wu Fengguang <fengguang.wu@intel.com>, Ingo Molnar <mingo@elte.hu>
Message-ID: <20090704210838.JAo5geU3LeKnOBq0S8UC8OAzSNXuFIJxYf0AWUn8Nv4@z>

On Sat, 2009-07-04 at 09:44 -0700, Linus Torvalds wrote:

> Just a tiny word of warning: right now, the conversion I did pretty much 
> depended on the fact that even if I missed a spot, it wouldn't actually 
> make any difference. If somebody used "flags" as a binary value (ie like 
> the old "write_access" kind of semantics), things would still all work, 
> because it was still a "zero-vs-nonzero" issue wrt writes.

 .../...

Right. Oh well.. we'll see when I get to it. I have a few higher
priority things on my pile at the moment.

Cheers,
Ben.

