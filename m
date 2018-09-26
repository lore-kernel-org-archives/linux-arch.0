Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbeIZTAt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Sep 2018 15:00:49 -0400
Date: Wed, 26 Sep 2018 13:47:53 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 00/18] my generic mmu_gather patches
Message-ID: <20180926124752.GC2979@brain-police>
References: <20180926113623.863696043@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926113623.863696043@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com, fengguang.wu@intel.com
Message-ID: <20180926124753.gbMbtLjHrEw37UH4RUsDXRiCVcqhY0lLU7LZKUbqsUc@z>

Hi Peter,

On Wed, Sep 26, 2018 at 01:36:23PM +0200, Peter Zijlstra wrote:
> Here is my current stash of generic mmu_gather patches that goes on top of Will's
> tlb patches:

FWIW, patches 1,2,15,16,17 and 18 look fine to me, so:

Acked-by: Will Deacon <will.deacon@arm.com>

for those.

I'll leave some minor comments on a few of the others.

Will
