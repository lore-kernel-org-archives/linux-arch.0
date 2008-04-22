Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:13123 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755273AbYDVPIC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Apr 2008 11:08:02 -0400
Date: Tue, 22 Apr 2008 17:07:56 +0200
From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Message-ID: <20080422150756.GM12774@kernel.dk>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-2-git-send-email-jens.axboe@oracle.com> <alpine.LFD.1.10.0804220735350.2779@woody.linux-foundation.org> <alpine.LFD.1.10.0804220749450.2779@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804220749450.2779@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de
Message-ID: <20080422150756.eBBVBaec3la87NVitZKlG6Z4lnq-DgJOu0IXdncnUnw@z>

On Tue, Apr 22 2008, Linus Torvalds wrote:
> 
> 
> On Tue, 22 Apr 2008, Linus Torvalds wrote:
> > 
> > You forgot to free the "data" here? The waiter must also free the object, 
> > since now the callee does not.
> 
> Ahh. For the single case, the caller will have it on the stack.

Yes, if wait is set, it's on the stack.

> But the smp_call_function_mask() case seems to leak these things.

Hmm yes, double checking it and it would seem to leak for wait &&
kmalloc'ed data. I think I originally had the wait case as always on
stack, which would explain this leak.

> How about just always doing the "wait" case on the stack? Also, I'd 
> suggest you get rid of the static allocation, and just turn it into a wait 
> case, so that you don't need *three* different allocation cases, just two.

Alright, I'll make 'wait' always alloc on the stack and I'll make
allocation failure turn into 'wait' as well. That'll leave just
kmalloc() and stack allocation, killing the static data fallback.

> Or am I missing something?

No, I think that should work ok. I'll post a new series with the changes
so we can see if we agree.

-- 
Jens Axboe

