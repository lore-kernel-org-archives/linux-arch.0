Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268372AbUHLCoD@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:16549 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268371AbUHLCoD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 22:44:03 -0400
Date: Wed, 11 Aug 2004 19:43:17 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: clear_user_highpage()
Message-Id: <20040811194317.0acf4ae3.davem@redhat.com>
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

> So I'd personally be a whole lot more interested in seeing whether we 
> could have per-CPU pages than in pre-zeroing. 

We have that cold/hot page thing in the current 2.6.x
tree, or are you talking about something else?

I'm talking about the struct per_cpu_pages stuff.
It's the first thing buffered_rmqueue() checks when
the request order of the page allocation is zero.
