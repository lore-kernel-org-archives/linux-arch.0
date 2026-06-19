Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118602F8EA5;
	Fri, 19 Jun 2026 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781877281; cv=none; b=jW4ibAKET5vGToO2q++EIaCw5s5452Yq/cI07+c1Qw63DoQLS1+X3AAkE4Oa7DZC6znF5G46OgLQM/zfPcNgT3gkR+Ox9RDKMMmRlH29Fu5up0j7oPkbd1G+L+6lcY3fc5Ofdc0o99lpK/ikUFBr1fKyjNiwWBFofy8Dn6kwItc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781877281; c=relaxed/simple;
	bh=Se2YS+MysaHYdTAXA918wZ9iDPhbkTOeVjJdMoD/QNs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=AP71o53OmA5c6sEleMQul7GhFl05lOw/gVvHyOPZFVtickSUtP05HQ381r7aAZceRJ0w7vzcm/ThT9PekMakGXGPOuqvGA013oA+7To56erLYidykBNljWCNHi9W3UIKGn0mD4pWS5ROHEx8nOtSgEd+KWaleJ6f5cib4p4AeHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqoGyad3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqoGyad3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F3A1F000E9;
	Fri, 19 Jun 2026 13:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781877276;
	bh=hPmW2sA0yrda5AdXRNfJKhNs4MlR4+tuoG6ayHqZROQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=FqoGyad3OYkhL+VDjB28X7/5ekIRit1Sh6whdYj8D2/QjksCtlsZZldUxuDFRXNJT
	 8nFOdqVguMNvGQBPZj2ngTi/VWQMM0Vcvs+ViPKijYBjZ8Jj4bGXst+EW1/cVH6XY9
	 42sSBw3SuJ0yz4jgGWQIP+PeLGMCDyQR+0h+qsfUbzfk9Rna10KteX7OlAxH3i8Lky
	 X0oa8DR3sos2aKqnP4mgCsVKBF7wlTmVqlGG7dqIYy5PafB8onZDaKFLXnOH+GnrS9
	 UmrWz2g/AiqZYslqKqbLcByOMMUo786KS58S4+fyEF29WsYiksLrxDklFkEFXMJh7T
	 6aw5DPpW8C80A==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] coredump: exit_files() in coredump_wait() if
 MMF_DUMP_MAPPED_SHARED is not set
From: Christian Brauner <brauner@kernel.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: pfalcato@suse.de, brauner@kernel.org, ebiederm@xmission.com, 
 viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org, 
 chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
 keescook@chromium.org, mcgrof@kernel.org, j.granados@samsung.com, 
 allen.lkml@gmail.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <20260619122419.3954581-1-jackzxcui1989@163.com>
References: <20260619122419.3954581-1-jackzxcui1989@163.com>
Date: Fri, 19 Jun 2026 15:54:26 +0200
Message-Id: <178187726633.350634.1366346571707417413.b4-review@b4>
X-Mailer: b4 0.16-dev-aeb64
X-Developer-Signature: v=1; a=openpgp-sha256; l=2226; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Se2YS+MysaHYdTAXA918wZ9iDPhbkTOeVjJdMoD/QNs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSZeklcP1KssX6fmdTH2S+2/ju+NdvM0Svz/9/Xsm5Gf
 Gwv/0826ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIaTjD/5wpflNUFuptvH3P
 ZwFjvpNy10G+26URe+6eLv57Py/w0QqG/yl9OUwu79fwHLwmsavr+uWXL23kc+sS0/7nPn635iq
 rACMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> A coredump typically takes some time to complete. If we happen to hold a
> write lock with flock just before triggering the coredump, that write lock
> will not be released during the entire coredump process. As a result,
> other processes attempting to acquire the same write lock may experience
> significant delays.
> 
> To address this, call exit_files() in the end of coredump_wait(), if
> MMF_DUMP_MAPPED_SHARED is not set. Note that early unlocking a flock on a
> file allows other processes to lock and modify the mapped data protected
> by the flock.
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index bb6fdb1f458e..70698d06ec9d 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -548,6 +548,13 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
>  		}
>  	}
>  
> +	/*
> +	 * Early unlocking a flock on a file allows other processes
> +	 * to lock and modify the mapped data protected by the flock.
> +	 */
> +	if (!mm_flags_test(MMF_DUMP_MAPPED_SHARED, tsk->mm))
> +		exit_files(tsk);

This doesn't work - at least not unconditionally. Tools like
systemd-coredump or apport go through the fds. Specifically
systemd-coredump does:

1) /proc/[pid]/fd/ — opendir() then, per entry, readlinkat() to get the symlink target.
2) /proc/[pid]/fdinfo/ — for each fd it reads the fdinfo text lines

The blob is attached to the journal record as the COREDUMP_OPEN_FDS=
field. So the open-fd list is recorded as metadata, retrievable later
(e.g. coredumpctl info shows it).

Also, irc some clever implementations use pidfd_getfd() to preserve the
files from a coredumping process to preserve them.

So you break all that - and only in some of the cases which is really
opaque to userspace. That's not acceptable. If you only care about the
case where you dump to a file then either special-case it to the legacy
file coredump format or if it's generally useful make it an optional
argument that can be passed to the coredump pipe and a new flag
extension to the coredump socket that makes the coredumping process shed
it's file descriptors.

-- 
Christian Brauner <brauner@kernel.org>
