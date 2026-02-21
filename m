Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334D329BDB5
	for <linux-arch@vger.kernel.org>; Sat, 21 Feb 2026 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771677641; cv=none; b=IsmxAJzbKS7qbymZ21FJjS/ANEBZIhTk2TRKrVXvtVyZl/TC8T6D0y4U4RuAXhcBwqaWbOq0wb0YTCfgMHTAXD3McB/BmJPsgJxd7YAX8mYki38FFsCMoUBZFCofSbsOq14U4Sf5719yemcwJCfhIITzFSburVVkOogpz1xFeS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771677641; c=relaxed/simple;
	bh=iuOTQHaB/7SiQvOeGfi38s+5rGd70RrLovApNaBRu0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Puo8weIOUaGpNQ2LDgzdDqkWe8pOP92UzNZT7ZOjLJ/2Y0PAPFcjTZbM+Lnn09PXV6QDcdmz2rr990/af7cSnVWxpI/xRRgvCKlzzAk/t3/Vgqe92tDZ7CrXpdVoUFsp8nkzteMREbbjkglZWrTU9NG6UFCUddb9h5Q4CYFCgN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jrOe8ov3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D7VDnLHe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jrOe8ov3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D7VDnLHe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jrOe8ov3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D7VDnLHe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jrOe8ov3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D7VDnLHe"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3050D5BD3F;
	Sat, 21 Feb 2026 12:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771677638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4DZA0cZrsuyUDUuxvrOVRkY0/iTG4B7ICkpMg3aNYg=;
	b=jrOe8ov37EkB2K7QUZplzqcG8pi2oFUc+DYcV5zsv+Xkl2edFU7SkkkDGLgvMAToMW3SH+
	7vcbBFZPYExHZI69VAyShBS8Kf24Z/6Uwf6v9iLGPtjZgGs/zDZwO/LnTT8vH6pcMKKtYb
	gXOA/9laRLea0QhjV9HmHcNE5tn711c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771677638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4DZA0cZrsuyUDUuxvrOVRkY0/iTG4B7ICkpMg3aNYg=;
	b=D7VDnLHe6UuPsUfysJ7Ghv4MGZ8WJ9s9uJwsuA4Dj32i9htGLmbvxBcMAHDU3/gQvETS2l
	ItKxEdXlWgd7+CCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771677638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4DZA0cZrsuyUDUuxvrOVRkY0/iTG4B7ICkpMg3aNYg=;
	b=jrOe8ov37EkB2K7QUZplzqcG8pi2oFUc+DYcV5zsv+Xkl2edFU7SkkkDGLgvMAToMW3SH+
	7vcbBFZPYExHZI69VAyShBS8Kf24Z/6Uwf6v9iLGPtjZgGs/zDZwO/LnTT8vH6pcMKKtYb
	gXOA/9laRLea0QhjV9HmHcNE5tn711c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771677638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4DZA0cZrsuyUDUuxvrOVRkY0/iTG4B7ICkpMg3aNYg=;
	b=D7VDnLHe6UuPsUfysJ7Ghv4MGZ8WJ9s9uJwsuA4Dj32i9htGLmbvxBcMAHDU3/gQvETS2l
	ItKxEdXlWgd7+CCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 155683EA63;
	Sat, 21 Feb 2026 12:40:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jg9uAcOnmWm7UAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Sat, 21 Feb 2026 12:40:35 +0000
Date: Sat, 21 Feb 2026 12:40:33 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de, bp@alien8.de, 
	brauner@kernel.org, bsegall@google.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	david@redhat.com, dietmar.eggemann@arm.com, ebiederm@xmission.com, hpa@zytor.com, 
	jakub.wartak@mailbox.org, jannh@google.com, juri.lelli@redhat.com, khalid@kernel.org, 
	liam.howlett@oracle.com, linyongting@bytedance.com, lorenzo.stoakes@oracle.com, 
	luto@kernel.org, markhemm@googlemail.com, maz@kernel.org, mhiramat@kernel.org, 
	mgorman@suse.de, mhocko@suse.com, mingo@redhat.com, muchun.song@linux.dev, 
	neilb@suse.de, osalvador@suse.de, pcc@google.com, peterz@infradead.org, 
	rostedt@goodmis.org, rppt@kernel.org, shakeel.butt@linux.dev, surenb@google.com, 
	tglx@linutronix.de, vasily.averin@linux.dev, vbabka@suse.cz, 
	vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com, 
	willy@infradead.org, x86@kernel.org, xhao@linux.alibaba.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 00/22] Add support for shared PTEs across processes
