From: "H. Peter Anvin" <hpa@kernel.org>
Subject: Re: [PATCH 1/3] X86_64: Optimise fls(), ffs() and fls64()
Date: Thu, 15 Dec 2011 10:12:21 -0800
Message-ID: <4EEA3885.5050401@kernel.org>
References: <20111213145654.14362.39868.stgit@warthog.procyon.org.uk> <CA+55aFzanrQU2DQHxkE7cWBOwT7Xb=+LfmSNWoatDL-oiV6opA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:41396 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759245Ab1LOSMf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Dec 2011 13:12:35 -0500
In-Reply-To: <CA+55aFzanrQU2DQHxkE7cWBOwT7Xb=+LfmSNWoatDL-oiV6opA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-arch@vger.kernel.org

On 12/14/2011 04:03 PM, Linus Torvalds wrote:
> 
> I'm pretty sure that we had some chips that actually do write random
> stuff to the destination register when the input is zero.
> 
> We relied on the "doesn't change the destination" at some point *long*
> ago, and it turned out not to work, but I can't remember what chip it
> was.
> 
> I'm nervous about making this change even on x86-64 unless we add big
> comments about the old 32-bit change. Can somebody find the historic
> thing and a comment about which chip it was?
> 

The ones I know of are some steppings of the 486.

	-hpa
