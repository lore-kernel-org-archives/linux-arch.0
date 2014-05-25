From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 00/18] Cross-architecture definitions of relaxed MMIO
 accessors
Date: Mon, 26 May 2014 07:46:03 +1000
Message-ID: <1401054363.3958.28.camel@pasglop>
References: <1400777250-17335-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59849 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbaEYVrV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 25 May 2014 17:47:21 -0400
In-Reply-To: <1400777250-17335-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, monstr@monstr.eu, dhowells@redhat.com, broonie@linaro.org, peterz@infradead.org, paulmck@linux.vnet.ibm.com

On Thu, 2014-05-22 at 17:47 +0100, Will Deacon wrote:
> A corollary to this is that mmiowb() probably needs rethinking. As it currently
> stands, an mmiowb() is required to order MMIO writes to a device from multiple
> CPUs, even if that device is protected by a lock. However, this isn't often used
> in practice, leading to PowerPC implementing both mmiowb() *and* synchronising
> I/O in spin_unlock.
> 
> I would propose making the non-relaxed I/O accessors ordered with respect to
> LOCK/UNLOCK, leaving mmiowb() to be used with the relaxed accessors, if
> required, but would welcome thoughts/suggestions on this topic.

I agree on the proposed semantics, though for us that does mean we still need
that per-cpu flag tracking non-relaxed MMIO stores and corresponding added barrier
in unlock. Eventually, if the use of the relaxed accessors becomes pervasive
enough I suppose I can just make the ordered ones unconditionally do 2 barriers.

Cheers,
Ben.
