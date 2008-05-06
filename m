From: David Miller <davem@davemloft.net>
Subject: Re: [patch 2/2] fix SMP data race in pagetable setup vs walking
Date: Tue, 06 May 2008 00:08:03 -0700 (PDT)
Message-ID: <20080506.000803.80742226.davem@davemloft.net>
References: <20080505112021.GC5018@wotan.suse.de>
	<20080505121240.GD5018@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38872
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752819AbYEFHID (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 03:08:03 -0400
In-Reply-To: <20080505121240.GD5018@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: torvalds@linux-foundation.org, hugh@veritas.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, paulmck@us.ibm.com

From: Nick Piggin <npiggin@suse.de>
Date: Mon, 5 May 2008 14:12:40 +0200

> I only converted x86 and powerpc. I think comments in x86 are good because
> that is more or less the reference implementation and is where many VM
> developers would look to understand mm/ code. Commenting all page table
> walking in all other architectures is kind of beyond my skill or patience,
> and maintainers might consider this weird "alpha thingy" is below them ;)
> But they are quite free to add smp_read_barrier_depends to their own code.
> 
> Still would like more acks on this before it is applied.

I've read this over a few times, I think it's OK:

Acked-by: David S. Miller <davem@davemloft.net>
