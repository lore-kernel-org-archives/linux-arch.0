From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v5 6/7] x86/tlb: optimizing flush_tlb_mm
Date: Tue, 15 May 2012 15:06:10 +0200
Message-ID: <1337087170.27020.166.camel@laptop>
References: <1337072138-8323-1-git-send-email-alex.shi@intel.com>
	 <1337072138-8323-7-git-send-email-alex.shi@intel.com>
	 <CAPa8GCDsSOrzQwX2qRJyocYAZdGbwjD4t4fjxmWXV6=EoXjXZw@mail.gmail.com>
	 <CAPa8GCADw7cn+cGukfy6=gEJAqV2Ef3=YFcPriuPmhpE-xvX7A@mail.gmail.com>
	 <CAJRGBZy0S_fg3GY4S5CG-2SWv5AG1jMrcMMqCiTg=7xyD1mrzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:49892 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab2EONGY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 May 2012 09:06:24 -0400
Received: from dhcp-089-099-019-018.chello.nl ([89.99.19.18] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1SUHSJ-0000zP-7r
	for linux-arch@vger.kernel.org; Tue, 15 May 2012 13:06:23 +0000
In-Reply-To: <CAJRGBZy0S_fg3GY4S5CG-2SWv5AG1jMrcMMqCiTg=7xyD1mrzQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Luming Yu <luming.yu@gmail.com>
Cc: Nick Piggin <npiggin@gmail.com>, Alex Shi <alex.shi@intel.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, rostedt@goodmis.org, fweisbec@gmail.com, jeremy@goop.org, riel@redhat.com, luto@mit.edu, avi@redhat.com, len.brown@intel.com, dhowells@redhat.com, fenghua.yu@intel.com, borislav.petkov@amd.com, yinghai@kernel.org, ak@linux.intel.com, cpw@sgi.com, steiner@sgi.com, akpm@linux-foundation.org, penberg@kernel.org, hughd@google.com, rientjes@google.com, kosaki.motohiro@jp.fujitsu.com, n-horiguchi@ah.jp.nec.com, tj@kernel.org, oleg@redhat.com, axboe@kernel.dk, jmorris@namei.org, kamezawa.hiroyu@jp.fujitsu.com, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, yongjie.ren@intel.com, linux-arch@vger.kernel.org, jcm@jonmasters.org

On Tue, 2012-05-15 at 20:58 +0800, Luming Yu wrote:
> 
> 
> Both __native_flush_tlb() and __native_flush_tlb_single(...)
> introduced roughly 1 ns  latency to tsc sampling executed in
> stop_machine_context in two logical CPUs 

But you have to weight that against the cost of re-population, and
that's the difficult bit, since we have no clue how many tlb entries are
in use by the current cr3.

It might be possible for intel to give us this information, I've asked
for something similar for cachelines.
