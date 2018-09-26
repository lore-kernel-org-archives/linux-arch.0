From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 06/18] asm-generic/tlb: Conditionally provide
 tlb_migrate_finish()
Date: Wed, 26 Sep 2018 13:53:18 +0100
Message-ID: <20180926125318.GF2979@brain-police>
References: <20180926113623.863696043@infradead.org>
 <20180926114800.822722731@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180926114800.822722731@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 26, 2018 at 01:36:29PM +0200, Peter Zijlstra wrote:
> Needed for ia64 -- alternatively we drop the entire hook.

Ack for dropping the hook.

Will
