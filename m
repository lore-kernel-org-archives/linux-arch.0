Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269226AbUIHX1w@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:15488 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269218AbUIHX1Y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Sep 2004 19:27:24 -0400
Date: Wed, 8 Sep 2004 16:25:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <20040908160737.7c1dfb5a.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0409081618130.5912@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <20040908160737.7c1dfb5a.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "David S. Miller" <davem@redhat.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk
List-ID: <linux-arch.vger.kernel.org>



On Wed, 8 Sep 2004, David S. Miller wrote:
> 
> I'm all for this except a possible naming suggestion that
> the thing should be called "iomemspace" not plain "iospace".

I was initially going to call it just "__io", but decided that somebody
may well already be using that as a name somewhere (and a quick grep
indeed confirmed that). Thus "__iospace".

But "__iomem" would make sense. I don't think we need both "mem" and
"space", and I agree that we already have used the term "iomem" for this
thing. Will rename.

Anyway, I've already got two fairly enthusiastic votes for the concept,
but I'll give people some more time to think it over.

This would make our "warning statistics" look bad (but see earlier email
on why I think it's entirely safe even in a stable series otherwise),
which I'm a bit concerned about. But there's absolutely no way to avoid
that - anything in drivers will inevitably take a minimum of a few kernel
releases, and possibly _much_ longer before people get upset enough to fix
the warnings in random driver X.

		Linus
