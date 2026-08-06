Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF58943847A;
	Thu,  6 Aug 2026 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029351; cv=none; b=fYony5ld4Nmcpl4kDuvXdLDzP8SzpFF4dYKWfl7zgqvOWUvBG/cS89Ifvb8mhSntsqVh1xucSGWN/QV84vXVQGwIPoZVFfcQFvxxb+MUgT+uYY/DMvATLMa7MIwHeIVmX6JdkSUeFCpnhMSql55qkWcjPj4D+qAq4DzzE3MoF+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029351; c=relaxed/simple;
	bh=6dcFxI60i+WGfAZGFh5LYNehhr8fvnFlJNLAcFs1C6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rwac4YxxSV8secvLgEnZlKL0VCCxBIsbkCxHWQ++/25Yu0GPGdpVFRhtHPTNz1saLyZhi0cLncDwwUVgJTQmsghXh6fA8q72kJ6BHu5FZG4WZc7BOmoopqFopT7H+ZYvF5cDfUGKtBaAcCu39qj0Q3CKEJuEgm7MbImpIKZUdWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DPFGxbZk; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DPFGxbZk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dw
	i9iYgVIz2PjYVlalCQyEOyqE7a1Bmy1TlzV0GkyVE=; b=DPFGxbZkl3Pr+zJTS0
	tqDPVIL4GvDE9/8si5GMcnmTSMHUW+8O1T0e0xRgkOX516yvKZxOYqvbOk+oMLq8
	hbv5PjfZa+xvjicZ3zyZJnDv0pD3j05TgInzzmtpC5SF+YACo9XahdUGDgMHUPS9
	eI8Djsk6XbbO2XrEgkuSxOD3I=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCXn69gpHRqAwzILg--.36236S2;
	Thu, 06 Aug 2026 23:12:34 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	alex.aring@gmail.com,
	allen.lkml@gmail.com,
	arnd@arndb.de,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	corbet@lwn.net,
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
Subject: Re: [PATCH v6] coredump: Add bit 9 of coredump_filter for pre-exit files before dumping
Date: Thu,  6 Aug 2026 23:12:32 +0800
Message-Id: <20260806151232.1263773-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8c763f1b-85ad-44b9-b36c-becd7598fe77@kernel.org>
References: <8c763f1b-85ad-44b9-b36c-becd7598fe77@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCXn69gpHRqAwzILg--.36236S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrGr4UZFykKw4DXryDur45KFg_yoWxXwcE9r
	Z7AFn5XFZ2yFW8CF4xtFs5WwnIvFsakr1kZr1fZayqyw17JFZ7AFyDJry0yrWUJrWI9r4r
	CFs8XrsIyFnIyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUj3l13UUUUU==
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC5wL4A2p0pGKOXQAA3V

On Thu, 6 Aug 2026 16:01:55 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index db6167bef..d590a1dda 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -1939,6 +1939,7 @@ The following 9 memory types are supported:
> >    - (bit 6) hugetlb shared memory
> >    - (bit 7) DAX private memory
> >    - (bit 8) DAX shared memory
> > +  - (bit 9) fd list
> 
> "The following 9 memory types are supported: ... fd list"
> 
> What?

Thank you. It is a silly mistake. I'll fix it.

Thanks
Xin Zhao

