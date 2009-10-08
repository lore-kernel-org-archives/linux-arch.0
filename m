From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] kmap_atomic_push
Date: Thu, 8 Oct 2009 08:44:44 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0910080844030.3432@localhost.localdomain>
References: <1255016123.17055.17.camel@laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37452 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758612AbZJHPqI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2009 11:46:08 -0400
In-Reply-To: <1255016123.17055.17.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "hugh.dickins" <hugh.dickins@tiscali.co.uk>, David Howells <dhowells@redhat.com>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>



On Thu, 8 Oct 2009, Peter Zijlstra wrote:
>
> The below patchlet changes the kmap_atomic interface to a stack based
> one that doesn't require the KM_types anymore.

I think this is how we should have done it originally.

That said, if we do this, I'd hate to have the "push" and "pop" parts to 
the name. They don't really add a whole lot.

		Linus
