Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:42820 "EHLO
 bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1725907AbgA0NFe (ORCPT <rfc822;linux-arch@vger.kernel.org>); Mon,
 27 Jan 2020 08:05:34 -0500
Date: Mon, 27 Jan 2020 14:05:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH mk-II 08/17] asm-generic/tlb: Provide
 MMU_GATHER_TABLE_FREE
Message-ID: <20200127130503.GG14879@hirez.programming.kicks-ass.net>
References: <20191211120713.360281197@infradead.org>
 <20191211122956.112607298@infradead.org>
 <20191212093205.GU2827@hirez.programming.kicks-ass.net>
 <20200126155205.GA19169@roeck-us.net>
 <20200127081134.GI14914@hirez.programming.kicks-ass.net>
 <33932bc9-1fca-66ae-8f55-6da2f131c5be@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33932bc9-1fca-66ae-8f55-6da2f131c5be@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <20200127130503.x0L9YeyLHVixplfl8pWjkt1zXu-Y3Y0trHK8WMsIXYc@z>

On Mon, Jan 27, 2020 at 01:43:34PM +0530, Aneesh Kumar K.V wrote:

> I did send a change to fix that. it is to drop !SMP change in the patch
> 
> https://lore.kernel.org/linux-mm/87v9p9mhnr.fsf@linux.ibm.com

Indeed you did. Did those patches land anywhere, or is it all still up
in the air? (I was hoping to find those patches in a tree somewhere)
