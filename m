Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269347AbUIIFO3@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:17823 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269346AbUIIFO3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Sep 2004 01:14:29 -0400
Date: Wed, 8 Sep 2004 22:13:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <20040909050410.GY23987@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0409082209240.5912@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <20040908160737.7c1dfb5a.davem@redhat.com> <Pine.LNX.4.58.0409081611550.5912@ppc970.osdl.org>
 <20040909050410.GY23987@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: "David S. Miller" <davem@redhat.com>, akpm@osdl.org, linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk
List-ID: <linux-arch.vger.kernel.org>



On Thu, 9 Sep 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> The obvious thing to do would be to put snapshots on kernel.org, though...

I could do that, I guess. It's calm enough these days that I wouldn't feel 
like I have to update it all the time.

> One note on patch: I would wrap the definition of __iospace into an
> ifndef.  Rationale: that allows to separate the work on these annotations
> from the rest.

Yes, I was thinking of having some way to disable these things. I think
-Wbitwise was good, it would make sense to be able to do similar things
for address-spaces too. Either on a source level with changing __iospace
(aka __iomem), or having a sparse option to allow certain spaces to alias 
each other.

		Linus
