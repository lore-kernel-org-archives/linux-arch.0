Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6A32938D
	for <linux-arch@vger.kernel.org>; Mon,  1 Jun 2026 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332614; cv=none; b=HkmcQ0PwsYfz1VzQaCZGuh52f3dMuyma7EFIeZECnxn+tdSCN0u+Y8bc6aJ0mkfoMHCCQgP9Ocnp+XrJHJHFdkZDec5aeLHmaQJxjuQ+z0PLf0te3v0G1dboY5TjIWD5rUhqhPh9OwiYgqy25slNXB9gJKE1y4IA6U7gc9NcDlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332614; c=relaxed/simple;
	bh=hT6LMn4LTw78t2l5UXwfzadNRG687jtPT+Yv4jcZPJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agNBeS/qSJop/TqIgRF+/LBAgQbXrPaEccanRuMcIQy7aZIVoRwuiwKIUgsCj2jTSTKdfNOBbdKldmZczqoDV2wYTcXUcXW5EE3Wg5+PuULnTWqaKugbAHpuxSVhZbe9jLfsyv/C+KG0jckdUDrgpdBr0bwngOWGSZyJsglxcCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ta1Fg9aS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/d50ojjF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ta1Fg9aS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/d50ojjF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ta1Fg9aS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/d50ojjF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ta1Fg9aS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/d50ojjF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8488C670A2;
	Mon,  1 Jun 2026 16:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780332611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t04bI625rNgFcDYQ7YzLXL+s401yAKNYuMoBEuMuXXc=;
	b=Ta1Fg9aS9I4bnXQjLq8WjVCauFbRDF4hJAYMeaKkvAyJvJhe0bE9D0idDtOr1xu9wE1xYp
	B+ix7WPeQh0IUt9ffvSAoxDGW3DrGasPJDPcbKNY8Bo3N4G1uOSYr64HAKa/pboPtOBl0U
	+Yt+k/mVKm+PklMQs7hrO3lV6Z2SBM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780332611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t04bI625rNgFcDYQ7YzLXL+s401yAKNYuMoBEuMuXXc=;
	b=/d50ojjFMxnPPn7a70xRuAWaHfQ4XXqiWd7IdTmGihgpObhCuhrY8PbEYCERfcov1MRuNm
	f9DEAcbz6rVXOJCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ta1Fg9aS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/d50ojjF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780332611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t04bI625rNgFcDYQ7YzLXL+s401yAKNYuMoBEuMuXXc=;
	b=Ta1Fg9aS9I4bnXQjLq8WjVCauFbRDF4hJAYMeaKkvAyJvJhe0bE9D0idDtOr1xu9wE1xYp
	B+ix7WPeQh0IUt9ffvSAoxDGW3DrGasPJDPcbKNY8Bo3N4G1uOSYr64HAKa/pboPtOBl0U
	+Yt+k/mVKm+PklMQs7hrO3lV6Z2SBM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780332611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t04bI625rNgFcDYQ7YzLXL+s401yAKNYuMoBEuMuXXc=;
	b=/d50ojjFMxnPPn7a70xRuAWaHfQ4XXqiWd7IdTmGihgpObhCuhrY8PbEYCERfcov1MRuNm
	f9DEAcbz6rVXOJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78A9C779A7;
	Mon,  1 Jun 2026 16:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7TtvHUO4HWqgEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Jun 2026 16:50:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E37EFA0EC0; Mon, 01 Jun 2026 18:50:10 +0200 (CEST)
Date: Mon, 1 Jun 2026 18:50:10 +0200
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] vfs: missing inode operation should return a consistent
 error code
Message-ID: <m5fqzr2ny4zb36u6zhmrrxgl36ycsxvlqnzf5idvsq4lxpfh3i@g276qtqgfv3f>
References: <20260531104947.6142-1-jkoolstra@xs4all.nl>
 <c5e32b78aeaa833d18d9b7a566358a6f71d09f23.camel@kernel.org>
 <xdknvjlda7wxwo35toe357nnyaydsllv5g65ogzsomxqgm7jfu@qwtugpoy2rcw>
 <2002074169.107129.1780331273724@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2002074169.107129.1780331273724@kpc.webmail.kpnmail.nl>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8488C670A2
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[xs4all.nl];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email,opengroup.org:url];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon 01-06-26 18:27:53, Jori Koolstra wrote:
> 
> > Op 01-06-2026 17:58 CEST schreef Jan Kara <jack@suse.cz>:
> > 
> >  
> > On Sun 31-05-26 10:08:47, Jeff Layton wrote:
> > > 
> > > This seems ill-advised. The problem is that most of this behavior has
> > > been well established for years, and not all userland software (and
> > > even some internal callers like nfsd), will react well when you go
> > > changing behavior like this.
> > > 
> > > As a case in point, the POSIX spec doesn't list EOPNOTSUPP as a valid
> > > error return for open():
> > > 
> > >    https://pubs.opengroup.org/onlinepubs/9690949399/functions/open.html
> > > 
> > > The manpage for open() says only:
> > > 
> > >        EOPNOTSUPP
> > >               The filesystem containing pathname does not support O_TMPFILE.
> > > 
> > > What is the poor userland developer to make of this when open() starts
> > > returning EOPNOTSUPP without O_TMPFILE being specified?
> > 
> > So I wouldn't care as much about POSIX, we largely ignore it anyway in the
> > kernel. But I tend to agree that changing the error code we returned for
> > several decades just for the sake of "cleanliness" isn't IMHO a good enough
> > reason to risk breaking userspace or causing confusion.
> > 
> > 								Honza
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> 
> For what its worth, the EACCES return value for not having a create()
> call on the fs is also not specified in the open() man page. For mkdir,
> EPERM IS specified.

Yep, as I said we don't really follow POSIX closely. And it goes way
further than just error code :)

> But in general, can we never add new error codes to any syscall? Are
> there user programs that do neatly check for each specified error code in
> the man page, but that do not implement a fallback at all? I mean, I am
> not unsympathetic to the arguments that you and Jeff make, but such a
> user program would be odd.

We certainly can (and sometimes do) modify the returned errors. It is
always just a balancing act between the benefit of the change and chances
somebody will get broken by it. In this case I don't quite see the
benefit, not that I'd be too worried about the a regression but there's
always the chance...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
