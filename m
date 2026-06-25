Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754AE3D88FA
	for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2026 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386313; cv=none; b=F3kvRDqKDvGZLCpsBqsQzSDgJemjV+hmfM+iXEJf/SNfjL/e1AIH8oAXDpqOgsiSZyFJIDdkWNLOj+et7++qY+jMYPK6cJ+JGWRrA1K9fz0/RdQIEGSfO47h+AFgy80QpfkDsc6WE/8luO1FjcHlB4lfefARyr+e8rngV6lOziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386313; c=relaxed/simple;
	bh=ZiX3AX+xmalZO08GejJEj7Xq/wZnK2e2q5clEh53z9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHdysP91VDbg+j9fPjt6Fq8VinNgOD5HFURppLhB9Mgjic0YHs4B7bvaO1k3fh9q5n0NBuVjhm+rhrVAw27uiJzRdMtWhX59Z1Z8AzocDbVC+XZpD0lNIXiRUE4YdGiZeX6pwNAdc3zSpP94KsNWRA2pLF8VRhLKg7fbq6se4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wZ2fd8KF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qVqV3yoj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wTCRJlAg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iBb7rV6+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wZ2fd8KF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qVqV3yoj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wTCRJlAg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iBb7rV6+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDD556AD60;
	Thu, 25 Jun 2026 11:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782386304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wS7HCowsUPsGLWq4kYgveK/eXMt5estp4NToKX/ScHA=;
	b=wZ2fd8KFs12YXaoDgDl0NtnhKN62mrKoMhgGrw/weqg+h3wlB8q/Dd8aEjxPWUb2OGMr+v
	eAjPl+q4BR63uNOeFkHlhMmdqopC/8iW0yMzJ63Di4CKR7UNmYiXVvKSL1n+rGE5VKorXW
	ABHpCJ2iNxH/8ccA3Q1gqp/C926OTlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782386304;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wS7HCowsUPsGLWq4kYgveK/eXMt5estp4NToKX/ScHA=;
	b=qVqV3yoj/MOHmxpi18pJgFl0pJu9724jWCJQ2j7UHUxGnOlWZBoGIX1GgwzMjNoPWcr9yP
	ewm6F23n/PWdxICQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wTCRJlAg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iBb7rV6+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782386303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wS7HCowsUPsGLWq4kYgveK/eXMt5estp4NToKX/ScHA=;
	b=wTCRJlAgCUS7GeSCT8K5uava4RfGrbYoUSWbuchy6dU2QVhXtmz7NZcYWp6gut27uO3Kni
	7zQcotUeL1rElAnYPnAOhMjJ4/LVveXtnWBqF1O+AmtdM0XRKcawuehrU/Gz+eTYFF+gZj
	Ekj0swLGgBIdQA+w/OeiIOQH8e3pA0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782386303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wS7HCowsUPsGLWq4kYgveK/eXMt5estp4NToKX/ScHA=;
	b=iBb7rV6+Sqd2PpPPtA/KItDvtkDbDc4465Qv1vntUlwNV+mafdIKZ/zB6i+oDekOhhEUsO
	FjDOyrE5Wk7VwgDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 969EC779A8;
	Thu, 25 Jun 2026 11:18:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mSuJIX0OPWpLXQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 25 Jun 2026 11:18:21 +0000
Date: Thu, 25 Jun 2026 12:18:19 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, mjguzik@gmail.com, 
	ebiederm@xmission.com, viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, keescook@chromium.org, 
	mcgrof@kernel.org, j.granados@samsung.com, allen.lkml@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Xin Zhao <jackzxcui1989@163.com>, linux-mm@kvack.org
Subject: Re: [PATCH v4] coredump: Add /proc/<pid>/coredump_pre_exit for
 pre-exit before dumping
Message-ID: <aj0Mr3e9yt0kU-Qj@pedro-suse>
References: <20260624145552.70143-1-jackzxcui1989@163.com>
 <20260625-wappnen-drohbrief-wermutstropfen-c53538f01547@brauner>
 <9105c433-44a7-4e8f-bacb-def93d11a7f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9105c433-44a7-4e8f-bacb-def93d11a7f2@kernel.org>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EDD556AD60
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,xmission.com,zeniv.linux.org.uk,suse.cz,oracle.com,arndb.de,chromium.org,samsung.com,vger.kernel.org,163.com,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, Jun 25, 2026 at 12:57:02PM +0200, David Hildenbrand (Arm) wrote:
> >> +
> >>  #define F_DUPFD		0	/* dup */
> >>  #define F_GETFD		1	/* get close_on_exec */
> >>  #define F_SETFD		2	/* set/clear close_on_exec */
> >> diff --git a/kernel/fork.c b/kernel/fork.c
> >> index a679b2448234..84f1ee7f32cf 100644
> >> --- a/kernel/fork.c
> >> +++ b/kernel/fork.c
> >> @@ -1030,6 +1030,18 @@ static int __init coredump_filter_setup(char *s)
> >>  
> >>  __setup("coredump_filter=", coredump_filter_setup);
> >>  
> >> +static unsigned long default_dump_pre_exit;
> >> +
> >> +static int __init coredump_pre_exit_setup(char *s)
> >> +{
> >> +	default_dump_pre_exit =
> >> +		(simple_strtoul(s, NULL, 0) << MMF_DUMP_PRE_EXIT_SHIFT) &
> >> +		MMF_DUMP_PRE_EXIT_MASK;
> >> +	return 1;
> >> +}
> >> +
> >> +__setup("coredump_pre_exit=", coredump_pre_exit_setup);
> > 
> > This makes no sense. I think you really need to sit down and think about
> > a design for this that doesn't introduce state machinery for boot, mm,
> > and the VFS in one shot to solve a fringe problem...
> 
> Staring at exit_mmap_mapped_shared(), ... this looks rather hacky ("let's fake
> munmap and set some magical flags").
> 
> We're essentially saying "we don't want (pretty much) anything that's MAP_SHARED
> in the coredump". And for some reason someone should configure that, that's a
> rather weird toggle tbh.
> 
> And the granularity ("file-backed shared memory") is completely odd.
> 
> 
> Aren't there other ways we could optimize this internally?
> 
> Like, if we know that a process is dead and cannot run anymore, downgrade writes
> to reads (and make sure we block GUP write attempts accordingly), or would that
> also not be sufficient?
> 
> 
> Another thought:
> 
> fs/coredump.c calls get_dump_page().
> 
> get_dump_page() will not fault in any memory. So if a page is not in the page
> tables at the time of the dump, it will not get included in the coredump. Which
> means, that whether most non-anonymous memory will be included in a coredump is
> already like playing the lottery.
> 
> This is true for MAP_SHARED file mappings and MAP_PRIVATE file mappings without
> private modifications.
> 
> Which makes me wonder: How much is tooling relying on file-backed pages to end
> up in a coredump?

FWIW this mechanism already exists, see /proc/self/coredump_filter. The
default is bits 0, 1, 4 and 5 (see core(5)), which maps back to no file pages
being dumped to a core dump, apart from ELF headers (these help the debugger
trace back the mapped binary to the debug info using the buildid).

So the answer to this question is "approximately none" :)

-- 
Pedro
