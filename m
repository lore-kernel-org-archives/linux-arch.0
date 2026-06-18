Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC7231ED7D
	for <linux-arch@vger.kernel.org>; Thu, 18 Jun 2026 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798880; cv=none; b=KX0YuVa/3Vvoq2PJi/8TRslqxaKQdQHOcYbvmTtsdEohJ577NYaU2tyUjuE4j1Rp9k8zxn/sIY6g+tXHFKO5b7PDhOWcC+MK+RmCpi0I1ZKkQbwiRD0RR+tRVz7p2qU+YtI/XUD3AWzbg2qIa2U/XACjzu6+0Zr1p9FPErJCSiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798880; c=relaxed/simple;
	bh=F4xx3GYCkcSsw4ssbt2o/0xtqWS3M7R9/Yh3BsWjfr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUdCINX069h2crU+clLMMVjZb4DhIDJFBppGxWKA14c596oaPQ3jclpz52nbByIz5689++cSmiZHQCqmfvy7DSnZZ5rjOUBtIbjqQK+sEq/ARIGw1lxSlHEQt+DLt/mC0yKURk6+zETi/z6JG43q0+7iv30WjDBr55/KhdrTiSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DiPuAgok; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a1wuA5vC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DiPuAgok; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a1wuA5vC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DiPuAgok";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a1wuA5vC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DiPuAgok";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a1wuA5vC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ABAAB75FAB;
	Thu, 18 Jun 2026 16:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781798876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PvLpkOhIioRSqS74QL2FqmjfAdCdF4mTGjCDuBBhsmI=;
	b=DiPuAgok1jnaWMWawvecwPoC8KZp1wyXzDLysxbtVxi5ZQF9t1lGP13JJ+IoVmfp+FNib7
	sUrvrmaM3jZZGFJfvWpLmObTvnccwm85d1Q+mCjpa8f4YTcv3A9EEG9IiAYn+n4LQpjnET
	l8/nFr7XZiv8X+JCLNn4zI3SvWsZTa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781798876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PvLpkOhIioRSqS74QL2FqmjfAdCdF4mTGjCDuBBhsmI=;
	b=a1wuA5vCeF42aE1af5bXdrS5OkkFavmfi5s4Y2eCVTfIqOhtzwSwmdVsdr6nZXeHQwjYjg
	So++bXL9MsPc3LAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DiPuAgok;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a1wuA5vC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781798876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PvLpkOhIioRSqS74QL2FqmjfAdCdF4mTGjCDuBBhsmI=;
	b=DiPuAgok1jnaWMWawvecwPoC8KZp1wyXzDLysxbtVxi5ZQF9t1lGP13JJ+IoVmfp+FNib7
	sUrvrmaM3jZZGFJfvWpLmObTvnccwm85d1Q+mCjpa8f4YTcv3A9EEG9IiAYn+n4LQpjnET
	l8/nFr7XZiv8X+JCLNn4zI3SvWsZTa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781798876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PvLpkOhIioRSqS74QL2FqmjfAdCdF4mTGjCDuBBhsmI=;
	b=a1wuA5vCeF42aE1af5bXdrS5OkkFavmfi5s4Y2eCVTfIqOhtzwSwmdVsdr6nZXeHQwjYjg
	So++bXL9MsPc3LAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AFE3779A8;
	Thu, 18 Jun 2026 16:07:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gRcPItsXNGplfwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 18 Jun 2026 16:07:55 +0000
Date: Thu, 18 Jun 2026 17:07:53 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	ebiederm@xmission.com, keescook@chromium.org, mcgrof@kernel.org, j.granados@samsung.com, 
	allen.lkml@gmail.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] coredump: exit_files() in coredump_wait() if
 MMF_DUMP_MAPPED_SHARED is not set
Message-ID: <ajQXNRT5PnBgh48M@pedro-suse>
References: <20260618150301.3226517-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618150301.3226517-1-jackzxcui1989@163.com>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[163.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,xmission.com,chromium.org,samsung.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ABAAB75FAB
X-Spam-Score: -2.51

On Thu, Jun 18, 2026 at 11:03:01PM +0800, Xin Zhao wrote:
> A coredump typically takes some time to complete. If we happen to hold a
> write lock with flock just before triggering the coredump, that write lock
> will not be released during the entire coredump process. As a result,
> other processes attempting to acquire the same write lock may experience
> significant delays.
> 
> To address this, call exit_files() in the end of coredump_wait(), if
> MMF_DUMP_MAPPED_SHARED is not set.
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> ---
> 
> Change in v2:
> - Get rid of the implement of adding new fcntl API, the issue does not
>   worth inflicting the cost on everyone,
>   as suggested by Al Viro.
> - Call exit_files() in coredump_wait(),
>   as suggested by Eric W. Biederman.
>   Add MMF_DUMP_MAPPED_SHARED mm_flags_test() check to filter cases that
>   need to dump file-backed shared memory.
> 
> v1:
> - Link to v1: https://lore.kernel.org/all/20260618030700.2511668-1-jackzxcui1989@163.com/
> ---
>  fs/coredump.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index bb6fdb1f4..e20baf44f 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -548,6 +548,9 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
>  		}
>  	}
>  
> +	if (!mm_flags_test(MMF_DUMP_MAPPED_SHARED, tsk->mm))
> +		exit_files(tsk);

Memory mapped files keep their own separate references to the files
(in struct vm_area_struct::vm_file), so there is no need to attempt to
work around this. Unless I'm misunderstanding what you're attempting
to work around.


-- 
Pedro
