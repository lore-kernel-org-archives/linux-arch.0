Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ECC3FD126;
	Thu, 26 Mar 2026 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539168; cv=none; b=m7jUdQtf2C8Aka0UsQKPJQFAGewplR3/GCOhxtvsDIGtcbGy6ov1pp028m399wjocW4iR0CMCvx987+k5lIz+ScwC5S0jvaIn2XcwfmTvJptQdArWLPG/u8ababofJIo2lnEZ09NF9ufKJeub81rBIO3IiJmk8QVSwmm8KbdevY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539168; c=relaxed/simple;
	bh=5Q9gD4fKr5OOdpRiRts9ydJlWE03nAdWhE4d8IotYL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/Cim46pOcvtSocQtihrdxFe0FxkFU3HC4Rs0fHrPTQRbYuU3ac3HC4yI1QKYtafziqWsasdV+r7PtYE8gfhVoebgjj8tkZ0bdkV/WBRMr+jIeQWwonMPtfHvb9JBQZ79s85KoF4w/Wnlu25w4esX2OAcOKHU3ORw992Pnzu6Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fmj47xM3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fmj47xM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4358AC116C6;
	Thu, 26 Mar 2026 15:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774539168;
	bh=5Q9gD4fKr5OOdpRiRts9ydJlWE03nAdWhE4d8IotYL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fmj47xM3rgl4MzY1iANiPtclngJkbIn06JI17i3XN1j5j7+LCSA8vbRvWKQX8EPjA
	 B/F/TCV26hw1l64QenLvpk7sUg3A4N28/lRWMwDfrrpqq3vJP0LjBUeXXyPLmZhfG3
	 JcrqRHdzdRCzLCde3/Y2+BTiWrtSXmUg+fkbYaxA=
Date: Thu, 26 Mar 2026 16:32:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Kees Cook <kees@kernel.org>, Penglei Jiang <superman.xpt@gmail.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	wangzijie <wangzijie1@honor.com>, NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH] vfs: transitive upgrade restrictions for fds
Message-ID: <2026032636-unclothed-earthworm-ab67@gregkh>
References: <20260323220029.765874-1-jkoolstra@xs4all.nl>
 <20260323220029.765874-2-jkoolstra@xs4all.nl>
 <2026032403-slapstick-anvil-a68e@gregkh>
 <95547355.15637.1774523348666@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95547355.15637.1774523348666@kpc.webmail.kpnmail.nl>

On Thu, Mar 26, 2026 at 12:09:08PM +0100, Jori Koolstra wrote:
> 
> > Op 24-03-2026 15:37 CET schreef Greg KH <gregkh@linuxfoundation.org>:
> > 
> > Any chance to get a test for this as well to know if this keeps working
> > (or works at all)?
> > 
> 
> I do have some tests, can shape them up a bit so that they may go in selftest
> (if this fd stuff goes through). How should I do this? Send all as a v2, or
> inline it as a response here?

v2 when you send it.

> > >  /*
> > >   * Helper to directly jump to a known parsed path from ->get_link,
> > >   * caller must have taken a reference to path beforehand.
> > >   */
> > > -int nd_jump_link(const struct path *path)
> > > +int nd_jump_link_how(const struct path *path, const struct jump_how how)
> > 
> > Shouldn't that be "const struct jump_how *how"?
> > 
> > Or do you really want to pass this structure on the stack?
> > 
> 
> I save a pointer indirection, and jump_how is right now just an int. That was
> at least my reasoning here.

It looks "odd" as it's a struct, and we don't know the size, and it's
the only place in the patch that does it this way, so it "stood out".

thanks,

greg k-h
