From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [RFC][PATCH 2/3] math128: Introduce {mult,add,cmp}_u128
Date: Tue, 24 Apr 2012 21:43:02 +0200
Message-ID: <1335296582.28150.227.camel@twins>
References: <20120424161039.293018424@chello.nl>
	 <20120424162224.526249106@chello.nl>
	 <CA+55aFyvBTDh_DkXs6Z6zFmjyYxvWaAEm9-rJDXhvPx8CpDiKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFyvBTDh_DkXs6Z6zFmjyYxvWaAEm9-rJDXhvPx8CpDiKA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Tue, 2012-04-24 at 12:37 -0700, Linus Torvalds wrote:
> Or at least stupid.
> 
I'll take stupid.. this bit-fiddling isn't something I've done lots of.

I'll go stare at gcc output now.. ;-)
