From: Steven Munroe <munroesj@linux.vnet.ibm.com>
Subject: Re: 64-syscall args on 32-bit vs syscall()
Date: Tue, 16 Mar 2010 16:56:10 -0500
Message-ID: <1268776570.19726.98.camel@spokane1.rchland.ibm.com>
References: <20100315134449.GB1653@linux-mips.org>
	 <4B9E4EB1.9010800@zytor.com>	<4B9E59B7.6060405@redhat.com>
	 <20100315.120004.209998642.davem@davemloft.net>
	 <4B9E8D67.8040209@zytor.com>  <1268685311.2335.38.camel@pasglop>
Reply-To: munroesj@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:46561 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab0CPVrG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Mar 2010 17:47:06 -0400
In-Reply-To: <1268685311.2335.38.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, drepper@redhat.com, ralf@linux-mips.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@teksavvy.com, torvalds@linux-foundation.org

On Tue, 2010-03-16 at 07:35 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2010-03-15 at 12:41 -0700, H. Peter Anvin wrote:
> > I don't see why syscall() can't change the type for its first argument
> > -- it seems to be exactly what symbol versioning is for.
> > 
> > Doesn't change the fact that it is fundamentally broken, of course. 
> 
> No need to change the type of the first arg and go for symbol
> versionning if you do something like I proposed earlier, there will be
> no conflict between syscall() and __syscall() and both variants can
> exist.
> 
One concern is the new syscall and the kernel have to match and mixing
will not work. your proposal seems to impact all syscalls not just the
one called via syscall API. These syscalls get generated inline which
makes static linking very dangerous ...

So I think you do need both symbol versioning and kernel feature stubs
(like xstat). That gets to be a lot of work

> Cheers,
> Ben.
> 
> 
