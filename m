Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267230AbUHZA22@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:55274 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267212AbUHZA22 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 20:28:28 -0400
Date: Wed, 25 Aug 2004 17:27:51 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [patch 1/8] signal handling race fix
Message-Id: <20040825172751.13a3b2d5.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0408251702230.17766@ppc970.osdl.org>
References: <200408252140.i7PLeL131496@mail.osdl.org>
	<Pine.LNX.4.58.0408251536360.17766@ppc970.osdl.org>
	<20040825160913.681d6868.davem@redhat.com>
	<Pine.LNX.4.58.0408251702230.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, minyard@acm.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 25 Aug 2004 17:19:02 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> On Wed, 25 Aug 2004, David S. Miller wrote:
> > 
> > I think this should be a seperate change and not block this one.
> 
> Agreed. This looks trivially obvious. No?

Looks ok to me.

Let's get Andrew's edited version of the original patch
in, then slap this one on top.

I'll then convert Sparc's signal code over to using this
force_sigsegv() stuff, I just call exit() directly currently
which isn't so nice.
