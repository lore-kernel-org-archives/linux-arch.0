Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268123AbUHQGpl@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:29600 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268125AbUHQGpl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Aug 2004 02:45:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id i7H6g8HR029961
	for <linux-arch@vger.kernel.org>; Tue, 17 Aug 2004 01:42:09 -0500
Subject: Re: ptep_mkdirty obsolete ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1092724532.9536.119.camel@gaston>
References: <1092724532.9536.119.camel@gaston>
Content-Type: text/plain
Message-Id: <1092724634.9536.122.camel@gaston>
Mime-Version: 1.0
Date: Tue, 17 Aug 2004 16:37:15 +1000
Content-Transfer-Encoding: 7bit
To: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2004-08-17 at 16:35, Benjamin Herrenschmidt wrote:
> Hi guys !
> 
> This is still used anywhere ? I see that we have
> __HAVE_ARCH_PTEP_MKDIRTY on ppc64 but no actual implementation for it
> and nobody either uses ptep_mkdirty of #ifdef on the macro...

Actually, there's a default implementation in asm-generic, I didn't see
it because a patch from DaveM I'm toying with is removing it ;)

The fact stays that it's not used anywhere and I'd like to remove it

Ben.
