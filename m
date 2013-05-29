Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52989 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759549Ab3E2Mru (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2013 08:47:50 -0400
Date: Wed, 29 May 2013 14:47:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: TLB and PTE coherency during munmap
Message-ID: <20130529124740.GB27176@twins.programming.kicks-ass.net>
References: <CAMo8BfL4QfJrfejNKmBDhAVdmE=_Ys6MVUH5Xa3w_mU41hwx0A@mail.gmail.com>
 <CAMo8BfJie1Y49QeSJ+JTQb9WsYJkMMkb1BkKz2Gzy3T7V6ogHA@mail.gmail.com>
 <51A45861.1010008@gmail.com>
 <20130529122728.GA27176@twins.programming.kicks-ass.net>
 <51A5F7A7.5020604@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51A5F7A7.5020604@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, Ralf Baechle <ralf@linux-mips.org>, Chris Zankel <chris@zankel.net>, Marc Gauthier <Marc.Gauthier@tensilica.com>, linux-xtensa@linux-xtensa.org, Hugh Dickins <hughd@google.com>
Message-ID: <20130529124740.SVYiISAfuLIykDRpiDQE2fGF-KQLIlJnEZfDNNJDdjs@z>

On Wed, May 29, 2013 at 06:12:15PM +0530, Vineet Gupta wrote:
> It seems tlb_fast_mode() only affects the page free batching and won't affect the
> TLB flush themselves unless ofcourse the batching runs out of space.

It does, it will keep the pages around until after a flush. So you'll no
longer free pages before having done a TLB flush.

> FWIW, prior to your commit d16dfc550f5326 "mm: mmu_gather rework"
> tlb_finish_mmu() right before the need_resced() which would have handled the
> current situation. My proposal - please see my earlier email in thread is to reuse
> the force_flush logic in zap_pte_range() to do this.

I don't have earlier emails as my lkml folder is somewhat broken atm :/
