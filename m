Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8E1C84A6;
	Wed, 24 Jun 2026 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318539; cv=none; b=jsP743WBPq+B1j9Rl1i3ub3CByVLyc6AochQgvJ7V7ehtCp0Eqt048bFErxy7p/uI0VtTRlEU49F6D/VWIAEGCuto7LANQnvZ0BqXtBq8sGo8mNWUZ7qkL31l9OQqWUCaXhk64MNv5PW+j1g7+6uJLoJGCXGInICKgUgkC05i24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318539; c=relaxed/simple;
	bh=wYsgL36Qll98+9/c4qcp31pYfZKwamekdGbYViKqFvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIjhZt3DZYSosD8GzPD3+YDbb7o91fItxAQumljatUXXc0QzTLqP2vKpSpS/GrARXVDSoKv0xpi6LTbO1bMhamcNlHmYu7ciLTpcPIwcxhCZiz2CB/7Fe+TzUG4vyi8Gf+vVkaVJdIFk0CPJXeagkoDMlBJBdUKtgYn9Xij7Lo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UyfNI67W; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UyfNI67W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VV1MhbpKXO0Il490a4DZ7QmRI0jphWeYBd/5dU5DKNo=; b=UyfNI67W/iJlio+sS7KxJcp0qE
	z/2pEUQ9ZxPEICsoEtAXdOMDHu0giARm5FxnQD0ubkkmWRJDIF8CN+rTAyxRUTbBdw6TKQr6yFxCk
	FA0K8smRdyRNV/Lf0UMh4PbxuJCQae0Awu5jWw79IY8FRzMlCi6Ul4ugdlu00c2KD/dWzq07Rv3rA
	Le984xSaSIkwQMIxJ2Ib7/yRBaQqHSXSIbH9Q97pKtSzzp1N46W5Cw9RkwdG49KVaS057bgBu0RJl
	xoT/Pcr9ifJdt3xD53kuZiVQJU8CmN00/6iJWblfo4R6nYn9b3czF1ZxHYQF66IflWxs4LEZ/ZKns
	TJjjGGbA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wcQSy-00000009MLW-0bbX;
	Wed, 24 Jun 2026 16:28:45 +0000
Date: Wed, 24 Jun 2026 17:28:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: brauner@kernel.org, mjguzik@gmail.com, pfalcato@suse.de,
	ebiederm@xmission.com, jack@suse.cz, jlayton@kernel.org,
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de,
	keescook@chromium.org, mcgrof@kernel.org, j.granados@samsung.com,
	allen.lkml@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4] coredump: Add /proc/<pid>/coredump_pre_exit for
 pre-exit before dumping
Message-ID: <20260624162844.GK2636677@ZenIV>
References: <20260624145552.70143-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624145552.70143-1-jackzxcui1989@163.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 24, 2026 at 10:55:52PM +0800, Xin Zhao wrote:
> +void exit_files_pre_exit(struct task_struct *tsk, bool checkflock)
> +{
> +	struct files_struct *files = tsk->files;
> +	struct fdtable *fdt;
> +	struct file *file;
> +	unsigned int i, j = 0;
> +
> +	if (!files)
> +		return;
> +
> +	fdt = rcu_dereference_raw(files->fdt);
> +	for (;;) {
> +		unsigned long set;
> +
> +		i = j * BITS_PER_LONG;
> +		if (i >= fdt->max_fds)
> +			break;
> +		set = fdt->open_fds[j++];
> +		while (set) {
> +			if (!(set & 1))
> +				goto next_fd;
> +			file = fdt->fd[i];
> +			if (!file)
> +				goto next_fd;
> +			if (file->f_flags & O_TMPCLOS) {
> +				file->f_flags &= ~O_TMPCLOS;
> +				goto close_fd;
> +			}

*blink*

	How could that possibly make sense?  Many descriptors
may refer to the same file; what's more, many descriptor tables
may contain such descriptors, so... just what is that code
trying to do?
