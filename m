Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267603AbUHMVmi@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:47324 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267602AbUHMVmi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Aug 2004 17:42:38 -0400
Date: Fri, 13 Aug 2004 14:41:15 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: clear_user_highpage()
Message-Id: <20040813144115.4c59a2f0.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0408111905210.1839@ppc970.osdl.org>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	<Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
	<20040812004654.GX11200@holomorphy.com>
	<Pine.LNX.4.58.0408111905210.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: wli@holomorphy.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 11 Aug 2004 19:18:18 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> I really do believe (but can't back it up with any real numbers) that we 
> want to try to keep pages in cache as long as possible. That means keeping 
> the pages close to the last CPU that used them, btw.

So I did some testing.

I changed the cache-bypassing clear_user_page() into one that uses
normal stores and does allocate in the L2 cache.

I ran the full build tests 3 times for each case, and the numbers were
consistent.  It makes the full build take a full minute longer.

And I truly believe this is because of the argument William and myself
are making, that a write protection fault does not mean the process is
going to access a majority of the data in that page any time soon at all.

{clear,copy}_user_page() is not some kind of "prefetch the whole page
into the cache" for the user.  It would be if the user would access
the entire thing in the near future, but I do not believe that is
the typical access pattern for fresh anonymous pages.
