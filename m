Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268409AbUHLEqq@vger.kernel.org>
Received: from holomorphy.com ([207.189.100.168]:6025 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268401AbUHLEqk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Aug 2004 00:46:40 -0400
Date: Wed, 11 Aug 2004 21:46:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: clear_user_highpage()
Message-ID: <20040812044634.GF11200@holomorphy.com>
References: <20040811161537.5e24c2b6.davem@redhat.com> <Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org> <20040812004654.GX11200@holomorphy.com> <Pine.LNX.4.58.0408111905210.1839@ppc970.osdl.org> <20040811194317.0acf4ae3.davem@redhat.com> <Pine.LNX.4.58.0408112113310.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408112113310.1839@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 11 Aug 2004, David S. Miller wrote:
>> We have that cold/hot page thing in the current 2.6.x
>> tree, or are you talking about something else?

On Wed, Aug 11, 2004 at 09:19:32PM -0700, Linus Torvalds wrote:
> You're right. It ended up never having problems (or they were worked out
> in the -mm tree), so I forgot all about it ;)
> How effective is it? Maybe the numbers that were done in 2001 aren't 
> relevant any more?

For lock amortization it's extremely effective. Its effects on caching
have never been properly instrumented that I know of.


-- wli
