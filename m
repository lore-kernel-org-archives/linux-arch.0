Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257041FD4;
	Wed,  1 Jul 2026 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782873223; cv=none; b=tHYi9Rkh/rJgGboAnJ0kKs36qr4sfchN9YbnVXDkDCLJEYZ9vy2+gDMJynUb2IR6CcETnzLA9qHVoTEik4n4SADu6/UazABDesISUDMpZx3H0WhKff+L/tXeuCZB6r2ppeHsWA8cIU2pJh7Uj2SCUFKBRD0MW9f7U3wQh2j52/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782873223; c=relaxed/simple;
	bh=OT6wqOeUGF2XQZyiqqa4L9r4ufXQ+e2YgV3nJulZLrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TtM8PzK+A40qWGAo7yh2VVUbbC557mOPQx41NNBdUTBmzwkDjhkfDWmTKghCD8E8YNxPr5gXJPpFDGeF/D8gC2YCvuXQ60UxqpCT8DM/k7x5o6RXp4V8LgcaWS31gM41kLwvJmcRpsStvBkohm4gIiOFhOpoCcNIKNFQoIBns50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hQPC1aQP; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hQPC1aQP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mQ
	N1IUhhTEXUFB92w3rc4mmoU0B96GEth86y033SCFo=; b=hQPC1aQP7GXuOIIGgW
	6tB9hTq7bS3wbNyYvHbTWFOcdcCqWTZNGAhzmd35x2rTQhbq5GP0VR+OMt6Jh3Q2
	0XLsLRuuncqYMfAF19cM4uiLqQbb/CaTRfq7dXXLXQ4ZP/xBrQedICUyMXhtIYQV
	bqpoIPoJHmFtqnPMGS6DhDFu4=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCX3EcXfERqS6ElGw--.58356S2;
	Wed, 01 Jul 2026 10:31:52 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: brauner@kernel.org
Cc: akpm@linux-foundation.org,
	alex.aring@gmail.com,
	allen.lkml@gmail.com,
	arnd@arndb.de,
	chuck.lever@oracle.com,
	corbet@lwn.net,
	david@kernel.org,
	ebiederm@xmission.com,
	j.granados@samsung.com,
	jack@suse.cz,
	jackzxcui1989@163.com,
	jlayton@kernel.org,
	juri.lelli@redhat.com,
	keescook@chromium.org,
	kuba@kernel.org,
	liam@infradead.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mcgrof@kernel.org,
	mhocko@suse.com,
	mingo@redhat.com,
	mjguzik@gmail.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	rppt@kernel.org,
	skhan@linuxfoundation.org,
	surenb@google.com,
	vbabka@kernel.org,
	vincent.guittot@linaro.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5] coredump: Add bit 9 of coredump_filter for pre-exit files before dumping
Date: Wed,  1 Jul 2026 10:31:51 +0800
Message-Id: <20260701023151.694758-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630-alzheimer-mahlzeit-mutlos-4641a5947a04@brauner>
References: <20260630-alzheimer-mahlzeit-mutlos-4641a5947a04@brauner>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCX3EcXfERqS6ElGw--.58356S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWrAFyfAw1ftw4UXFWxtFb_yoWrAw1kpF
	WrKay0kF4kG3yxt34xAw45XF1rCw1ftrs8Zr1Fgwn5A398A34Svr1xtFy5Zas8Crs2yw4j
	qw12va47C34qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUouWQUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCvxnQ2mpEfBkuNgAA3-

On Tue, 30 Jun 2026 13:50:15 +0200 Christian Brauner <brauner@kernel.org> wrote:

> > + * If do not dump fd list, files that are not referenced by any VMA
> > + * can be released before dumping core. Therefore, some file release
> > + * logic, such as exiting flock or releasing references to shared
> > + * buffers is executed much earlier. Note that do_coredump() often
> > + * takes several seconds or even longer to execute.
> > + */
> > +static void coredump_pre_exit(void)
> > +{
> > +	struct task_struct *tsk = current, *t;
> > +
> > +	if (mm_flags_test(MMF_DUMP_FD_LIST, tsk->mm))
> > +		return;
> 
> Why does this hanging off of mm?

Like other bits of coredump_filter, it is actually attached to the mm flags.

> Even if we wanted to do this it is fundamentally the wrong primitive for
> this. I would envision that anything that wanted to "zap" file
> descriptors synchronously would either have to do it synchronously or
> offload it to a delayed coredump list and wait for it to have drained.
> 
> I dislike both options... Without thorough anaylsis I'm not even sure if

Are you saying that the file release operation must be performed in the
context of each task_struct? I'm not quite clear on the necessity of doing
this. The execution of exit_files merely reduces the reference count of
the file_struct for the thread, rather than decreasing the reference count
of each individual file.

> taking out files out of order with other exit-related cleanup will not
> end up causing fun bugs. Meaning:
> 
> [...]
> exit_sem(tsk);
> exit_shm(tsk);
> exit_files(tsk);
> 
> anything before that might implicitly relying on files struct being
> sane or some other subtle interactions. My appetite to dig into this
> just to make this questionable patch mergeable isn't very high...

The essence of file descriptors (fd) is to allow processes to reference
specific files through an index. The fundamental purpose of exit_files()
is that when a process exits, it no longer needs to reference files by
their indices. From this perspective, I don't see it causing any issues,
because even if functions like exit_sem and exit_shm need to use file
instances, they won't use the fd index; instead, they will increase the
reference count of the file as needed in the prior logic. By the time the
core dump begins execution, user-space logic will no longer be running.
Therefore, as long as the contents of the core dump do not require the
mapping relationship between fd and file, the file can be safely put.


> > -	if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
> > +	/*
> > +	 * coredump_pre_exit() may release files before dumping core.
> > +	 * Cannot use task_work in the case, needs to release files
> > +	 * earlier."
> 
> And it does that by offloading the closing of files to a kthread that
> runs asynchronously?

yes


> Also, as was pointed out in other parts of the thread: files are shared
> _across_ thread-groups not just within thread-groups. Anything that does
> SCM_RIGHTS or has done some pidfd_getfd() dance - however unlikely -
> might still hold that file alive and you have zero chances of getting it
> out of its hands.
> 
> If this is so critical, just skip the coredump via COREDUMP_REJECT or
> similar means.

> > +	 */
> > +	if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD | PF_DUMPCORE))) {
> 
> This:
> 
> (task->flags & PF_KTHREAD | PF_DUMPCORE)
> 
> will have interesting side-effects for everyone else...

As you mentioned, other processes may potentially reference these files
across processes, so even if a core dump is not triggered, the file
release actions are not entirely executed within task_work. Because after
a process exits, other processes may still hold references to the file,
the work for releasing the file cannot be added to task_work at that
point. In this case, it still uses schedule_delayed_work().

If kernel developers do not correctly implement the file release
operation, such as relying on certain information from the task context to
free related resources, then the issues arising from such unreasonable
release operations will manifest in other scenarios, regardless of my
changes. My modifications only amplify this problem in the context of core
dumps.


Thanks
Xin Zhao

