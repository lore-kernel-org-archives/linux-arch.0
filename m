Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E4F3806CD;
	Fri,  7 Aug 2026 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083108; cv=none; b=uCCMfK4iLhXRG4Sck4P4TBxLxpPxla5PKYsKxkNy0uzGidh/J0OCTsLHH9qAc7/l1fiUe1LuQgqYeKWrY401GzbVslB+n3P2TkxWrg/jbRYGfxs/Bg3at6whvEfHrAg9bHN9Yp6zq1XJ+UfAUi/Uhp4JoNAUSxJHLnbV9uYP+kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083108; c=relaxed/simple;
	bh=C3ChUSnO6LkTcCWJcLX/bnHSSnlGzwMbnkOsxKb6GV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LBDSciRGEZ54LtWPSg53IVoWHJg72+48IhTu3bmI2yFeoUX1qmcX2Zg+sgd8Za0f40CYLgezEOs/BYAQbGwJ/VVTbCZ8BFIANf6DbRV7oGnFm2fvmqj8acjEhMrg4c238Q8FLSB8jn91x0Tn6g/0t9SOyjoRPcPQaS8EGEIggEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Px1dKUSg; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Px1dKUSg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=YG
	Rz6WB9lU3wlD2STC8uk6Jl3YtCrm4akVDEQj4iVJI=; b=Px1dKUSgN0ds0QRJxl
	zFG7j0Hbb06euelKNoN1Bds7SkB446HEeQAtU2xTWhOw/e7kWkFJKTnU/pGzDoLM
	YdrciyVOwJ0KVq8jdFO/i0HuQy+Y0CEC+giBSSKhyP5XhllL1NfyeR5QnKEW379t
	J9bss1T/sTJatoLqqa2hssNEE=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAX62t2dnVqBJMmJg--.29689S2;
	Fri, 07 Aug 2026 14:08:56 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: rdunlap@infradead.org
Cc: akpm@linux-foundation.org,
	alex.aring@gmail.com,
	allen.lkml@gmail.com,
	arnd@arndb.de,
	brauner@kernel.org,
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
	rppt@kernel.org,
	skhan@linuxfoundation.org,
	surenb@google.com,
	vbabka@kernel.org,
	vincent.guittot@linaro.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v7] coredump: Add bit 9 of coredump_filter for pre-exit files before dumping
Date: Fri,  7 Aug 2026 14:08:54 +0800
Message-Id: <20260807060854.1785634-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a2293778-bce7-4f88-a049-6370707694ef@infradead.org>
References: <a2293778-bce7-4f88-a049-6370707694ef@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAX62t2dnVqBJMmJg--.29689S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1fWryrZr4fZF1kCw1kuFg_yoWxKFb_Xa
	yvqr9rJr1ru3W2vF43GF1FyaykK390yF1fJ3y7Zw1jqayktF1agFWDKFWSv3WxKFWDKrZ7
	CF1UXw4Sy3yavjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUU7DJtUUUUU==
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbC5xizvWp1dniqEAAA3a

On Thu, 6 Aug 2026 21:08:46 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> > +The default value of coredump_filter is 0x233; this means all anonymous memory
> > +segments, ELF header pages, hugetlb private memory and fd list are dumped.
> > +
> >  The default value of coredump_filter is 0x33; this means all anonymous memory
> >  segments, ELF header pages and hugetlb private memory are dumped.
> 
> I could easily be missing something here, but to me it appears that the
> paragraph immediately above here should have been deleted (i.e., replaced
> by the one above it).
> Can you explain, please?

Thank you. This is another silly mistake. I'll fix it.
I think I should see a doctor to check my eyes. :(

Thanks
Xin Zhao

