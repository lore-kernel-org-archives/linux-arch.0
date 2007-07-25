Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:56841 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759673AbXGYRhz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jul 2007 13:37:55 -0400
Message-ID: <46A78A31.10506@goop.org>
Date: Wed, 25 Jul 2007 10:36:49 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [PATCH][RFC] getting rid of stupid loop in BUG()
References: <21803.1185331847@ocs10w.ocs.com.au> <46A6DB04.3000003@zytor.com> <46A6ECB7.7090208@goop.org> <20070724.232914.56812376.davem@davemloft.net> <alpine.LFD.0.999.0707250954400.3607@woody.linux-foundation.org> <46A781A4.40103@goop.org> <alpine.LFD.0.999.0707251018280.3607@woody.linux-foundation.org> <20070725172542.GG27237@ftp.linux.org.uk>
In-Reply-To: <20070725172542.GG27237@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, hpa@zytor.com, kaos@ocs.com.au, xyzzy@speakeasy.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Al Viro wrote:
> Who said that we need to populate that section from asm?  Define
> a static variable in that section inside a block; identifier is
> not a problem, obviously.
>
> I'm not saying that it's not revolting, but it's not impossible.
>   

I tried that, but there's still no way of getting a pointer to the ud2a
instruction in there.  gcc just generates garbage if you try to use use
the &&label syntax on a label which isn't (potentially) the target of a
goto (it just gets placed somewhere random).

But there's a bigger problem than that.  If the BUG is in code which can
be replicated (ie inlined or unrolled), then it would also require
replicating the static variable...

    J
