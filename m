Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269356AbUIIGI5@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4820 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269353AbUIIGI5
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Sep 2004 02:08:57 -0400
Date: Thu, 9 Sep 2004 07:08:56 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: RFC: being more anal about iospace accesses..
Message-ID: <20040909060856.GZ23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <20040908160737.7c1dfb5a.davem@redhat.com> <Pine.LNX.4.58.0409081611550.5912@ppc970.osdl.org> <20040909050410.GY23987@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0409082209240.5912@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409082209240.5912@ppc970.osdl.org>
Sender: <viro@www.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, akpm@osdl.org, linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Wed, Sep 08, 2004 at 10:13:45PM -0700, Linus Torvalds wrote:
> Yes, I was thinking of having some way to disable these things. I think
> -Wbitwise was good, it would make sense to be able to do similar things
> for address-spaces too. Either on a source level with changing __iospace
> (aka __iomem), or having a sparse option to allow certain spaces to alias 
> each other.

BTW, is there any reason to have cpu_to_le32p() and its ilk as macros instead
of inlined functions?  If there isn't, I'd gladly lose the perversions I'm
currently using to deal with type checks and let the normal logics take care
of that...

Unlike cpu_to_...() these guys are obviously never constant, so that objection
does not apply.  AFAICS, all callers of that bunch would be OK with such
change, so unless there are dark and nasty arch-specific reasons, I'd rather
turn them into inlines...
