Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267212AbUHZAfp@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:41857 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266917AbUHZAdG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 20:33:06 -0400
Date: Wed, 25 Aug 2004 17:32:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 1/8] signal handling race fix
In-Reply-To: <20040825172751.13a3b2d5.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0408251730110.17766@ppc970.osdl.org>
References: <200408252140.i7PLeL131496@mail.osdl.org>
 <Pine.LNX.4.58.0408251536360.17766@ppc970.osdl.org> <20040825160913.681d6868.davem@redhat.com>
 <Pine.LNX.4.58.0408251702230.17766@ppc970.osdl.org> <20040825172751.13a3b2d5.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, minyard@acm.org
List-ID: <linux-arch.vger.kernel.org>



On Wed, 25 Aug 2004, David S. Miller wrote:
> 
> Let's get Andrew's edited version of the original patch
> in, then slap this one on top.

I'd prefer doing it the other way - since Andrew's patch won't work 
without this _or_ some ugly changes.

Ie the old signal code usually did

	if (sig == SIGSEGV)
		ka->handler = SIG_DFL;

which just doesn't work if "ka" is just a copy of the real handler
information.

So the signal handling race fix needs to either have my quick cleanup 
patch in place already, or it needs to change all the "ka->..." to 
"current->sighand->" only to have it all be removed later immediately by 
my cleanup patch.

So the cleanup patch logically goes first. After that, Andrew's patch is 
going to be really small, methinks.

		Linus
