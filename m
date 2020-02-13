From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 00/22] arm64: Memory Tagging Extension user-space support
Date: Thu, 13 Feb 2020 11:23:46 +0000
Message-ID: <20200213112346.GA639258@arrakis.emea.arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
 <CAMn1gO6f4UUdhBe1sfiAPBW=zr-C3ypUv-Pwgx=wvmJjp4xfyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:45242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgBMLXu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 06:23:50 -0500
Content-Disposition: inline
In-Reply-To: <CAMn1gO6f4UUdhBe1sfiAPBW=zr-C3ypUv-Pwgx=wvmJjp4xfyA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Collingbourne <pcc@google.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arch@vger.kernel.org, Richard Earnshaw <Richard.Earnshaw@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Andrey Konovalov <andreyknvl@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Evgenii Stepanov <eugenis@google.com>, Kostya Kortchinsky <kostyak@google.com>, Kostya Serebryany <kcc@google.com>

On Fri, Dec 13, 2019 at 10:05:10AM -0800, Peter Collingbourne wrote:
> On Wed, Dec 11, 2019 at 10:40 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > This series proposes the initial user-space support for the ARMv8.5
> > Memory Tagging Extension [1].
> 
> Thanks for sending out this series. I have been testing it on Android
> with the FVP model and my in-development scudo changes that add memory
> tagging support [1], and have not noticed any problems so far.

Thanks for the comments so far and the testing. I'll post a v2 next
week.

> > - Clarify whether mmap(tagged_addr, PROT_MTE) pre-tags the memory with
> >   the tag given in the tagged_addr hint. Strong justification is
> >   required for this as it would force arm64 to disable the zero page.
> 
> We would like to use this feature in scudo to tag large (>128KB on
> Android) allocations, which are currently allocated via mmap rather
> than from an allocation pool. Otherwise we would need to pay the cost
> (perf and RSS) of faulting all of their pages at allocation time
> instead of on demand, if we want to tag them.

Would the default tag of 0 be sufficient here? We disable match-all for
user-space already, so 0 is not a wildcard.

-- 
Catalin
