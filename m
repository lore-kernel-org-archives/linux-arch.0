Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A499347503
	for <linux-arch@vger.kernel.org>; Thu, 18 Jun 2026 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803165; cv=none; b=svdV8WH3YL2XumvH6T8Yz/Uby8olJL8dd1bYIEotH2OFADO0ZcNIMYegqGIcOc8GmpSwww4o81bM18vss89vWA13Jij1uIQ6o5Xds1HxAIuTgGtOxZCiH4uq4CAAghJbyGs4605ht2/jtCd9sfz/me8e9sM4xN69Brk8yKpz/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803165; c=relaxed/simple;
	bh=5v034CzRTk8Fb+3Cbl2AVh9LhYd/4n6mWej6osKYlSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Joqgs2/5zLaTS4UVLx1OwVLSbZ0/A7WF2VSLXUfZZAvbWJsCJVCkzILEZ8S9ibntnDeP0/li2lD2uy7sfn03ZuuN6VITvZc4z/VO1GzMZb3E/Qd2RBLjuoJccnb3RdRjtW25eXFr1ERFL4ZdDWjOJP03KgQXccdMNk6IYyBmzWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e2c5GKd9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5WvjdSkI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e2c5GKd9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5WvjdSkI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e2c5GKd9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5WvjdSkI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e2c5GKd9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5WvjdSkI"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7CFA475FA1;
	Thu, 18 Jun 2026 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781803159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hROrc8eiBZNyznhnY3+MBE4L9Ibi1NC/KjhPVJqBIdU=;
	b=e2c5GKd9dl7aCWo9hYbSx80laQRRTBo40szpaOgZv8Ythhqk+VWIbps9ZMMZxhxWPgz/1x
	LQEfPfpdD+SQQmXy8jY5s0hIhemmXLW/PmGninbMpVXsAuL+45q0s+ck6pVgqJXH1D7+w+
	Z18H8ShxCx806lhTYt9gLJzFii5olnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781803159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hROrc8eiBZNyznhnY3+MBE4L9Ibi1NC/KjhPVJqBIdU=;
	b=5WvjdSkIMuV1SZlW/7G3V35Apk5Udo7cJUThacQpyfE2g7RctNIvM5AIEmWBh5hR0uKsXt
	OP5NscXfRuiQwpAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781803159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hROrc8eiBZNyznhnY3+MBE4L9Ibi1NC/KjhPVJqBIdU=;
	b=e2c5GKd9dl7aCWo9hYbSx80laQRRTBo40szpaOgZv8Ythhqk+VWIbps9ZMMZxhxWPgz/1x
	LQEfPfpdD+SQQmXy8jY5s0hIhemmXLW/PmGninbMpVXsAuL+45q0s+ck6pVgqJXH1D7+w+
	Z18H8ShxCx806lhTYt9gLJzFii5olnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781803159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hROrc8eiBZNyznhnY3+MBE4L9Ibi1NC/KjhPVJqBIdU=;
	b=5WvjdSkIMuV1SZlW/7G3V35Apk5Udo7cJUThacQpyfE2g7RctNIvM5AIEmWBh5hR0uKsXt
	OP5NscXfRuiQwpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 656B4779A8;
	Thu, 18 Jun 2026 17:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z9TqFJYoNGq7RAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 18 Jun 2026 17:19:18 +0000
Date: Thu, 18 Jun 2026 18:19:16 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	ebiederm@xmission.com, keescook@chromium.org, mcgrof@kernel.org, j.granados@samsung.com, 
	allen.lkml@gmail.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] coredump: exit_files() in coredump_wait() if
 MMF_DUMP_MAPPED_SHARED is not set
Message-ID: <ajQoFeTyIqh6tMVv@pedro-suse>
References: <20260618150301.3226517-1-jackzxcui1989@163.com>
 <ajQXNRT5PnBgh48M@pedro-suse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajQXNRT5PnBgh48M@pedro-suse>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,xmission.com,chromium.org,samsung.com,vger.kernel.org];
	FREEMAIL_TO(0.00)[163.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Thu, Jun 18, 2026 at 05:07:56PM +0100, Pedro Falcato wrote:
> On Thu, Jun 18, 2026 at 11:03:01PM +0800, Xin Zhao wrote:
> > A coredump typically takes some time to complete. If we happen to hold a
> > write lock with flock just before triggering the coredump, that write lock
> > will not be released during the entire coredump process. As a result,
> > other processes attempting to acquire the same write lock may experience
> > significant delays.
> > 
> > To address this, call exit_files() in the end of coredump_wait(), if
> > MMF_DUMP_MAPPED_SHARED is not set.
> > 
> > Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> > ---
> > 
> > Change in v2:
> > - Get rid of the implement of adding new fcntl API, the issue does not
> >   worth inflicting the cost on everyone,
> >   as suggested by Al Viro.
> > - Call exit_files() in coredump_wait(),
> >   as suggested by Eric W. Biederman.
> >   Add MMF_DUMP_MAPPED_SHARED mm_flags_test() check to filter cases that
> >   need to dump file-backed shared memory.
> > 
> > v1:
> > - Link to v1: https://lore.kernel.org/all/20260618030700.2511668-1-jackzxcui1989@163.com/
> > ---
> >  fs/coredump.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index bb6fdb1f4..e20baf44f 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> > @@ -548,6 +548,9 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
> >  		}
> >  	}
> >  
> > +	if (!mm_flags_test(MMF_DUMP_MAPPED_SHARED, tsk->mm))
> > +		exit_files(tsk);
> 
> Memory mapped files keep their own separate references to the files
> (in struct vm_area_struct::vm_file), so there is no need to attempt to
> work around this. Unless I'm misunderstanding what you're attempting
> to work around.

Waiit, I think I get it - you have a flock on a file, and you're scared
that if you unlock early, some other process can lock it and modify some other
file we have mapped? If so, that does make some sense. Please add that as
a comment and/or into the git log, because it feels very much non-obvious
to me.

-- 
Pedro
