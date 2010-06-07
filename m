From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 16/28] sh: Preemptible mmu_gather
Date: Mon, 07 Jun 2010 13:38:39 +0200
Message-ID: <1275910719.1645.560.camel@laptop>
References: <20100607110654.606530953@chello.nl>
	 <20100607111407.860340332@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100607111407.860340332@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-arch.vger.kernel.org

On Mon, 2010-06-07 at 13:07 +0200, Peter Zijlstra wrote:
> Fix up the arm mmu_gahter code to conform to the new API.
> 
urhm,. copy/paste gone wild, clearly that's the SH code for this
patch ;-)
