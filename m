Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266477AbUHYXMc@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:6854 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266242AbUHYXJo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 19:09:44 -0400
Date: Wed, 25 Aug 2004 16:09:13 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [patch 1/8] signal handling race fix
Message-Id: <20040825160913.681d6868.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0408251536360.17766@ppc970.osdl.org>
References: <200408252140.i7PLeL131496@mail.osdl.org>
	<Pine.LNX.4.58.0408251536360.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, minyard@acm.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 25 Aug 2004 15:40:52 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> I'm ok with the patch, but I _hate_ the renaming of "ka" to "ka_copy". 
> There's no real point except for the initial change (to make sure the 
> compiler warns about any missed entries), and once that has been done it 
> just makes the patches horribly noisy and not at all more readable.
> 
> As far as I can tell, the patch would be just a few lines long without 
> that renaming. Can we _please_ reconsider?

I agree.

> Oh, and ia64 suddenly does the "force_sigsegv()" right, while at least the 
> regular x86 port is not fixed. Shouldn't we just do the "force_sigsegv()" 
> right for everybody, and put that one into kernel/signal.c?

I think this should be a seperate change and not block this one.
