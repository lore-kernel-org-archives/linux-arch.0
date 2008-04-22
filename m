Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58293 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751462AbYDVPAA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Apr 2008 11:00:00 -0400
Date: Tue, 22 Apr 2008 07:58:47 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
In-Reply-To: <alpine.LFD.1.10.0804220735350.2779@woody.linux-foundation.org>
Message-ID: <alpine.LFD.1.10.0804220749450.2779@woody.linux-foundation.org>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-2-git-send-email-jens.axboe@oracle.com> <alpine.LFD.1.10.0804220735350.2779@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de
Message-ID: <20080422145847.oBJGoInWR6JhP1Rd17RuP97-vIY-WS-o1bBxMQ0c7s0@z>



On Tue, 22 Apr 2008, Linus Torvalds wrote:
> 
> You forgot to free the "data" here? The waiter must also free the object, 
> since now the callee does not.

Ahh. For the single case, the caller will have it on the stack.

But the smp_call_function_mask() case seems to leak these things.

How about just always doing the "wait" case on the stack? Also, I'd 
suggest you get rid of the static allocation, and just turn it into a wait 
case, so that you don't need *three* different allocation cases, just two.

Or am I missing something?

		Linus
