Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CB3385D88;
	Thu, 25 Jun 2026 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377482; cv=none; b=noMOxqQV9iAZmha/GRiK7i5H5ywjnmnlcnzywIHdriyhkV4HGxVOc0uS9jFx55Jo/XgYHsTytAGExrpMCAJMARovASL9sEaWYL7Ivyvy2McVop1GRb4p00nrl3kPzlZ84VLV89bE6LalXmQMuRQ0urUTynaSTSy7llq5oeO5kec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377482; c=relaxed/simple;
	bh=F0O7t7c5UVPcwoVCXkPR6WQxH5zs1RGOMHfitvGWpp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hE+qei98jlJqKEH9Zz5GoMNmbp257CNfUS479p6Herpb2AKf7vn/zf3WciI+TjZeaQKAbI0w+gnlzZyBfohXzz4Zmym63TZOg3jo3dw2bn4dl80qkFD8rmk1GHdU8oMO25uWK/egPQtG1dSOeifCYt9zEOjdBGE2hyxLXX0Do8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=k6dtMMJ4; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="k6dtMMJ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dw
	l9BXYyih4rkHzUa6Zl9OdrIWhLlRb0XmAM4mKHrgk=; b=k6dtMMJ4LK2GLoXivM
	TjYxLQ5b1e46NMyHE28KqJqU45H+z6U70sBcxzOM01mejqoQxZLgX/H95UbQrBag
	+0Jfs2ByY0IURORbJCILBincxULrNqhYkkXVCNFwsZCvKZOc5FCxSUYd7V2J+y/v
	gd91mMEsiJEWRd6ugZsmWh3nY=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnLwzK6zxqNeJOEQ--.60795S2;
	Thu, 25 Jun 2026 16:50:19 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: brauner@kernel.org
Cc: alex.aring@gmail.com,
	allen.lkml@gmail.com,
	arnd@arndb.de,
	chuck.lever@oracle.com,
	david@kernel.org,
	ebiederm@xmission.com,
	j.granados@samsung.com,
	jack@suse.cz,
	jackzxcui1989@163.com,
	jlayton@kernel.org,
	keescook@chromium.org,
	linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mcgrof@kernel.org,
	mjguzik@gmail.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4] coredump: Add /proc/<pid>/coredump_pre_exit for pre-exit before dumping
Date: Thu, 25 Jun 2026 16:50:18 +0800
Message-Id: <20260625085018.989584-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625-wappnen-drohbrief-wermutstropfen-c53538f01547@brauner>
References: <20260625-wappnen-drohbrief-wermutstropfen-c53538f01547@brauner>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnLwzK6zxqNeJOEQ--.60795S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw1DGry7Kw1rZFy3CrW3KFg_yoW7Wr1xpF
	WrKa9akr1kGr1Utas7tw18XF10krWfAFW5urn8Ww42v3Z8Cw1fZr1fKFWY93yDArna9w4j
	qr18ta4UCr1qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR7PEsUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC6AzX4Wo868yfCQAA31

On Thu, 25 Jun 2026 09:28:08 +0200 Christian Brauner <brauner@kernel.org> wrote:

> > +	coredump_pre_exit=
> > +			[KNL] Change the default value for
> > +			/proc/<pid>/coredump_pre_exit.
> > +			See also Documentation/filesystems/proc.rst.
> 
> Nah, we're not doing a separate file for this. That makes no sense
> whatsoever. I've already explained this in the first mail. There are
> effectively three modes:
> 
> (1) dump to a file
> (2) spawn super-privileged usermode helper process connect coredumping
>     process and said helper via pipe
> (3) coredumping process connects to AF_UNIX socket
> 
> Parameterize (1) and (2) via a command line arguments. I strongly
> suspect you're using some AI tooling so it should be able to figure out
> how this was done in the past.
> 
> (3) can be extended by just introducing a new flag value for struct
>     coredump_req. That is also illustrated by previous work.
> 
> We're not spreading procfs files. It's terrible api design especially
> for security sensitive changes.

