From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/9] locking/qrwlock: implement queue_write_unlock using
 smp_store_release
Date: Wed, 8 Jul 2015 12:00:58 +0200
Message-ID: <20150708100058.GB3644@twins.programming.kicks-ass.net>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
 <1436289865-2331-5-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:55503 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbbGHKBD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2015 06:01:03 -0400
Content-Disposition: inline
In-Reply-To: <1436289865-2331-5-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Waiman.Long@hp.com, mingo@redhat.com

On Tue, Jul 07, 2015 at 06:24:20PM +0100, Will Deacon wrote:
> smp_store_release supports byte accesses, so use that in writer unlock
> and remove the conditional macro override.
> 

Maybe mention that this is possible since:

536fa402221f ("compiler: Allow 1- and 2-byte smp_load_acquire() and
smp_store_release()")
