From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/20] mm: Preemptibility -v4
Date: Sun, 29 Aug 2010 00:41:32 +0200
Message-ID: <1283035292.1975.4062.camel@laptop>
References: <20100828141637.421594670@chello.nl>
	 <1283005928.1975.3548.camel@laptop>
	 <20100828.152834.183037846.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:36777 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab0H1WmH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 28 Aug 2010 18:42:07 -0400
In-Reply-To: <20100828.152834.183037846.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: aarcange@redhat.com, avi@redhat.com, tglx@linutronix.de, riel@redhat.com, mingo@elte.hu, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, benh@kernel.crashing.org, hugh.dickins@tiscali.co.uk, mel@csn.ul.ie, npiggin@kernel.dk, paulmck@linux.vnet.ibm.com, yanmin_zhang@linux.intel.com, sfr@canb.auug.org.au

On Sat, 2010-08-28 at 15:28 -0700, David Miller wrote:
> I get 'as' segfaults during a "make -j128" of the kernel on sparc64
> with these changes.
> 
> I'll try to track it down.

Hrm, I let it run:

while :; do
 make O=foo/ clean;
 make O=foo/ randconfig;
 make O=foo/ -j48;
done

on my 24 cpu machine with this for like an hour, I'll let it run more
tomorrow to see if I can reproduce this.

Thanks for looking at this.
