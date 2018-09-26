Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45426 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbeIZTGO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Sep 2018 15:06:14 -0400
Date: Wed, 26 Sep 2018 13:53:18 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 06/18] asm-generic/tlb: Conditionally provide
 tlb_migrate_finish()
Message-ID: <20180926125318.GF2979@brain-police>
References: <20180926113623.863696043@infradead.org>
 <20180926114800.822722731@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926114800.822722731@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Message-ID: <20180926125318.f3R374IUosxEDPNy7wSMo6osg9FH2jlogOfwxi5jVxs@z>

On Wed, Sep 26, 2018 at 01:36:29PM +0200, Peter Zijlstra wrote:
> Needed for ia64 -- alternatively we drop the entire hook.

Ack for dropping the hook.

Will
