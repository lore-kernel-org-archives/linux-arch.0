Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:46298 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1163348AbWLGVHK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Dec 2006 16:07:10 -0500
Subject: Re: [PATCH 3/3] WorkStruct: Use direct assignment rather than
	cmpxchg()
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <639.1165521999@redhat.com>
References: <20061207085409.228016a2.akpm@osdl.org>
	 <20061207153138.28408.94099.stgit@warthog.cambridge.redhat.com>
	 <20061207153143.28408.7274.stgit@warthog.cambridge.redhat.com>
	 <639.1165521999@redhat.com>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 15:06:37 -0600
Message-Id: <1165525597.4698.46.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, davem@davemloft.com, wli@holomorphy.com, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2006-12-07 at 20:06 +0000, David Howells wrote:
> Remember: if you have to put a conditional jump in there, it's going to fail
> one way or the other a certain percentage of the time, and that's going to
> cause a pipeline stall, and these ops are used quite a lot.

That we'd have to put a conditional jump in there is an incorrect
assumption on risc machines.  At least on parisc we can do conditional
nullifies in the executing instruction pipeline, so we'd read, nullify
the following write if the bit were set.  We do this a lot in our page
interruption handlers.

James


