Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6C12566D3;
	Thu, 18 Jun 2026 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765369; cv=none; b=dA56OJmfLZbsx9G0gXC9md/zRBzivMqRKxo+et+kb7lYVBsTOmJ0z0QE6MKAbxdJiNzL5owVrEkgvo9K4SObDrd25KBBdEZYw2NUFAbIj+dEtM2ZAG9DttqPX3+seELiLHr/cIqo2/aNnDf4zajNxrdLo9csBpPUzKSShqV5MOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765369; c=relaxed/simple;
	bh=gsJf9Jm5coSQi6PJtpTH8ZO3WjpGXpEMR3yZ9eqzbPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BsaKFsOy6r7rcpUp6FXtNHCZLolvgOHjfYp0OW5Uf/mNZXvaD9GUu+bmuSpnizqx1NBdbiZUHd31esdHWDbuhQ08UhqCyIGfOCtGRDS2LhLlIuWwQ8icXXgVJ9BIzROzJDMCw4cUcHqa/OLnb8f9J0Ls+TiDB9oIRe1k0F+G+1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iu1d7Nxn; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iu1d7Nxn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Pg
	0B+9qKQMRhvj5J2hGwz0RIESiJqMrSgNuCqkEtBvA=; b=iu1d7NxnpDvAaAdTKU
	s1dRqVQ9ovgm3up+le1IpR39ERKRZycqYMFgWQWs0jxFNng3Ij/W9dGu0l0IDkhh
	/vu507XLg3M7fwLN9rRaxIjLbmfj1HqpUFqHYeacnkRqA+IS+oWBcIKUl48khWFh
	tUkJKAg5BJYBI2QsBnnF5/knA=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3XynGlDNq3B6NEA--.57322S2;
	Thu, 18 Jun 2026 14:48:40 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: ebiederm@xmission.com
Cc: alex.aring@gmail.com,
	allen.lkml@gmail.com,
	arnd@arndb.de,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	j.granados@samsung.com,
	jack@suse.cz,
	jackzxcui1989@163.com,
	jlayton@kernel.org,
	keescook@chromium.org,
	linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] coredump/fcntl: Add FD_CLOBCOR flag to close fd before dumping core
Date: Thu, 18 Jun 2026 14:48:38 +0800
Message-Id: <20260618064838.2636840-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87zf0se7qi.fsf@email.froward.int.ebiederm.org>
References: <87zf0se7qi.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3XynGlDNq3B6NEA--.57322S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF43JF4kCF48Kw4UWF4kJFb_yoW5XrW8pa
	y5Ka40ya1kKrs7ta97Z3W8A3WFg3yrGFsrXrnxury5Cws8u3WSyF1fKa15ta47JwsYyayY
	qFy7tasrWryYvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRE388UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCwAi+yGozlMhQmwAA3w

On Thu, 18 Jun 2026 00:29:57 -0500 "Eric W. Biederman" <ebiederm@xmission.com> wrote:

> > A coredump typically takes some time to complete. If we happen to hold a
> > write lock with flock just before triggering the coredump, that write lock
> > will not be released during the entire coredump process. As a result,
> > other processes attempting to acquire the same write lock may experience
> > significant delays.
> 
> You are talking about giant processes writing to slow backing store?
> 
> I suspect you would be better off quickly writing the coredump to a pipe,
> and then writing it to disk.
> 
> Unless your machine is badly balanced that should take perhaps a second.
> 
> That said I don't see why you need elaborate machinery to do something
> about these file descriptors.  Unless I am mistaken no file descriptors
> are placed into a coredump.  In which case it should be possible to just
> call exit_files early.

Thank you for your suggestion. Are you suggesting modifying the coredump
path to a location like /tmp and then copying the files from /tmp to the
final storage location? That would indeed be faster, but our tasks
sometimes consume a considerable amount of memory, and the dump time might
still be significant even when using a pipe. For our higher-level code,
even 100 ms might be a bit too long. Additionally, while directly calling
exit_files() in coredump_wait can cover most scenarios, if the
coredump_filter includes (bit 3) file-backed shared memory, it may not be
appropriate to release all files.

I actually prefer to dynamically create the bitmap for determining
close_before_core on demand. If the task hasn't set this attribute, then
we wouldn't create the bitmap, which would also save time on memory
allocation when this feature is not used.


> > To address this, we introduce the F_[GET|SET]FD_EX fcntl operation and the
> > FD_CLOBCOR flag, allowing coredump_wait() to release any file descriptors
> > marked with FD_CLOBCOR. We can also assign the FD_CLOBCOR flag to specific
> > shared memory segments, preventing the coredump from including shared
> > memory that we are not interested in, thereby reducing both the coredump
> > duration and the size of the core file.
> 
> Please look at vma_dump_size.  There are plenty of ways already to
> skip dumping a memory area.  Using file backed shared memory,
> and madvise(MADV_DONTDUMP) are two easy ones that already exist.
> 
> My point is that there are cleaner ways to solve your problem than
> the solutions you have proposed.

This requirement can indeed be addressed with the MADV_DONTDUMP you
mentioned, thank you for your suggestion. But what troubles me is the
scenario mentioned above.

Thanks
Xin Zhao

