Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269345AbUIIFEL@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23249 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269343AbUIIFEL
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Sep 2004 01:04:11 -0400
Date: Thu, 9 Sep 2004 06:04:10 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: RFC: being more anal about iospace accesses..
Message-ID: <20040909050410.GY23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <20040908160737.7c1dfb5a.davem@redhat.com> <Pine.LNX.4.58.0409081611550.5912@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409081611550.5912@ppc970.osdl.org>
Sender: <viro@www.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, akpm@osdl.org, linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Wed, Sep 08, 2004 at 06:19:08PM -0700, Linus Torvalds wrote:
> (I think the biggest problem is _finding_ sparse, but just googling for 
> "linux sparse tar-ball" shows at least two half-way relevant hits in the 
> top five, so..)

The obvious thing to do would be to put snapshots on kernel.org, though...

One note on patch: I would wrap the definition of __iospace into an
ifndef.  Rationale: that allows to separate the work on these annotations
from the rest.

IOW, I'd love to be able to say
make C=1 CHECKFLAGS="-Dno_check_iospace -Wbitwise"
and get endianness warnings alone (and be able to do _just_ iospace checks
without other experimental stuff).

Once the level of noise from that area is down to something sane, we can
make the thing unconditional and basically include it into the baseline
set of checks.  Comments?

BTW, I've got the beginning of endianness annotations carved and mergable;
patches in an hour or two...
