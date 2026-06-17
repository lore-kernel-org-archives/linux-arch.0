Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBF744B68E
	for <linux-arch@vger.kernel.org>; Wed, 17 Jun 2026 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707508; cv=none; b=Ooi/OTUmbu/Nd3/R6fVOXpx4KEyf6gKVSXx9KBJOv+ugRj8xO/KniXUCgbvojvkkeInfvPPYwKR6C+ppfZ+0+5SfPGmIhy7bfvVSvFEo2eTfRhoX4G2yShurLGSOL8DrbM7SGqNH6FKOO5VOrWCehq+OgOKeXS/tG2cTK1bc40o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707508; c=relaxed/simple;
	bh=Wjebvt+/HMDVq6NvMreZPnc/Hpe/ljpU0C7lL3f/kAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDn0IhMFlXXG/uJYGVn9IFr6r8OGYdUQBm6t6+0n6S1Ndr/bjGZ3UaJLOb4OQUBrN/X+iO7nBJiOvHKRFjWUXY9gG/EAPlfxyiMw9JgiY/7vOKKSlKIUn5+qXWg7IS4F29dn9sSc71vV37XWzBx6ywo2clGzIR0oXXLk+iyTDYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sA99UH9E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+9RctsNO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sA99UH9E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+9RctsNO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sA99UH9E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+9RctsNO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sA99UH9E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+9RctsNO"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E22D6C188;
	Wed, 17 Jun 2026 14:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781707505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXEQBvVn+HV2ICUcFECMY5al1JyFoCvmK1kLXmm+dUk=;
	b=sA99UH9EfIZuQ3XzOl0+ILdUMrUyw+I+sOzLKSgr72NpaOAqx0ZsNCxZjP1LmdrqVbCLgO
	DmqQMRJWqRhLPEwgs/Xje6XXIr9JAA+NE/JY0wkwVOfECSkI9vL2LTQCJHti6ZK/BrmwGO
	Y+jXkZw0uxRhghIT4zW3qdohp7eA/Uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781707505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXEQBvVn+HV2ICUcFECMY5al1JyFoCvmK1kLXmm+dUk=;
	b=+9RctsNO9Sbh+MpI9cMTvruyJRzfNHkFpmBxw3R31ky3FQNO9313vKJB9K3A+zn4rEHQQf
	GYf//d55Qx+9fVAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781707505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXEQBvVn+HV2ICUcFECMY5al1JyFoCvmK1kLXmm+dUk=;
	b=sA99UH9EfIZuQ3XzOl0+ILdUMrUyw+I+sOzLKSgr72NpaOAqx0ZsNCxZjP1LmdrqVbCLgO
	DmqQMRJWqRhLPEwgs/Xje6XXIr9JAA+NE/JY0wkwVOfECSkI9vL2LTQCJHti6ZK/BrmwGO
	Y+jXkZw0uxRhghIT4zW3qdohp7eA/Uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781707505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXEQBvVn+HV2ICUcFECMY5al1JyFoCvmK1kLXmm+dUk=;
	b=+9RctsNO9Sbh+MpI9cMTvruyJRzfNHkFpmBxw3R31ky3FQNO9313vKJB9K3A+zn4rEHQQf
	GYf//d55Qx+9fVAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A554D779A8;
	Wed, 17 Jun 2026 14:45:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pq/uJPCyMmqWMAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 17 Jun 2026 14:45:04 +0000
Date: Wed, 17 Jun 2026 15:44:57 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Jan Kara <jack@suse.cz>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] vfs: missing inode operation should return a consistent
 error code
