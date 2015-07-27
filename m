From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 1/8] atomics: add acquire/release/relaxed variants of
 some atomic operations
Date: Mon, 27 Jul 2015 11:14:30 +0200
Message-ID: <20150727091430.GP19282@twins.programming.kicks-ass.net>
References: <1437746681-2809-1-git-send-email-will.deacon@arm.com>
 <1437746681-2809-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:37998 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbbG0JOh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2015 05:14:37 -0400
Content-Disposition: inline
In-Reply-To: <1437746681-2809-2-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, Waiman.Long@hp.com, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com

On Fri, Jul 24, 2015 at 03:04:34PM +0100, Will Deacon wrote:

> This patch introduces three new ordering semantics for these operations:
> 
>   - *_relaxed: No ordering guarantees. This is similar to what we have
>                already for the non-return atomics (e.g. atomic_add).
> 
>   - *_acquire: ACQUIRE semantics, similar to smp_load_acquire.
> 
>   - *_release: RELEASE semantics, similar to smp_store_release.

Do we want to further specify that for the RmW operations the Read/load
will provide the acquire and the Write/store the release?
