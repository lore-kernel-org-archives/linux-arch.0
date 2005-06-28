Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 28 Jun 2005 01:30:55 -0700 (PDT)
Message-Id: <20050628.013055.10308064.davem@davemloft.net>
Subject: Re: RFC: is_compat_task
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050628181453.387e0fac.sfr@canb.auug.org.au>
References: <20050628072710.GA29916@lst.de>
	<20050628181453.387e0fac.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: sfr@canb.auug.org.au
Cc: hch@lst.de, akpm@osdl.org, linux-kernel@vger.kernel.rg, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 28 Jun 2005 18:14:53 +1000

> So, I have been thinking about this patch for a while (wondering how badly
> flamed I would get when I posted it :-)).  What do you all think?  Is this
> a reasonable thing to do?

I'm personally not going to fight this any longer, unless
someone can quickly come up with a clean way to handle the
input layer compat stuff without such an interface. :-)

> We also need sometimes to tell if an mm is 32bit, I think?  Any
> suggestions?

Probably time to bite the bullet and put address space ranges
into the mm_struct.