The coredump socket approach is easier to implement because it allows for
interaction between the server and client, enabling the customization of
protocols. However, for the coredump file method, I can only think of
defining "r" and "R" through core_pattern to release flock and file-backed
shared data in advance. I'm unsure if this is feasible, as it changes the
original definition of core_pattern.

Regarding the coredump pipe, there is also a lack of a mechanism for the
pipe program to notify the coredump process, so it might still require
adding "r" and "R" at the end of core_pattern to indicate this, allowing
the coredump process to handle the early release on its own. I'm not sure
if my understanding is correct.

Even if the coredump pipe program obtains the file pointer from the process
that generated the coredump, it cannot reduce the reference count of the
file (which I understand is a very bad attempt). Since it cannot decrease
the reference count of the file, the early release must still be performed
by the task that generated the coredump. Given this situation, it seems
that we indeed need to use core_pattern for marking. I've thought for a
long time about more suitable solutions, but I haven't come up with any.


> > +#ifndef O_TMPCLOS
> > +#define O_TMPCLOS	0x80000000	/* tag need close, temporarily used */
> > +#endif
> 
> Sorry, not going to happen. This doesn't not justify the addition of a
> new uapi value at all.

OK, if I use it at last, I will not put it in user header file.

> > +
> > +__setup("coredump_pre_exit=", coredump_pre_exit_setup);
> 
> This makes no sense. I think you really need to sit down and think about
> a design for this that doesn't introduce state machinery for boot, mm,
> and the VFS in one shot to solve a fringe problem...

I'll get rid of the attempt to add a new boot-up argument for this feature.

> [Severity: High]
> Does modifying the VMA maple tree via do_munmap() during the for_each_vma()
> iteration invalidate the outer iterator? The loop traverses the maple tree
> using the iterator vmi. However, do_munmap() creates its own internal
> VMA_ITERATOR and removes the VMA from the tree. Because the outer vmi
> iterator is not updated to reflect these structural changes, its cached
> state becomes stale, which can lead to a use-after-free when vma_next()
> is subsequently called.
> 
> via: https://sashiko.dev/#/message/20260624145552.70143-1-jackzxcui1989@163.com

When executing this traversal logic, we have already acquired a lock, and
the process has been frozen. The traversal logic goes from start to finish.
Are you sure that this approach could still have issues?

> [Severity: High]
> Is it safe to iterate the file descriptor table without holding
> rcu_read_lock()? Because coredump_pre_exit() is called before zap_threads()
> kills other threads, concurrent threads can still trigger expand_files(),
> which replaces the fdt and frees the old one after an RCU grace period.

Since the process has already been frozen, shouldn't we not need to consider
such concurrency issues?

> [Severity: Medium]
> Similar to the issue in exit_mmap_mapped_shared(), this non-atomic update
> of file->f_flags risks losing concurrent fcntl() updates since it doesn't
> hold file->f_lock.
> 
> Also, if a file has duplicated file descriptors (e.g., via dup()), will
> clearing O_TMPCLOS here prematurely skip the closure of the remaining
> descriptors? When encountering the duplicated descriptor later, the flag
> will already be cleared, leaving the shared file actively referenced.

> [Severity: Medium]
> Similar to the issue in exit_mmap_mapped_shared(), this non-atomic update
> of file->f_flags risks losing concurrent fcntl() updates since it doesn't
> hold file->f_lock.
> 
> Also, if a file has duplicated file descriptors (e.g., via dup()), will
> clearing O_TMPCLOS here prematurely skip the closure of the remaining
> descriptors? When encountering the duplicated descriptor later, the flag
> will already be cleared, leaving the shared file actively referenced.

Currently, this flag will only be used by the logic we added, so I believe
there won't be any issues.

Thanks
Xin Zhao

