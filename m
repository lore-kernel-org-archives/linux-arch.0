Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8594521C173;
	Thu, 18 Jun 2026 04:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758761; cv=none; b=gPE+28VhNdaOOkNMH3Cc9z8YgEFtWJNY9NIB3U23FuHYsB7B/y11A7mhPNr8J2AxEj6X6Y/okixcFgiT8EkPuM7FqHRZtK/GPjTfwsjm7CFOkLAr4rO7GcEcj/6hauQE2hOlhUpeoxvNUVnnkHulVfDSyw4tYgOeXj6ksor6uEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758761; c=relaxed/simple;
	bh=l17WgQ7AsGkpJigcDyq2QvAAZTh5j3gqP5yT5vxy2+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nVQQvNlc4he/zSwFo7fP4gBX6BkFSUZTH3Xut0dotZqWfUjJ2tqy+FjaxxBt6s9mdqYrWKacGLNf7ME/aGchOS+2X0+LTU0CCPRxnbiK6cLLtquRYjZc/Qn8a2khtLl8X39BHnEgTK7h6Pc3mtggyu1C/c4HmLJGVAfFMw9xitQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jNPQI1LL; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jNPQI1LL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9n
	NlFIow0miyPGBGlXbBiq+8qkgIzBP5tjkVMbh8LqQ=; b=jNPQI1LLsB2cZpIje1
	skVpTmxF8pynlqbDTgYfeXd5UVJce5DfBH89TwpbRdS3qUpeDe87IsaQQz/4k/hm
	OS4rytro5Y1LSlWepJ1NEsfrp+U8qvja5FV5BKsSyF2GZi7dFlJfb/b2/qDG7rld
	1sATExy30Z4uFv/OWXF78Pwj0=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wC3NIn4ejNqQpKZEQ--.4567S2;
	Thu, 18 Jun 2026 12:58:33 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: viro@zeniv.linux.org.uk
Cc: alex.aring@gmail.com,
	allen.lkml@gmail.com,
	arnd@arndb.de,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	ebiederm@xmission.com,
	j.granados@samsung.com,
	jack@suse.cz,
	jackzxcui1989@163.com,
	jlayton@kernel.org,
	keescook@chromium.org,
	linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org
Subject: Re: [PATCH] coredump/fcntl: Add FD_CLOBCOR flag to close fd before dumping core
Date: Thu, 18 Jun 2026 12:58:32 +0800
Message-Id: <20260618045832.2575377-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618043054.GY2636677@ZenIV>
References: <20260618043054.GY2636677@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3NIn4ejNqQpKZEQ--.4567S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF18GF13uFWDJFWUXF1rtFb_yoW8Zr47pF
	WYgwnrKF4UtryxKr97Aw40yr1ayw1aqry5ur93X34rArn8Zr1fKr95Gw47uFn8urWfuFn0
	vFWjv3sruFZ8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRJKs8UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC5xpETmozevoNmQAA36

On Thu, 18 Jun 2026 05:30:54 +0100 Al Viro <viro@zeniv.linux.org.uk> wrote:

> No.  Leaving aside the unasked-for overhead for every process on every system,
> whether they are interested in this "feature" or not, this
> 
> > +static struct fdtable *close_files_before_core(struct files_struct *files)
> > +{
> > +	/*
> > +	 * It is safe to dereference the fd table without RCU or
> > +	 * ->file_lock because this is the last reference to the
> > +	 * files structure.
> > +	 */
> > +	struct fdtable *fdt = rcu_dereference_raw(files->fdt);
> > +	unsigned int i, j = 0;
> > +
> > +	for (;;) {
> > +		unsigned long set;
> > +
> > +		i = j * BITS_PER_LONG;
> > +		if (i >= fdt->max_fds)
> > +			break;
> > +		set = fdt->open_fds[j++];
> > +		while (set) {
> > +			if (set & 1 && close_before_core(i, files)) {
> > +				struct file *file = fdt->fd[i];
> > +
> > +				if (file) {
> > +					filp_close(file, files);
> > +					cond_resched();
> > +				}
> > +			}
> > +			i++;
> > +			set >>= 1;
> > +		}
> > +	}
> 
> is just plain wrong.  You are leaving references in that descriptor table,
> whether you've closed them or not.  It *can't* be right - no matter what
> you do after having called that, you will either leak file references
> for ones that were not closed or eat double-free for ones that were.
> 
> Have you actually tested that patch?

Thank you for your response. I developed and tested this feature in 6.1.158,
but I made this serious mistake when porting it to linux-next. I should have
retained the xchg operation that was still present in 6.1.158 to retrieve
fdt->fd[i].


> Note that above is _not_ "fix that thing and I'll have no objections";
> I think the benefits of that API are nowhere near worth inflicting the
> cost on everyone.

I see.
The overhead introduced by this patch comes from the additional memory
allocation for the bitmap during process initialization, as well as the
extra traversal time during coredump_wait(). I need to think of ways to
achieve this with minimal cost, and then you can take another look at it.

Thanks
Xin Zhao

