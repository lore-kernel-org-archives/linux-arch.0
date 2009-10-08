Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:42502 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbZJHPy4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 8 Oct 2009 11:54:56 -0400
Date: Thu, 8 Oct 2009 17:53:44 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH] kmap_atomic_push
Message-ID: <20091008155344.GA11727@elte.hu>
References: <1255016123.17055.17.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255016123.17055.17.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Avi Kivity <avi@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "hugh.dickins" <hugh.dickins@tiscali.co.uk>, David Howells <dhowells@redhat.com>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20091008155344.PSNf_zlXWczZ9ErwVw9vU2yWltYjMoSODjt0NKL70Dc@z>


* Peter Zijlstra <peterz@infradead.org> wrote:

> The below patchlet changes the kmap_atomic interface to a stack based 
> one that doesn't require the KM_types anymore.
> 
> This significantly simplifies some code (more still than are present 
> in this patch -- ie. pte_map_nested can go now)
> 
> This obviously requires that push and pop are matched, I fixed a few 
> cases that were not properly nested, the (x86) code checks for this 
> and will go BUG when trying to pop a vaddr that isn't the top one so 
> abusers should be rather visible.

Looks great IMO! Last i proposed this i think either Andrew or Avi had 
second thoughts about the hard-to-calculate worst-case mapping limit - 
but i dont think that's a big issue.

Lets not change the API names though - the rule is that map/unmap must 
be properly nested.

	Ingo
