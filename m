Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38332
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750804AbYC1EJK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 28 Mar 2008 00:09:10 -0400
Date: Thu, 27 Mar 2008 21:09:10 -0700 (PDT)
Message-ID: <20080327.210910.101408473.davem@davemloft.net>
Subject: Re: [patch 1/2]: x86: implement pte_special
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080328040442.GE8083@wotan.suse.de>
References: <20080328033149.GD8083@wotan.suse.de>
	<20080327.204431.201380891.davem@davemloft.net>
	<20080328040442.GE8083@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: akpm@linux-foundation.org, shaggy@austin.ibm.com, axboe@oracle.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org
Message-ID: <20080328040910.3eo2wLOG8TRvpZtdIlirf5S6WE0ZoYs73aXit6mf-aw@z>

From: Nick Piggin <npiggin@suse.de>
Date: Fri, 28 Mar 2008 05:04:42 +0100

> BTW. if you are still interested, then the powerpc64 patch might be a
> better starting point for you. I don't know how the sparc tlb flush
> design looks like, but if it doesn't do a synchronous IPI to invalidate
> other threads, then you can't use the x86 approach.

I have soft bits available on sparc64, that's not my issue.

My issue is that if you implemented this differently, every platform
would get the optimization, without having to do anything special
at all, and I think that's such a much nicer way.
