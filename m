From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 00/11] my generic mmu_gather patches
Date: Thu, 13 Sep 2018 11:21:10 +0200
Message-ID: <20180913092110.817204997@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, peterz@infradead.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com
List-Id: linux-arch.vger.kernel.org

Hi,

Here are some further mmu_gather/tlb patches I have that go on top of Will's
current tlb branch.

I mostly wrote them 2 weeks ago and haven't been able to get back to them; but
Will offered to have a wee look.

Esp. the full arch conversions (ARM, SH, UM, IA64) were based on patches I did
7 years ago and haven't been tested other than with a compiler.

The notable exception is s390, which after this series, is the only remaining
architecture with a private mmu_gather implementation. I didn't get around to
converting that.

Anyway, have a look, hopefully there's a few good bits in :-)
