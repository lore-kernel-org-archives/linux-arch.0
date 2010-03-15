From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 64-syscall args on 32-bit vs syscall()
Date: Tue, 16 Mar 2010 07:35:11 +1100
Message-ID: <1268685311.2335.38.camel@pasglop>
References: <20100315134449.GB1653@linux-mips.org>
	 <4B9E4EB1.9010800@zytor.com>	<4B9E59B7.6060405@redhat.com>
	 <20100315.120004.209998642.davem@davemloft.net>
	 <4B9E8D67.8040209@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39957 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754678Ab0COUgN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Mar 2010 16:36:13 -0400
In-Reply-To: <4B9E8D67.8040209@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Miller <davem@davemloft.net>, drepper@redhat.com, ralf@linux-mips.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@teksavvy.com, torvalds@linux-foundation.org, munroesj@linux.vnet.ibm.com

On Mon, 2010-03-15 at 12:41 -0700, H. Peter Anvin wrote:
> I don't see why syscall() can't change the type for its first argument
> -- it seems to be exactly what symbol versioning is for.
> 
> Doesn't change the fact that it is fundamentally broken, of course. 

No need to change the type of the first arg and go for symbol
versionning if you do something like I proposed earlier, there will be
no conflict between syscall() and __syscall() and both variants can
exist.

Cheers,
Ben.
