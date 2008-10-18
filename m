From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch] mm: fix anon_vma races
Date: Sat, 18 Oct 2008 21:49:07 +1100
Message-ID: <18681.48931.493345.839251@cargo.ozlabs.ibm.com>
References: <20081016041033.GB10371@wotan.suse.de>
	<Pine.LNX.4.64.0810172300280.30871@blonde.site>
	<alpine.LFD.2.00.0810171549310.3438@nehalem.linux-foundation.org>
	<Pine.LNX.4.64.0810180045370.8995@blonde.site>
	<20081018015323.GA11149@wotan.suse.de>
	<18681.20241.347889.843669@cargo.ozlabs.ibm.com>
	<20081018054916.GB26472@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751948AbYJRKt0@vger.kernel.org>
In-Reply-To: <20081018054916.GB26472@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Nick Piggin writes:

> > Not sure what you mean by causal consistency, but I assume it's the
> 
> I think it can be called transitive. Basically (assumememory starts off zeroed)
> CPU0
> x := 1
> 
> CPU1
> if (x == 1) {
>   fence
>   y := 1
> }
> 
> CPU2
> if (y == 1) {
>   fence
>   assert(x == 1)
> }

That's essentially the same as example 1 on page 415, so yes we are
talking about the same thing.

Paul.
