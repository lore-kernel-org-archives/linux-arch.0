Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269048AbUHZPX6@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:8934 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269046AbUHZPX6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Aug 2004 11:23:58 -0400
Date: Thu, 26 Aug 2004 08:23:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 1/8] signal handling race fix
In-Reply-To: <20040826140400.B21364@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0408260822290.2304@ppc970.osdl.org>
References: <200408252140.i7PLeL131496@mail.osdl.org>
 <Pine.LNX.4.58.0408251536360.17766@ppc970.osdl.org> <20040825160913.681d6868.davem@redhat.com>
 <Pine.LNX.4.58.0408251702230.17766@ppc970.osdl.org> <20040825172751.13a3b2d5.davem@redhat.com>
 <Pine.LNX.4.58.0408251843130.17766@ppc970.osdl.org>
 <20040826140400.B21364@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Russell King <rmk@arm.linux.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, minyard@acm.org
List-ID: <linux-arch.vger.kernel.org>



On Thu, 26 Aug 2004, Russell King wrote:
> 
> It looks fine - test booted here, ran through a few signal handling tests
> and everything seems to be happy.  Who's going to apply this patch?

Please you do it, I'll get it from the next arm merge. 

		Linus
