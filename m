Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266598AbUHYX4j@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:13018 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266525AbUHYXzN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 19:55:13 -0400
Date: Wed, 25 Aug 2004 16:54:38 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [patch 1/8] signal handling race fix
Message-Id: <20040825165438.558b60c3.davem@redhat.com>
In-Reply-To: <20040825164900.727422e1.akpm@osdl.org>
References: <200408252140.i7PLeL131496@mail.osdl.org>
	<Pine.LNX.4.58.0408251536360.17766@ppc970.osdl.org>
	<20040825164900.727422e1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org, minyard@acm.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 25 Aug 2004 16:49:00 -0700
Andrew Morton <akpm@osdl.org> wrote:

> > I'm ok with the patch, but I _hate_ the renaming of "ka" to "ka_copy". 
> > There's no real point except for the initial change (to make sure the 
> > compiler warns about any missed entries), and once that has been done it 
> > just makes the patches horribly noisy and not at all more readable.
> 
> OK, I edited all the diffs.  I'll let this cook for a bit longer.

Andrew please no, this bug fix has been gathering dust long
enough. :-)  I remember seeing the first version of it half
a year ago.
