From: David Howells <dhowells@redhat.com>
Subject: Re: handle_mm_fault() calling convention cleanup..
Date: Mon, 22 Jun 2009 15:22:01 +0100
Message-ID: <3241.1245680521@redhat.com>
References: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Wu Fengguang <fengguang.wu@intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-arch.vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> It's pushed out and tested on x86-64, but it really was such a mindless 
> conversion that I hope it works on all architectures. But I thought I'd 
> better give people a shout-out regardless.

Works on FRV and MN10300.

David

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
