From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Mon, 13 Jul 2015 15:24:18 +0100
Message-ID: <20150713142418.GF2632@arm.com>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <55A3B89E.7060708@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58074 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363AbbGMOYW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Jul 2015 10:24:22 -0400
Content-Disposition: inline
In-Reply-To: <55A3B89E.7060708@hurleysoftware.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>

On Mon, Jul 13, 2015 at 02:09:50PM +0100, Peter Hurley wrote:
> On 07/13/2015 08:15 AM, Will Deacon wrote:
> > smp_mb__after_unlock_lock is used to promote an UNLOCK + LOCK sequence
> > into a full memory barrier.
> >
> > However:
> >
> >   - This ordering guarantee is already provided without the barrier on
> >     all architectures apart from PowerPC
> >
> >   - The barrier only applies to UNLOCK + LOCK, not general
> >     RELEASE + ACQUIRE operations
> 
> I'm unclear what you mean here: do you mean
> A) a memory barrier is not required between RELEASE M + ACQUIRE N when you
>    want to maintain distinct order between those operations on all arches
>    (with the possible exception of PowerPC), or,
> B) no one is using smp_mb__after_unlock_lock() in that way right now.

My understanding is (B), but Peter and I don't seem to agree yet!
I'll tighten up the text once we reach a conclusion.

Will
