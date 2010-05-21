From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2]: atomic_t: Remove volatile from atomic_t definition
Date: Thu, 20 May 2010 22:54:54 -0700 (PDT)
Message-ID: <20100520.225454.37197037.davem@davemloft.net>
References: <20100519.125449.56392211.davem@davemloft.net>
	<20100519225046.GO2237@linux.vnet.ibm.com>
	<20100521052746.GL2516@laptop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41366
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754722Ab0EUFyo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 May 2010 01:54:44 -0400
In-Reply-To: <20100521052746.GL2516@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, anton@samba.org, akpm@linux-foundation.org, willy@linux.intel.com, benh@kernel.crashing.org, paulus@samba.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nick Piggin <npiggin@suse.de>
Date: Fri, 21 May 2010 15:27:46 +1000

> Hmm, I'm missing something. David, back up a second, as far as I can see,
> with Anton's patches, atomic_read() *is* effectively just ACCESS_ONCE()
> now. Linus pointed out that header tangle is the reason not to just use
> the macro.

My bad, I was under the impression that the proposal was to remove
volatile usage and also not even do ACCESS_ONCE() in atomic_read().

And then explicitly annotate call sits that actually need the
ACCESS_ONCE() semantic.
