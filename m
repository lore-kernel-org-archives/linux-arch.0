Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268381AbUHLETn@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:20392 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268359AbUHLETm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Aug 2004 00:19:42 -0400
Date: Wed, 11 Aug 2004 21:19:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: clear_user_highpage()
In-Reply-To: <20040811194317.0acf4ae3.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0408112113310.1839@ppc970.osdl.org>
References: <20040811161537.5e24c2b6.davem@redhat.com>
 <Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org> <20040812004654.GX11200@holomorphy.com>
 <Pine.LNX.4.58.0408111905210.1839@ppc970.osdl.org> <20040811194317.0acf4ae3.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "David S. Miller" <davem@redhat.com>
Cc: wli@holomorphy.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>



On Wed, 11 Aug 2004, David S. Miller wrote:
> 
> We have that cold/hot page thing in the current 2.6.x
> tree, or are you talking about something else?

You're right. It ended up never having problems (or they were worked out
in the -mm tree), so I forgot all about it ;)

How effective is it? Maybe the numbers that were done in 2001 aren't 
relevant any more?

		Linus
