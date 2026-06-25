Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7655514F70;
	Thu, 25 Jun 2026 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355938; cv=none; b=ZGcjriQSqrgMzcVedY8CBpQyfvGe5+dmXbFb9PpgjXJy+vRV5bhHww2z2mLUBnBUHY83T51IBVPpsGUKoAj3nhal2Wbego43j+z5LcD6kYoWiPk8S9lftUUVg6VE7VgyauJo3fzHwdraiHy9/s6nvWyjTzDkKsLmtQbB27EaFJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355938; c=relaxed/simple;
	bh=y6dIq1/fbViPyKvG3/D66N0tBt67VKNGdMsMunx9jWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OsnjamIqVQKX8+JcmYZzlZTqRaPIim8McIZpnpVYhs4ZJyDUc1VUPLyh02RlTVO9EJ9yvnnjdqXvGD0l8DUZpw0zk0/5ymn4kTCNbCUkFwFvpg5XmE8yRqGSFpXjL9GVoLCFKPdumTy+pHpYSeRbEZIMC+Q1W9t462vfmzEQPS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=naeU9af+; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="naeU9af+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=X0
	91vhqSRGmu5hgUk9ZcgAG7mu4WX2XXyRIobACtVuE=; b=naeU9af+rcPm0evwQB
	OjrWHKBwBshUp5xJmM+AcjAf9VCye4A/cplP/r4KqdcmhiGa0I2T1TbcVOzXYZbp
	5LzFx0/hqCHymXPobQHAaSF8dL2I21tZ2MhPWJXdM1//RbK8TeXT7+D4NRHIhLOK
	hOy14mK4YgiGxpF3pvQMAmZgM=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3NwiwlzxqpCW7FA--.55660S2;
	Thu, 25 Jun 2026 10:51:29 +0800 (CST)
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
	mcgrof@kernel.org,
	mjguzik@gmail.com,
	pfalcato@suse.de
Subject: Re: [PATCH v4] coredump: Add /proc/<pid>/coredump_pre_exit for pre-exit before dumping
Date: Thu, 25 Jun 2026 10:51:28 +0800
Message-Id: <20260625025128.483736-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260624162844.GK2636677@ZenIV>
References: <20260624162844.GK2636677@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3NwiwlzxqpCW7FA--.55660S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtF43WF18Zw4furW5XF4ktFb_yoW8Jr4DpF
	WFva1jy3ZxJryrtFs7Zw4xGF1YgrWfC3y5AryYgr17XwsIqFySqF4SgF45Was8CrsYvw4q
	v3yUKrykArWDu37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRgyCQUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC6BK7xWo8l7InYQAA3x

On Wed, 24 Jun 2026 17:28:44 +0100 Al Viro <viro@zeniv.linux.org.uk> wrote:

> > +			if (file->f_flags & O_TMPCLOS) {
> > +				file->f_flags &= ~O_TMPCLOS;
> > +				goto close_fd;
> > +			}
> 
> *blink*
> 
> 	How could that possibly make sense?  Many descriptors
> may refer to the same file; what's more, many descriptor tables
> may contain such descriptors, so... just what is that code
> trying to do?

This is yet another serious mistake. Perhaps my test scenarios were not
complex enough, or I was overly confident in removing the logic that
cleared the O_TMPCLOS flag and performed debug printing only when the
reference count dropped to zero during that single close operation,
without conducting further tests.

In v5, I plan to avoid clearing the O_TMPCLOS flag to handle the situation
where multiple file descriptors map to a single file. Of course, there are
some cases where the lifecycle of this file may extend beyond the process
exit, but AFICT such situations either cannot last long or do not involve
memory in the case where i_nlink != 0. Therefore, keeping this flag seems
unlikely to cause any issues.

Since this flag is no longer used temporarily (it will never be cleared),
I would like to rename it to O_PRECLOS.

Thanks
Xin Zhao

