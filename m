Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbeINWMC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Sep 2018 18:12:02 -0400
Date: Fri, 14 Sep 2018 17:57:00 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC][PATCH 06/11] asm-generic/tlb: Conditionally provide
 tlb_migrate_finish()
Message-ID: <20180914165700.GJ6236@arm.com>
References: <20180913092110.817204997@infradead.org>
 <20180913092812.190579217@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913092812.190579217@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com
Message-ID: <20180914165700.mAwD6V44BEHiUjki4fPSEQG1Fd9whBJFaksnFkzxjiQ@z>

On Thu, Sep 13, 2018 at 11:21:16AM +0200, Peter Zijlstra wrote:
> Needed for ia64 -- alternatively we drop the entire hook.

s/hook/architecture/

/me runs away for the weekend

Will
