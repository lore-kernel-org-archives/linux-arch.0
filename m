Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268957AbUHZNIP@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1028 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263001AbUHZNEM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Aug 2004 09:04:12 -0400
Date: Thu, 26 Aug 2004 14:04:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch 1/8] signal handling race fix
Message-ID: <20040826140400.B21364@flint.arm.linux.org.uk>
References: <200408252140.i7PLeL131496@mail.osdl.org> <Pine.LNX.4.58.0408251536360.17766@ppc970.osdl.org> <20040825160913.681d6868.davem@redhat.com> <Pine.LNX.4.58.0408251702230.17766@ppc970.osdl.org> <20040825172751.13a3b2d5.davem@redhat.com> <Pine.LNX.4.58.0408251843130.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408251843130.17766@ppc970.osdl.org>; from torvalds@osdl.org on Wed, Aug 25, 2004 at 06:46:40PM -0700
Sender: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, minyard@acm.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Aug 25, 2004 at 06:46:40PM -0700, Linus Torvalds wrote:
> I also, just to check, tried to do the ARM conversion just to see what it 
> looks like when the patch hasn't gone through several different 
> incarnations and some hand-editing.. Russell, can you check my test patch 
> (appended).

It looks fine - test booted here, ran through a few signal handling tests
and everything seems to be happy.  Who's going to apply this patch?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
