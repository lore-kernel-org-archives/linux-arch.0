From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 0/3] arm64: queued spinlocks and rw-locks
Date: Fri, 28 Apr 2017 16:37:58 +0100
Message-ID: <20170428153758.GV13675@arm.com>
References: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
 <a4f067df-4c22-5c90-d70a-809903c60296@codeaurora.org>
 <20170413103309.GA1875@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164711AbdD1Ph6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Apr 2017 11:37:58 -0400
Content-Disposition: inline
In-Reply-To: <20170413103309.GA1875@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Adam Wallis <awallis@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Jan Glauber <jglauber@cavium.com>, jason.low2@hp.com

On Thu, Apr 13, 2017 at 01:33:09PM +0300, Yury Norov wrote:
> On Wed, Apr 12, 2017 at 01:04:55PM -0400, Adam Wallis wrote:
> > On 4/10/2017 5:35 PM, Yury Norov wrote:
> > > The patch of Jan Glauber enables queued spinlocks on arm64. I rebased it on
> > > latest kernel sources, and added a couple of fixes to headers to apply it 
> > > smoothly.
> > > 
> > > Though, locktourture test shows significant performance degradation in the
> > > acquisition of rw-lock for read on qemu:
> > > 
> > >                           Before           After
> > > spin_lock-torture:      38957034        37076367         -4.83
> > > rw_lock-torture W:       5369471        18971957        253.33
> > > rw_lock-torture R:       6413179         3668160        -42.80
> > > 
> > 
> > On our 48 core QDF2400 part, I am seeing huge improvements with these patches on
> > the torture tests. The improvements go up even further when I apply Jason Low's
> > MCS Spinlock patch: https://lkml.org/lkml/2016/4/20/725
> 
> It sounds great. So performance issue is looking like my local
> problem, most probably because I ran tests on Qemu VM.
> 
> I don't see any problems with this series, other than performance,
> and if it looks fine now, I think it's good enough for upstream.

I would still like to understand why you see such a significant performance
degradation, and whether or not you also see that on native hardware (i.e.
without Qemu involved).

Will
