Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:33181 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752995AbZFWHSr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Jun 2009 03:18:47 -0400
Date: Tue, 23 Jun 2009 09:18:48 +0200
From: Nick Piggin <npiggin@suse.de>
Subject: Re: handle_mm_fault() calling convention cleanup..
Message-ID: <20090623071848.GC21180@wotan.suse.de>
References: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Wu Fengguang <fengguang.wu@intel.com>, Ingo Molnar <mingo@elte.hu>
Message-ID: <20090623071848.fLK8a4KDzlDB-D7ClRKH_uu3w5NDWg74LcDcNuk2ap0@z>

On Sun, Jun 21, 2009 at 01:42:35PM -0700, Linus Torvalds wrote:
> 
> Just a heads up that I committed the patches that I sent out two months 
> ago to make the fault handling routines use the finer-grained fault flags 
> (FAULT_FLAG_xyzzy) rather than passing in a boolean for "write".

While you've got everyone's attention, may I just remind arch
maintainers to consider using pagefault_out_of_memory() rather
than unconditional kill current in the pagefault OOM case. See
x86.

Thanks,
Nick
