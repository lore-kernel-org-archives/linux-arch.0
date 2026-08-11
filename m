Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325FD426405;
	Tue, 11 Aug 2026 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440298; cv=none; b=mvrbARM72TnWOm2K0HhkS0ftbvE/K/kg4wf/XRQQiJv8JvTLNTc1s+1lIxp8gW2Zt5SfGm7pnvfUKDsr+HxghmiCGksJCDPTl8ns7d1++eV3KDBv5skatEufY8VfJg9q5MQZOnxCQBcyGqNK16HZ5t48rs3V3gy0gtARyzx2mzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440298; c=relaxed/simple;
	bh=fo9j8kdnZ3d1Cb7R3JXH4+6v4YrCB+a7W8evI8c2Q1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c1WWg6U7GPqBFcBBI8jJ1uNoFba9Ug99aGuLP7osljML3LcUbQi4Jctixvn4YtpmsAZ1sq0hmi7p8a1Lg6NIsoYhBVV844YbwfBDdPLLYaJahNtknUqqYj0NQOXH6Nv++NJwAzSCFozDcRcAze8+GAMxWtzPIH7UucKFqQwL130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EbtKTIPx; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EbtKTIPx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fo
	9j8kdnZ3d1Cb7R3JXH4+6v4YrCB+a7W8evI8c2Q1U=; b=EbtKTIPxIWSGrnDo9o
	rLyi9otRSvWLd4uSSBTkMpjsQuXJq9/WSDYQRGxt9rcXTl6Oqz/f3TIH7ifqyeVF
	5bkyNRy3ToVrnoH5eOThDU4ykIlo1z7Tc9G+vK0hiudifoT1gwNpHTVuWiol5XkR
	EcziWewFP3XaFau8tqxifYL6M=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBnRqbR6Xpq5jVXPA--.54025S2;
	Tue, 11 Aug 2026 17:22:27 +0800 (CST)
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
	rdunlap@infradead.org,
	rppt@kernel.org,
	skhan@linuxfoundation.org,
	surenb@google.com,
	vbabka@kernel.org,
	vincent.guittot@linaro.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v8] coredump: Add bit 9 of coredump_filter for pre-exit files before dumping
Date: Tue, 11 Aug 2026 17:22:24 +0800
Message-Id: <20260811092224.2068821-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811-zerfallen-boiler-bissfest-cdb998278337@brauner>
References: <20260811-zerfallen-boiler-bissfest-cdb998278337@brauner>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnRqbR6Xpq5jVXPA--.54025S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRC_MVUUUUU
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC5xPn8Wp66dPLgwAA3A

On Tue, 11 Aug 2026 11:09:47 +0200 Christian Brauner <brauner@kernel.org> wrote:

> Fwiw, I still refuse this patch for the reasons I mentioned in the
> various other postings of this...

Yes, I know. I updated several versions because we found some obvious errors.
Perhaps there are others like me who have the same needs and can benefit from
this patch. If there are no new special circumstances, I will not update any
related content regarding this patch anymore. Sorry for that.

Thanks
Xin Zhao

