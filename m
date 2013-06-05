Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:51375 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab3FEAFq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jun 2013 20:05:46 -0400
Received: by mail-pb0-f42.google.com with SMTP id uo1so958548pbc.1
        for <linux-arch@vger.kernel.org>; Tue, 04 Jun 2013 17:05:46 -0700 (PDT)
Date: Wed, 5 Jun 2013 09:05:03 +0900 (PWT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: TLB and PTE coherency during munmap
In-Reply-To: <20130604095258.GL8923@twins.programming.kicks-ass.net>
Message-ID: <alpine.LFD.2.03.1306050904160.28129@pixel.linux-foundation.org>
References: <CAMo8BfL4QfJrfejNKmBDhAVdmE=_Ys6MVUH5Xa3w_mU41hwx0A@mail.gmail.com> <CAMo8BfJie1Y49QeSJ+JTQb9WsYJkMMkb1BkKz2Gzy3T7V6ogHA@mail.gmail.com> <51A45861.1010008@gmail.com> <20130529122728.GA27176@twins.programming.kicks-ass.net> <51A5F7A7.5020604@synopsys.com>
 <20130529175125.GJ12193@twins.programming.kicks-ass.net> <CAMo8BfJtkEtf9RKsGRnOnZ5zbJQz5tW4HeDfydFq_ZnrFr8opw@mail.gmail.com> <20130603090501.GI5910@twins.programming.kicks-ass.net> <20130604095258.GL8923@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, Ralf Baechle <ralf@linux-mips.org>, Chris Zankel <chris@zankel.net>, Marc Gauthier <Marc.Gauthier@tensilica.com>, linux-xtensa@linux-xtensa.org, Hugh Dickins <hughd@google.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20130605000503.8oP2mgA04PaWpMX_s2SemlDCIJzcIq95pLZDJxB4b4U@z>



On Tue, 4 Jun 2013, Peter Zijlstra wrote:
> 
> And here's the patch that makes fast mode go *poof*..

Let's just do this. Mind sending a patch with proper changelog and 
sign-off?

             Linus
