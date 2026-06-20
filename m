Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED42FCA5A;
	Sat, 20 Jun 2026 02:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781923386; cv=none; b=OMnkvjT2OWAUYvYpzMryt0lAOtEzjKYQqwUPGEfxwF+7e0szgWRHku68advB0tbdnpRz1ds2n1aWPIKoaom/yWvAhvhQT3ulv8KQakYZMBlDzmWTuB8viriHFh+fv+WEWLMldbZxAu6XmQsLyDp75tF472U/5cGxh70bHgXQn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781923386; c=relaxed/simple;
	bh=32+sjMX2GkYUexwm+xIw+X/kVrYqzdacPiUjupXT4XA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsMYWl+S9ox5x11r/RjL2d6kZRglFusKzr6UrFR3ZWPCXaKd8oYMRA2Yi5rhvPe7gzxtXOnpPruVG3/2xUz8sIokCd5M++ZUXYUuC5Fdv6yWEahx17bSllwpHoYIHkEUkq5iHqT0ayqSy8oyW/6bmoN8rR/g8edVnGll0ulZNNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EXz1/2QT; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EXz1/2QT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=AwVzzKOO1YYPeW0btzF292cttcXJMiHzF+v7tHfTQN8=;
	b=EXz1/2QTadaugPvJqVNL+DD8/i+PjZL1t2Pk2pz6JpZ70EIXc0uXNHJCcPzf9G
	MuXjs5ErvZbEO9EHnA29BRakXJa54lMQ2JinvAzexGmW+CdpoqCi6i/ybSIaxdtS
	kDGQrLSI/iH5DHkNfTTt3sqoXAdF1/NU9tInTicua655s=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3f3MA_jVq4w5_Eg--.24340S2;
	Sat, 20 Jun 2026 10:42:09 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: brauner@kernel.org
Cc: alex.aring@gmail.com,
	allen.lkml@gmail.com,
	arnd@arndb.de,
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
	mcgrof@kernel.org,
	pfalcato@suse.de,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3] coredump: exit_files() in coredump_wait() if MMF_DUMP_MAPPED_SHARED is not set
Date: Sat, 20 Jun 2026 10:42:07 +0800
Message-Id: <20260620024207.238713-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <178187726633.350634.1366346571707417413.b4-review@b4>
References: <178187726633.350634.1366346571707417413.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f3MA_jVq4w5_Eg--.24340S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4DKryfWF4DAr13trW5ZFb_yoW8Ar1kpF
	s0gayIk3WDGF1xur1Iyr4xJFWrJ345ursIgF1agr9akFnxuF1av3yfKayS9asrGFZakw4j
	vr42v34rCwn8JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRgyCQUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCvwGnsWo1-gEoGgAA36

On Fri, 19 Jun 2026 15:54:26 +0200 Christian Brauner <brauner@kernel.org> wrote:

> > +	/*
> > +	 * Early unlocking a flock on a file allows other processes
> > +	 * to lock and modify the mapped data protected by the flock.
> > +	 */
> > +	if (!mm_flags_test(MMF_DUMP_MAPPED_SHARED, tsk->mm))
> > +		exit_files(tsk);
> 
> This doesn't work - at least not unconditionally. Tools like
> systemd-coredump or apport go through the fds. Specifically
> systemd-coredump does:
> 
> 1) /proc/[pid]/fd/ — opendir() then, per entry, readlinkat() to get the symlink target.
> 2) /proc/[pid]/fdinfo/ — for each fd it reads the fdinfo text lines
> 
> The blob is attached to the journal record as the COREDUMP_OPEN_FDS=
> field. So the open-fd list is recorded as metadata, retrievable later
> (e.g. coredumpctl info shows it).
> 
> Also, irc some clever implementations use pidfd_getfd() to preserve the
> files from a coredumping process to preserve them.
> 
> So you break all that - and only in some of the cases which is really
> opaque to userspace. That's not acceptable. If you only care about the
> case where you dump to a file then either special-case it to the legacy
> file coredump format or if it's generally useful make it an optional
> argument that can be passed to the coredump pipe and a new flag
> extension to the coredump socket that makes the coredumping process shed
> it's file descriptors.

Thank you for providing such useful information. I’ve also learned about
the useful pidfd_getfd() interface. Returning to the issue, I really want
to find a suitable method to resolve it. Now I know how to proceed, and I
will modify a version; I would appreciate it if you could take a look at
it later.

Thanks
Xin Zhao

