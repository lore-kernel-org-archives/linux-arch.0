Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268359AbUHQRzR@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:32917 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268358AbUHQRzR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Aug 2004 13:55:17 -0400
Date: Tue, 17 Aug 2004 10:52:36 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: ptep_mkdirty obsolete ?
Message-Id: <20040817105236.5e3288d8.davem@redhat.com>
In-Reply-To: <1092724634.9536.122.camel@gaston>
References: <1092724532.9536.119.camel@gaston>
	<1092724634.9536.122.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 17 Aug 2004 16:37:15 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2004-08-17 at 16:35, Benjamin Herrenschmidt wrote:
> > Hi guys !
> > 
> > This is still used anywhere ? I see that we have
> > __HAVE_ARCH_PTEP_MKDIRTY on ppc64 but no actual implementation for it
> > and nobody either uses ptep_mkdirty of #ifdef on the macro...
> 
> Actually, there's a default implementation in asm-generic, I didn't see
> it because a patch from DaveM I'm toying with is removing it ;)
> 
> The fact stays that it's not used anywhere and I'd like to remove it

I totally agree.
