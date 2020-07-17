From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 00/11] Fixup page directory freeing
Date: Fri, 17 Jul 2020 13:22:16 +0200
Message-ID: <20200717112216.GI10769@hirez.programming.kicks-ass.net>
References: <20200717111005.024867618@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200717111005.024867618@infradead.org>
Sender: linux-sh-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Christoph Hellwig <hch@lst.de>
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 17, 2020 at 01:10:05PM +0200, Peter Zijlstra wrote:
> Hi All,
> 
> While fixing a silly bug on SH (patch #1), I realized that even with the
> trivial patch to restore prior behaviour, page directory freeing was still
> broken.

*sigh*, I got patches 1 and 2 in the 'wrong' order.
