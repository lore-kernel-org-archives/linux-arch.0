From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 0/3] arm64: queued spinlocks and rw-locks
Date: Mon, 24 Apr 2017 14:36:23 +0100
Message-ID: <20170424133622.GB12323@arm.com>
References: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
 <a4f067df-4c22-5c90-d70a-809903c60296@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1171615AbdDXNgZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Apr 2017 09:36:25 -0400
Content-Disposition: inline
In-Reply-To: <a4f067df-4c22-5c90-d70a-809903c60296@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adam Wallis <awallis@codeaurora.org>
Cc: Yury Norov <ynorov@caviumnetworks.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Jan Glauber <jglauber@cavium.com>, Ingo Molnar <mingo@redhat.com>, jason.low2@hp.com

On Wed, Apr 12, 2017 at 01:04:55PM -0400, Adam Wallis wrote:
> On 4/10/2017 5:35 PM, Yury Norov wrote:
> > The patch of Jan Glauber enables queued spinlocks on arm64. I rebased it on
> > latest kernel sources, and added a couple of fixes to headers to apply it 
> > smoothly.
> > 
> > Though, locktourture test shows significant performance degradation in the
> > acquisition of rw-lock for read on qemu:
> > 
> >                           Before           After
> > spin_lock-torture:      38957034        37076367         -4.83
> > rw_lock-torture W:       5369471        18971957        253.33
> > rw_lock-torture R:       6413179         3668160        -42.80
> > 
> 
> On our 48 core QDF2400 part, I am seeing huge improvements with these patches on
> the torture tests. The improvements go up even further when I apply Jason Low's
> MCS Spinlock patch: https://lkml.org/lkml/2016/4/20/725

Does the QDF2400 implement the large system extensions? If so, how do the
queued lock implementations compare to the LSE-based ticket locks?

Will
