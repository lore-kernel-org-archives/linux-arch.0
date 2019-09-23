Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:59889 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387437AbfIWUuZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Sep 2019 16:50:25 -0400
Date: Mon, 23 Sep 2019 22:50:19 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC patch 00/15] entry: Provide generic implementation for host
 and guest entry/exit work
In-Reply-To: <20190920151240.GB55224@lakrids.cambridge.arm.com>
Message-ID: <alpine.DEB.2.21.1909232244560.1934@nanos.tec.linutronix.de>
References: <20190919150314.054351477@linutronix.de> <20190920151240.GB55224@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, James Morse <james.morse@arm.com>
Message-ID: <20190923205019.M8GOQt-DLgycpa9rWHrJGbUHyKHkONvw1dcZ33nGZXA@z>

On Fri, 20 Sep 2019, Mark Rutland wrote:
> I've been working on converting the arm64 entry code to C for a while
> now [1], gradually upstreaming the bits I can.
> 
> James has picked up some of that [2] as a prerequisite for some RAS
> error handling, and I think building the arm64 bits atop of that would
> be preferable. IIUC that should get posted as a series come -rc1.
> 
> Since there's immense scope for subtle breakage, I'd prefer that we do
> the arm64-specific asm->C conversion before migrating arm64 to generic
> code. That way us arm64 folk can ensure the asm->C conversion retains
> the existing behaviour, and it'll be easier for everyone to compare the
> arm64 and generic C implementations.

Right. It still would be nice to have some feedback on the general
approach.

That sais I'm happy to let you screw your entry code up yourself :)

Thanks

	tglx
