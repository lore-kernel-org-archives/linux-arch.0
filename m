Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ECC33A9D6;
	Fri, 19 Jun 2026 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829602; cv=none; b=CTM1k59ZNuhvWTQZA54/CgoVk8ENeTqZ5/X+gF4q83kFiAdxu6+LG10mVE85uvSEPjU+65hERr2pNrNZhcLOqPN9YjsVFy91vmW7k779efAmp0v147qoMpg2sxhgAYm7YNuGYPJ33S6TnNCUbgI3ZOYxsO0b6vOFZPChWmXQKsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829602; c=relaxed/simple;
	bh=TSyHsKp8MWY4GZFrYjBoTpWtkFWhqpdhoGfHUL9PYZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g7n/RN5Ql/6DPTKyBQQU6xosgsKpRaeqO45ZJ1RJsEaxjHBxhwLtKOYlt4m9HsrKlIDa/O/RbyINw5jiiVz3l+o6/+MVRXjJJf71BPHF+Zzyyxtln9SKz3RT0Km+7lCsg6FG/zbyvgdjZXkFJv/Pds9li/49Ks8kxrgduZ5kNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DoNv1B4U; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DoNv1B4U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xs
	M+T7jwnvEavB8dE5tjK8QL9ECktCoIX9VX/xAC6iE=; b=DoNv1B4Uw8K9qvdJ7f
	tAIyldCMLzJidNNXHZJ2nd4crtu5cvf76mX3EhLpN+lU/Fn4NQnWS9G9tUmyvX/s
	sXersmT6/Ptx+stss1ALEvz8W0AR3b5mDVYneKmd0LT4Ev+zJE1bPirE9CdMv2ZS
	u4GahWzTy+7q7hcN9GP9zMKFQ=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD31qakjzRqBTQuEg--.1443S2;
	Fri, 19 Jun 2026 08:39:01 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: pfalcato@suse.de
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
	mcgrof@kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] coredump: exit_files() in coredump_wait() if MMF_DUMP_MAPPED_SHARED is not set
Date: Fri, 19 Jun 2026 08:39:00 +0800
Message-Id: <20260619003900.3546571-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ajQoFeTyIqh6tMVv@pedro-suse>
References: <ajQoFeTyIqh6tMVv@pedro-suse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD31qakjzRqBTQuEg--.1443S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF47Xr4xtw4fur15CryUWrg_yoWDCwbE9a
	yFvw4vv348ZFs5Wr13GrsrWrZxtayDWFyDtan8ZFW7Jry8XayIkryvvrZ5Aa4FqFWF9w1D
	Grn5ua4jqry2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREhF4PUUUUU==
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC5wW0vmo0j6UJHAAA3J

On Thu, 18 Jun 2026 18:19:16 +0100 Pedro Falcato <pfalcato@suse.de> wrote:

> > > +	if (!mm_flags_test(MMF_DUMP_MAPPED_SHARED, tsk->mm))
> > > +		exit_files(tsk);
> > 
> > Memory mapped files keep their own separate references to the files
> > (in struct vm_area_struct::vm_file), so there is no need to attempt to
> > work around this. Unless I'm misunderstanding what you're attempting
> > to work around.
> 
> Waiit, I think I get it - you have a flock on a file, and you're scared
> that if you unlock early, some other process can lock it and modify some other
> file we have mapped? If so, that does make some sense. Please add that as
> a comment and/or into the git log, because it feels very much non-obvious
> to me.

I did forget that mmap also increases the reference count, but the case
you mentioned is one we also want to work around. I will add this
information to both the commit log and the comments as below:

Early unlocking a flock on a file allows other processes to lock and
modify the mapped data protected by the flock.

Thanks
Xin Zhao

