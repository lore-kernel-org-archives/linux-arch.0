Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269346AbUIIFFr@vger.kernel.org>
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:63361
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269343AbUIIFFr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Sep 2004 01:05:47 -0400
Date: Wed, 8 Sep 2004 22:05:38 -0700
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: RFC: being more anal about iospace accesses..
Message-Id: <20040908220538.4fb6a2bc.davem@davemloft.net>
In-Reply-To: <20040909050410.GY23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	<20040908160737.7c1dfb5a.davem@redhat.com>
	<Pine.LNX.4.58.0409081611550.5912@ppc970.osdl.org>
	<20040909050410.GY23987@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: torvalds@osdl.org, akpm@osdl.org, linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Thu, 9 Sep 2004 06:04:10 +0100
viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Wed, Sep 08, 2004 at 06:19:08PM -0700, Linus Torvalds wrote:
> > (I think the biggest problem is _finding_ sparse, but just googling for 
> > "linux sparse tar-ball" shows at least two half-way relevant hits in the 
> > top five, so..)
> 
> The obvious thing to do would be to put snapshots on kernel.org, though...

It's not like the thing is huge.  I'd personally ship it in the
kernel tree itself, why not?  Do you not want to mix up the
licenses or the source history Linus?
