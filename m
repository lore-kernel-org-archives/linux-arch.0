Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:57448 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbXGYU34 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jul 2007 16:29:56 -0400
Message-ID: <46A7B1EA.7030303@zytor.com>
Date: Wed, 25 Jul 2007 13:26:18 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH][RFC] getting rid of stupid loop in BUG()
References: <alpine.LFD.0.999.0707251018280.3607@woody.linux-foundation.org>	<20070725172542.GG27237@ftp.linux.org.uk>	<46A78A31.10506@goop.org> <20070725.123501.71119586.davem@davemloft.net>
In-Reply-To: <20070725.123501.71119586.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: jeremy@goop.org, viro@ftp.linux.org.uk, torvalds@linux-foundation.org, kaos@ocs.com.au, xyzzy@speakeasy.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Miller wrote:
> 
> Another issue is that if you have a conditional trap instruction on
> your cpu, and you try the __label__ trick, GCC no longer converts:
> 
> 	BUG_ON(test)
> 
> into just a:
> 
> 	set condition codes;
> 	conditional_trap;
> 
> sequence because the "stuff" inside the basic block is something
> more than just the __builtin_trap().
> 
> The holy grail would be being able to get the perfect conditional
> trap sequence, plus the annotations in a seperate section.

I think that would require a custom gcc builtin, which we might be able
to ask the gcc folks for...

	-hpa
