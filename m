Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46719 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753135AbXGYRUb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jul 2007 13:20:31 -0400
Date: Wed, 25 Jul 2007 10:19:55 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH][RFC] getting rid of stupid loop in BUG()
In-Reply-To: <46A781A4.40103@goop.org>
Message-ID: <alpine.LFD.0.999.0707251018280.3607@woody.linux-foundation.org>
References: <21803.1185331847@ocs10w.ocs.com.au> <46A6DB04.3000003@zytor.com>
 <46A6ECB7.7090208@goop.org> <20070724.232914.56812376.davem@davemloft.net>
 <alpine.LFD.0.999.0707250954400.3607@woody.linux-foundation.org>
 <46A781A4.40103@goop.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: David Miller <davem@davemloft.net>, hpa@zytor.com, kaos@ocs.com.au, xyzzy@speakeasy.org, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>



On Wed, 25 Jul 2007, Jeremy Fitzhardinge wrote:
> 
> No, not any more.  The file and line info is out of line, in a separate
> section, indexed by the ud2a's eip.

That's irrelevant - the point is, we need to do the ud2 by hand, since we 
need to control the code generation in order to associate the ud2 with the 
proper file/linenr.

> The main problem with __builtin_trap is that there's no certain way to 
> get the actual ud2a eip (ie, paste an asm label onto it).

Right. Which is why we need to do it as an inline asm.

		Linus
