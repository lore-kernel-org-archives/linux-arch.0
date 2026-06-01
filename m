Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68F12E8DFC
	for <linux-arch@vger.kernel.org>; Mon,  1 Jun 2026 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331278; cv=none; b=WNr+WqQaaAtRw3pMk5bYuPlfku8pgP4UC/bYTJHkmY6fGPJn9wy+UWwX9BHEHnLnn+YRoVP9JJNthniRvumgjidkiE0+BO0ccHbhrze6uxtQw2AsphROl+kkXIsTjk4LD/ZeM8YyKPOKX6kATtyrP8xN0VrznEf07GWss2S55y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331278; c=relaxed/simple;
	bh=3LkQaNGBB576338VrgcW2QO/D63U7HdVQHPRBsznKmw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ffbb6Buuq3m7UBlQisohu9Kqj+FClSZEjMHXdkkmYauXjuNjm2dwyDNdqpRq94naVOUX9QY6HG9/VxnTtGwHpC0FZdXcb3qkdjMiazqYsMcmuSnCxhuXr8EL26+DH9MCcKQ9sfMyHim84gEmbYUuXp96k3gsOQn1zA8rdYcxI+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=TlwexXkJ; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="TlwexXkJ"
X-KPN-MessageId: d70d3d74-5dd6-11f1-beaa-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d70d3d74-5dd6-11f1-beaa-005056992ed3;
	Mon, 01 Jun 2026 18:27:53 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id d71a5691-5dd6-11f1-b5d4-0050569981f5;
	Mon, 01 Jun 2026 18:27:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=pK+jjtVDJ2yLuCLQOZ9lmN1H22vbdo/jUfd0aOxeWEE=;
	b=TlwexXkJlVVfSCFt36aIroW1RQ6VcK7pkkx2M4RMm5m9H813JtnViSj97vyxDcC3VCO93TL2mBekR
	 UUT8HRQEocT2k1W4IBnl0JEFa5rqUqYgFITCt0OBbdkxuDgon5c5p5fMw93AXDa6jO3QX8kD82iob/
	 n7g4SlOYcGu3P1RpLjpfmXGWEoA8EBd8dA3aHOtVDPmv4ayrprZYBeoUyZudgI9dRldqzCtYdRvzt1
	 +nf77+xe+/l0p3Rvb18R0IUU2DeB8ulSoWSrZbFKmzAt2aCygRkpE2brkcPhJgvWnRcZhRGX5GDtce
	 +sghEunUgt+S2PBppNU96FoD3RJtkcw==
X-KPN-MID: 33|pZDn2B+8ANNonqD19nq9YXOH1vcOd5gkw6iRvxFwuUGPb7hl8Btc6w3GRJ1q4Rc
 X6iCL+Yj546TDrzzHhQLhjg0JdAiEEkVKt49Or4Mp568=
X-CMASSUN: 33|aXviZNRv+9GvSwkHh7Lz5KkmILZ+rhY7f4dzCyn/tCn0PZ9K7bBp0P3jSxk7KJH
 s4TYg6G95CzybeLXjKhdQVw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id d709217b-5dd6-11f1-b8d7-005056995d6c;
	Mon, 01 Jun 2026 18:27:53 +0200 (CEST)
Date: Mon, 1 Jun 2026 18:27:53 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Message-ID: <2002074169.107129.1780331273724@kpc.webmail.kpnmail.nl>
In-Reply-To: <xdknvjlda7wxwo35toe357nnyaydsllv5g65ogzsomxqgm7jfu@qwtugpoy2rcw>
References: <20260531104947.6142-1-jkoolstra@xs4all.nl>
 <c5e32b78aeaa833d18d9b7a566358a6f71d09f23.camel@kernel.org>
 <xdknvjlda7wxwo35toe357nnyaydsllv5g65ogzsomxqgm7jfu@qwtugpoy2rcw>
Subject: Re: [PATCH] vfs: missing inode operation should return a consistent
 error code
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 01-06-2026 17:58 CEST schreef Jan Kara <jack@suse.cz>:
> 
>  
> On Sun 31-05-26 10:08:47, Jeff Layton wrote:
> > 
> > This seems ill-advised. The problem is that most of this behavior has
> > been well established for years, and not all userland software (and
> > even some internal callers like nfsd), will react well when you go
> > changing behavior like this.
> > 
> > As a case in point, the POSIX spec doesn't list EOPNOTSUPP as a valid
> > error return for open():
> > 
> >    https://pubs.opengroup.org/onlinepubs/9690949399/functions/open.html
> > 
> > The manpage for open() says only:
> > 
> >        EOPNOTSUPP
> >               The filesystem containing pathname does not support O_TMPFILE.
> > 
> > What is the poor userland developer to make of this when open() starts
> > returning EOPNOTSUPP without O_TMPFILE being specified?
> 
> So I wouldn't care as much about POSIX, we largely ignore it anyway in the
> kernel. But I tend to agree that changing the error code we returned for
> several decades just for the sake of "cleanliness" isn't IMHO a good enough
> reason to risk breaking userspace or causing confusion.
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

For what its worth, the EACCES return value for not having a create() call on
the fs is also not specified in the open() man page. For mkdir, EPERM IS specified.

But in general, can we never add new error codes to any syscall? Are there user
programs that do neatly check for each specified error code in the man page, but
that do not implement a fallback at all? I mean, I am not unsympathetic to the
arguments that you and Jeff make, but such a user program would be odd.

Best,
Jori.
