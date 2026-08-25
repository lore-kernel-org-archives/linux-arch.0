Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6E438494;
	Tue, 25 Aug 2026 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661081; cv=none; b=SDTtvVfxtHaMmpLlWAzKcIIpp6/z8qQBvpjXVGS5zF8sNYnxQYocG+mRudCqraaHODGWIlNyAFQFa4rIMb0++NVtxmpuJq01W/XoJRG2dxK47JS+NamjT86z0fGFUI3pcp5xhJhqAtW2Kp7nhvWovPTkMACOvPXh+b+ErqHHfmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661081; c=relaxed/simple;
	bh=1RtHQ9s8RqkuHtoFjtZPmWprAW1PEABch3MnrGs5VyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQF5MyyWjIc+30gjvovFplbzlmkwtUxeP+O0jkLQ7NPfx4gX5Y8LRe0pMsYLGYNXjApPYzH4R/qEVDo4rHYKlCODcpJfIZwMoa4xNnjuDZPRpi4KeulElT4Rb5y31gq1TxaN1z91be3JYL2N7Oc/+PDIkYtwJfikE/bePiDHLLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofT11nQA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofT11nQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3BB1F00A3F;
	Tue, 25 Aug 2026 12:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787661073;
	bh=xsNEWNi39UPPJLm1+sc4ZRXUG0ihBnLDmHXk5dXeQgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ofT11nQAHKRBlGPgKi3v4szvihkQNzTb1w8uYeVH8n7nu6YU9r+smfAe5YEONEysS
	 ZiSV5ecEsptyKeUZveViAqUPRtqVual9dbogk50MEhTf/eMYkIylU4WxuiJ15mvMdd
	 TSJrJzOOYGwLFj9ciXOwPxNYZn2NnzhJZzLA/bMe4lnr4drVZHCG5b8DsCyFqCBiNI
	 3/Gg25a3bjkMb67W77yD0yY46uVPmJF6m+FTHyzd2njJm0BzSMS7SRETbQqLf/0a5I
	 w1ls5vSOCoUi2f70nqILQokejRuc//N9ao8Z+x4gLU6B9kFh/guBDXAzkn7FHDzd+G
	 /o82JOJxr51+Q==
Date: Tue, 25 Aug 2026 14:31:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Xin Zhao <jackzxcui1989@163.com>, david@kernel.org, ljs@kernel.org, 
	rppt@kernel.org, pfalcato@suse.de, viro@zeniv.linux.org.uk, corbet@lwn.net, 
	skhan@linuxfoundation.org, akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	surenb@google.com, mhocko@suse.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, ebiederm@xmission.com, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	keescook@chromium.org, mcgrof@kernel.org, j.granados@samsung.com, allen.lkml@gmail.com, 
	rdunlap@infradead.org, kuba@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v8] coredump: Add bit 9 of coredump_filter for pre-exit
 files before dumping
Message-ID: <20260825-singt-panne-gelage-fc5d58f101c5@brauner>
References: <20260808052732.2589657-1-jackzxcui1989@163.com>
 <20260811-zerfallen-boiler-bissfest-cdb998278337@brauner>
 <CAGudoHG8ff=8RA+8e6JUtESDxBHFjZ65UiCaM4X_6qSU6-Q9Nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHG8ff=8RA+8e6JUtESDxBHFjZ65UiCaM4X_6qSU6-Q9Nw@mail.gmail.com>

> > Still NAK to this whole appraoch.
> 
> Would you be ok with a variant which merely unlocks prior to dumping?
> File descriptors remain in place like they always did, but that bit
> about them is changed.

Fyi, I've sent an alternative proposal (you're on Cc).
