Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E163F54C9;
	Wed, 17 Jun 2026 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702677; cv=none; b=T4RcQw2u0xF0JhdvMfwjZoywFqHkBbnkkoBkU+PKpx/s6S0XkTYGAznYZ86jtEuT+aE00/NYfmp+nEaz0hM50WKYJkXxojA2PAw85qLwmchGadQjC+xsqCzVnn9WJHl2KMvVGXIFvg+7C3nhzXrNSBIf+8IrARDXMoxDhcO9lXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702677; c=relaxed/simple;
	bh=CUgoKR2Wc5cxQPYEOOnKz/0q/FvF40o5TROEsPHQXSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JK5qScwS9SblaSS6A6IUALqwNDZdkgXY5hBzWk+/jOFdNsBUpEDzweAvZ4sjwFfayx4LYGrlj1tkFGR3QZcbPFvKS8efubpOcQQ2+mafP4jxbVycSTzJs33KTS6xUmNdtHcgXUbTL3jIkQcBG8KtdOGZw5nwi0Ofs9dNJlwid6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9veR9t+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9veR9t+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA4A1F00A3A;
	Wed, 17 Jun 2026 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781702676;
	bh=EZO1mohog/fU8uSiK9F/3p5WWQpe8vkDRi43VoSm4gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m9veR9t+S9hWRq+Yg0R9S1Be36Q/9ZBk+FxaXe1mLu/Kqmr0/yV96nED2ZLvMT+4N
	 Y23pPyGRv9vA+1EJDOeLB6l3UV/3jOTOK9ln44oLT5RdFZ2D4jO1VDezIieGxqF/jf
	 QI9Y2qhBXB/NdSRJ+3fyFsLJr2orJDyKVzzTjDDiX8GIy19TyWoIlwpEy5CSmtjqI4
	 FIWWqkXC0enbRFCeoP55I86XNYedSuSC0jUy5IPHgN1cw1UUxAQEIHtbtEEyiZ733l
	 r8GDkiX9xdUYqKpnO0/3G2XWb16PvykA87Nlpfg8nKJvMwACFZJEoJlIu+GYMU23Nl
	 C0npAMjuxNjTA==
Date: Wed, 17 Jun 2026 15:24:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] vfs: missing inode operation should return a consistent
 error code
Message-ID: <20260617-asphalt-hochachtung-federn-23e94198aa4a@brauner>
References: <20260531104947.6142-1-jkoolstra@xs4all.nl>
 <c5e32b78aeaa833d18d9b7a566358a6f71d09f23.camel@kernel.org>
 <xdknvjlda7wxwo35toe357nnyaydsllv5g65ogzsomxqgm7jfu@qwtugpoy2rcw>
 <2002074169.107129.1780331273724@kpc.webmail.kpnmail.nl>
 <m5fqzr2ny4zb36u6zhmrrxgl36ycsxvlqnzf5idvsq4lxpfh3i@g276qtqgfv3f>
 <1512332516.1435503.1781209872436@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1512332516.1435503.1781209872436@kpc.webmail.kpnmail.nl>

On Thu, Jun 11, 2026 at 10:31:12PM +0200, Jori Koolstra wrote:
> @Christian, since you suggested equalizing the error codes for missing
> inode ops, what is your opinion?
> 
> > Op 01-06-2026 18:50 CEST schreef Jan Kara <jack@suse.cz>:
> > 
> > We certainly can (and sometimes do) modify the returned errors. It is
> > always just a balancing act between the benefit of the change and chances
> > somebody will get broken by it. In this case I don't quite see the
> > benefit, not that I'd be too worried about the a regression but there's
> > always the chance...
> > 
> > 								Honza
> 
> No, I get that, and maybe you are right. I feel in this case it would be
> really odd if this breaks anyone's application. It would mean you are
> rigorously testing for receiving specific error codes, without handling
> a general error case. That just seems odd, especially since some of these
> error codes are not even listed as a possibility for missing ops (like EACCES).
> I would say we change this and revert if anyone complains. I believe that was
> also Christian's view in another thread, but I may be mistaken.

It's a general stance, yes. I think trying to make the things we
maintain more consistent is worth risking someone reporting a
regression.