Message-ID: <fqabaahjjlmoc2xh4cwh4ykbqyu3rnzvjw5epxi5wwpmgqth7f@d3mqpjozwmo4>
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <CAC_TJvcaJdEzK8n9BK0qgEXdzjzXtbA_Zk-ybfmG8kjNExVCzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_TJvcaJdEzK8n9BK0qgEXdzjzXtbA_Zk-ybfmG8kjNExVCzw@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[oracle.com,kvack.org,linux-foundation.org,gmail.com,arndb.de,alien8.de,kernel.org,google.com,lwn.net,linux.intel.com,redhat.com,arm.com,xmission.com,zytor.com,mailbox.org,bytedance.com,googlemail.com,suse.de,suse.com,linux.dev,infradead.org,goodmis.org,linutronix.de,suse.cz,linaro.org,zeniv.linux.org.uk,linux.alibaba.com,vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL3mhzhn45zpqpmgqn4z7synfm)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,googlemail.com];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_GT_50(0.00)[50];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Fri, Feb 20, 2026 at 01:35:58PM -0800, Kalesh Singh wrote:
> On Tue, Aug 19, 2025 at 6:57 PM Anthony Yznaga
> <anthony.yznaga@oracle.com> wrote:
> >
> > Memory pages shared between processes require page table entries
> > (PTEs) for each process. Each of these PTEs consume some of
> > the memory and as long as the number of mappings being maintained
> > is small enough, this space consumed by page tables is not
> > objectionable. When very few memory pages are shared between
> > processes, the number of PTEs to maintain is mostly constrained by
> > the number of pages of memory on the system. As the number of shared
> > pages and the number of times pages are shared goes up, amount of
> > memory consumed by page tables starts to become significant. This
> > issue does not apply to threads. Any number of threads can share the
> > same pages inside a process while sharing the same PTEs. Extending
> > this same model to sharing pages across processes can eliminate this
> > issue for sharing across processes as well.
> >
> > <snip> 
> Hi Anthony,
> 
> Thanks for continuing to push this forward, and apologies for joining
> this discussion late. I am likely missing some context from the
> various previous iterations of this feature, but I'd like to throw
> another use case into the mix to be considered around the design of
> the sharing API.
> 
> We are exploring a similar optimization for Android to reduce page
> table overhead. In Android, we preload many ELF mappings in the Zygote
> process to help application launch times. Since the Zygote model is
> fork-but-no-exec, all applications inherit these mappings, which can
> result in upwards of 200 MB of redundant page table overhead per
> device.

This can be solved by simply not using the Zygote model :p Or perhaps
MADV_DONTNEED/straight up unmapping libraries you don't need in the child's
side.

> 
> I believe that managing a pseudo-filesystem (msharefs) and mapping via
> ioctl during process creation could introduce overhead that impacts
> app startup latency. Ideally, child apps shouldn't be aware of this
> sharing or need to manage the pseudo-filesystem on their end. To
> achieve this "transparent" sharing, I would prefer Khalid's previous
> API from his 2022 RFC [1]. By attaching the shared mm directly to the
> file's address_space and exposing a MAP_SHARED_PT flag, child apps
> could transparently inherit the shared page tables during fork().

So, we've discussed this before. I initially liked this idea a lot more.
However, there are a couple of problems here:

1) mshare (as in the mshare feature) isn't really aiming for transparent here.
There is e.g a specific need to setup an mshare region, with a few files/anon
there, and then later mprotect/munmap parts of the region - and have it apply
on every process that has it mapped. This is why we're aiming for different
system calls (not ioctls anymore), doing munmap(mshare_reg, 4096) is ambiguous
as to whether you want to unmap the mshare VMA, or a VMA inside the mshare mm.

2) Sharing the page table at all (even worse so, Transparently(tm)) is a huge
pain. TLB shootdown becomes much harder, and rmap as-is isn't suited to deal
with this case. The way things are going with mshare, the container mm will
have one single entry in rmap, and then actually doing the shootdown is a
huuuuge pain (which, fwiw, will probably need a per-mshare TLB workaround),
because you need to find out and shoot down _every_ mm that has these tables
mapped. And then, naturally, since you're sharing page tables, doing A/D bit
collection on these becomes extremely useless - and that will naturally pose
problems to the reclaim process if you abuse it.

3) other misc problems that make it hard to work transparently (VMA alignment,
levels which you may or may not want to share, you need to revisit most page
table walkers in the kernel to get a completely transparent feature, etc)

> 
> Regarding David's and Matthew's discussion on VMA-modifying functions,
> I would lean towards the standard VMA manipulating APIs should be
> preferred over custom ioctls to preserve transparency for user-space.
> Perhaps whether or not these modifications persist across all sharing
> processes needs to be configurable? It seems that for database
> workloads, having the updates reflected everywhere would be the
> desired behavior. In the use case described for Android, we don't want
> apps to be able to modify these shared ELF mappings. To handle this,
> it's likely we would do something like mseal() the VMAs in the dynamic
> loader before forking.

mshare_mseal!

> 
> Perhaps we could decouple the core sharing logic from the sharing API
> itself? Since the sharing interface seems one of  the main areas where
> we don't have a good consensus yet, perhaps we could land the core
> sharing logic first. Keeping the core infrastructure generic would

I think the core infrastructure is relatively generic (at least the
small core mm modifications to get this to even work) already, but
perhaps Anthony can comment on that.

-- 
Pedro