Message-ID: <ajKve--rL2tg7n2j@pedro-suse>
References: <20260531104947.6142-1-jkoolstra@xs4all.nl>
 <c5e32b78aeaa833d18d9b7a566358a6f71d09f23.camel@kernel.org>
 <xdknvjlda7wxwo35toe357nnyaydsllv5g65ogzsomxqgm7jfu@qwtugpoy2rcw>
 <2002074169.107129.1780331273724@kpc.webmail.kpnmail.nl>
 <m5fqzr2ny4zb36u6zhmrrxgl36ycsxvlqnzf5idvsq4lxpfh3i@g276qtqgfv3f>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m5fqzr2ny4zb36u6zhmrrxgl36ycsxvlqnzf5idvsq4lxpfh3i@g276qtqgfv3f>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[xs4all.nl,kernel.org,zeniv.linux.org.uk,arndb.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opengroup.org:url,suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -3.80

On Mon, Jun 01, 2026 at 06:50:10PM +0200, Jan Kara wrote:
> On Mon 01-06-26 18:27:53, Jori Koolstra wrote:
> > 
> > > Op 01-06-2026 17:58 CEST schreef Jan Kara <jack@suse.cz>:
> > > 
> > >  
> > > On Sun 31-05-26 10:08:47, Jeff Layton wrote:
> > > > 
> > > > This seems ill-advised. The problem is that most of this behavior has
> > > > been well established for years, and not all userland software (and
> > > > even some internal callers like nfsd), will react well when you go
> > > > changing behavior like this.
> > > > 
> > > > As a case in point, the POSIX spec doesn't list EOPNOTSUPP as a valid
> > > > error return for open():
> > > > 
> > > >    https://pubs.opengroup.org/onlinepubs/9690949399/functions/open.html
> > > > 
> > > > The manpage for open() says only:
> > > > 
> > > >        EOPNOTSUPP
> > > >               The filesystem containing pathname does not support O_TMPFILE.
> > > > 
> > > > What is the poor userland developer to make of this when open() starts
> > > > returning EOPNOTSUPP without O_TMPFILE being specified?
> > > 
> > > So I wouldn't care as much about POSIX, we largely ignore it anyway in the
> > > kernel. But I tend to agree that changing the error code we returned for
> > > several decades just for the sake of "cleanliness" isn't IMHO a good enough
> > > reason to risk breaking userspace or causing confusion.
> > > 
> > > 								Honza
> > > -- 
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
> > 
> > For what its worth, the EACCES return value for not having a create()
> > call on the fs is also not specified in the open() man page. For mkdir,
> > EPERM IS specified.
> 
> Yep, as I said we don't really follow POSIX closely. And it goes way
> further than just error code :)

Not trying to excessively necro here (just seen this thread), but I'll
have to interject here: POSIX very much lets you return whatever error codes
you want. Quoting directly from POSIX.1-2024 (System Interfaces, 2.3 Error Numbers)

> Implementations may support additional errors not included in this list,
> may generate errors included in this list under circumstances other than
> those described here, or may contain extensions or limitations that prevent
> some errors from occurring.

and also:
> Implementations may generate error numbers listed here under circumstances
> other than those described [...]
> Implementations shall not generate a different error number from one
> required by this volume of POSIX.1-2024 for an error condition described
> in this volume of POSIX.1-2024, but may generate additional errors unless
> explicitly disallowed for a particular function.

which pretty much give you the freedom to do whatever you want (and that's how
I've seen other people language-lawyer this as well).

So, yes, while it is true that the kernel sometimes treats POSIX as merely a
suggestion, in this case we're strictly adhering :)


> 
> > But in general, can we never add new error codes to any syscall? Are
> > there user programs that do neatly check for each specified error code in
> > the man page, but that do not implement a fallback at all? I mean, I am
> > not unsympathetic to the arguments that you and Jeff make, but such a
> > user program would be odd.
> 
> We certainly can (and sometimes do) modify the returned errors. It is
> always just a balancing act between the benefit of the change and chances
> somebody will get broken by it. In this case I don't quite see the
> benefit, not that I'd be too worried about the a regression but there's
> always the chance...
> 

FWIW my opinion here would be that changing the error number doesn't _really_
matter. Filesystems with missing ops are generally already outliers in "sane
filesystems semantics ", and it's unlikely that someone is doing something like

if (unlink(path) < 0 && errno == EPERM) {
	printf("path is bad since you can't unlink it!!!\n");
}

particularly as most of these error numbers are actually impossible to
distinguish (I don't have permissions on the filesystem, or does the
filesystem not implement this op?).


-- 
Pedro
