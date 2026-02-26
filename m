Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E69E396D3F
	for <linux-arch@vger.kernel.org>; Thu, 26 Feb 2026 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140935; cv=none; b=fDxVO+oKplngIJchiHuEltCvAZ+3Gddzv5FIcpYPghj5ychGRIWFCOV3reoGkTyTHtNFQcRZ4VbRxWGseDp7dnfVYGppIFvkRCazIvDKVeVj3qjeDsNpxX3Y35PKxNGnNujOEk7sYVONL529mRMlvzXkT2jIZVwxqOJP2cSsFQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140935; c=relaxed/simple;
	bh=sfTslLLnI37XJQ6uxMdt3uWTnKJaFYngSG3T3NhVl6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AreZl1lVQX4wzceHh8CTZaY4YKpT+OyDRdJy7/iJzqEGue2MQNsJTTSRiATz1AgSGAZqgxsYLpkUfnsmznGCktaso0DpEQWgu/Lc9x7FRcb/cTMTQPo7lt2nS7Rw1Mq+Qiue8hqsBCeFLju/hIiUQRuzOFjr+YYUdBTui8aoOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E4A24E2DB;
	Thu, 26 Feb 2026 21:22:11 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25AC63EA62;
	Thu, 26 Feb 2026 21:22:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CH6xBYC5oGlMRAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 26 Feb 2026 21:22:08 +0000
Date: Thu, 26 Feb 2026 21:22:06 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	andreyknvl@gmail.com, arnd@arndb.de, bp@alien8.de, brauner@kernel.org, 
	bsegall@google.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	dietmar.eggemann@arm.com, ebiederm@xmission.com, hpa@zytor.com, jakub.wartak@mailbox.org, 
	jannh@google.com, juri.lelli@redhat.com, khalid@kernel.org, 
	liam.howlett@oracle.com, linyongting@bytedance.com, lorenzo.stoakes@oracle.com, 
	luto@kernel.org, markhemm@googlemail.com, maz@kernel.org, mhiramat@kernel.org, 
	mgorman@suse.de, mhocko@suse.com, mingo@redhat.com, muchun.song@linux.dev, 
	neilb@suse.de, osalvador@suse.de, pcc@google.com, peterz@infradead.org, 
	rostedt@goodmis.org, rppt@kernel.org, shakeel.butt@linux.dev, surenb@google.com, 
	tglx@linutronix.de, vasily.averin@linux.dev, vbabka@suse.cz, 
	vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com, 
	willy@infradead.org, x86@kernel.org, xhao@linux.alibaba.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Isaac Manjarres <isaacmanjarres@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	android-mm <android-mm@google.com>
Subject: Re: [PATCH v3 00/22] Add support for shared PTEs across processes
Message-ID: <5tdailzxoywzzunbwhtlk4yjfmzunntniqtudkb52q6hib74ql@oq4mi226dedv>
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <CAC_TJvcaJdEzK8n9BK0qgEXdzjzXtbA_Zk-ybfmG8kjNExVCzw@mail.gmail.com>
 <b82a5ac3-33e9-4cbf-892a-f0c7f6fe0c20@kernel.org>
 <CAC_TJvdgvyjyJsU4v6W+3tHKx_2e8UMJU3RT2HKLSngcC+yH3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_TJvdgvyjyJsU4v6W+3tHKx_2e8UMJU3RT2HKLSngcC+yH3Q@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 6E4A24E2DB
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Wed, Feb 25, 2026 at 03:06:10PM -0800, Kalesh Singh wrote:
> On Tue, Feb 24, 2026 at 1:40 AM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> >
> > > I believe that managing a pseudo-filesystem (msharefs) and mapping via
> > > ioctl during process creation could introduce overhead that impacts
> > > app startup latency. Ideally, child apps shouldn't be aware of this
> > > sharing or need to manage the pseudo-filesystem on their end.
> > All process must be aware of these special semantics.
> >
> > I'd assume that fork() would simply replicate mshare region into the
> > fork'ed child process. So from that point of view, it's "transparent" as
> > in "no special mshare() handling required after fork".
> 
> Hi David,
> 
> That's agood  point. If fork() simply replicates the mshare region, it
> does achieve transparency in terms of setup.
> 
> I am still concerned about transparency in terms of observability.
> Applications and sometimes inspect their own mappings (from
> /proc/self/maps) to locate specific code or data regions for various
> anti-tamper and obfuscation techniques. [2] If those mappings suddenly
> point to an msharefs pseudo-file instead of the expected shared
> library backing, it may break user-space assumptions and cause
> compatibility issues.

I'm not worried about transparency because this is not supposed to be
transparent. This is not supposed to be used by most core system software.
This is supposed to help replace hugetlb page table sharing.

Transparent page table sharing has other constraints. I like the idea, in
theory, but there are a number of constraints that make the idea unfeasible
for now. There are a couple of problems we need to solve first:

1) Every spot where we modify PTEs needs to be assessed and use different
helpers (that can un-cow page tables). Every pte_offset_map_lock() can now
feasibly fail for OOM reasons (and that also needs to be assessed).

2) Various bits of PTE modification/unmapping now needs special care wrt TLB
invalidation. The kernel needs to be aware of how the page tables are shared.
I don't think the current rmap data structures are well suited to this kind
of stuff (perhaps with Lorenzo's WIP anon rmap rework we'll get something
better). Basically every spot that goes "modify PTE, flush TLB for mm" now
needs to go "modify PTE, for every mm that maps this page table, flush $mm"
(if you're thinking that COW will save us, it technically won't, or shouldn't,
because of stuff like try_to_unmap_one() that is used in reclaim).

3) Reclaim loses even more information as now N processes share the same A
bits. I don't know what effects this can cause. It would require
experimentation. Perhaps something like "if page table is shared, value
pte_young more". I don't know if this can work as a bandaid, but it's not
ideal.

4) It's not known whether page table COW fork() is a real win in most cases,
or all cases. Would want measurement.

5) It becomes even harder to estimate RSS and PSS for each process.

For these reasons (and more, certainly), I don't think working mshare() into
a transparent, all-great thing that fits the zygote model can work. It has been
discussed at length how to pull off certain hard bits like TLB invalidation and
locking for mshare, and with mshare we have the advantage of not needing to
support every feature ever (tailoring it more to the big database users of
hugetlb). And we'll still need to adapt certain bits of arch code just to get
it to work efficiently.

This said, if you want to discuss pulling this off, I'm all ears and it could
be perhaps a fun discussion (too late for LSF, I guess), but I don't think
it's workeable into the current mshare efforts. And, believe me, I would love
a unified feature here :)

-- 
Pedro
