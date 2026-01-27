Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195741ACEDE
	for <linux-arch@vger.kernel.org>; Tue, 27 Jan 2026 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769493632; cv=none; b=BOhDR3UVIiut1uQkt1p6+wsX9L0cg9BRxaDJNO31eSd6ch63BoirZD5xnxTmMdY6ko1/OE6mZERWTajKbe9CI7b9POHx5e01DM1dEFvsUcNfupaSE3xqIyfPhXC65JSV1JmG7mOhjqyJEpngfwWwBkw67BwwgRKDXlQxA4ArWNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769493632; c=relaxed/simple;
	bh=v/u+rBX4luP4l2y0k4d4MJwxSQLjgxjIcVpFBIL6lHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7XsrpuoTDuiSHfZCjDQ3L+AWLvQlp+ZB/MR4fzRbPTss4IVd84+/ZfHqNqq4J3Z1A5/1EPk0sm5rx5XOovvfx12nXfk4lqLfPyHmtALIMVx8qq88/c+vgSZSFtADhvUgrFYxfe5Mw1R9z7V9XBs0cL5to+ej8PzHseFVJFXS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLDqdHPf; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLDqdHPf"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12336f33098so4544569c88.0
        for <linux-arch@vger.kernel.org>; Mon, 26 Jan 2026 22:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769493630; x=1770098430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a803xA0SW+lSUQWToabOiMzbo1P7cUc3kCdEW2eaQec=;
        b=DLDqdHPfWk0o+gSD5pgARfeKHy2TUdAaS8uw1NmauBipNaULr5DL+mLTBxcMKTkjxG
         +w5gjtRDs8DR1RtwVb9nwlv7k+E1OtsCPJHtHONYHtT4J+xnSMPhA3VCb4CJe8ycczuL
         ENFpSLbU5Adck6SIVvpmOJOok+lWIPro6yf7zoPVJONnljqQkIEdVR9sALcLQ+q7EKSc
         7STZ3CSGsWs21Swpq2QhkaTIzMZc1lpqNNyXJAlMWlTLoT8JYzcKcJnVJ3HzGRiSskV3
         K/vIJ1pcgleYZHjGwTu/c0OxE510Mvuzwk1kpR+elyWCeiOr5GzExE5p7ak0Kr4t6Yxq
         EzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769493630; x=1770098430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a803xA0SW+lSUQWToabOiMzbo1P7cUc3kCdEW2eaQec=;
        b=WkXWKn/TghbACv2TgpjqxHUzduFTanu04CyQR/2vUV84vJGKpAFfDp02RuaOT/E5VK
         OxWmP2aiLTPeejxzTOf/C/tAZsK5saiCAHddOJqW+0UZyJKsjb1u4Dv1g83g15CwTW/3
         A1Dl/upL6Q3Q/uTFHM39LQbMvxKj83JuUyZepFd8jil+CWXJfJlUIP+FmrmoLMhbn3YC
         FzWqgwlmm9FK1xS9Er1ryU3QWhR5/2DTUbqRKFf4srxMBN0b+Y6MhIQ42q+c31uTX448
         1AZSaXBGTFnvmJ3zyIjaSWq6DRdnF6gkLhH3LfTXJbSAxJIkQkdCLsYH0DPB8bV19yej
         a1VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOZ3tPsQCqfDehlhLlcnjcwFY2l3Rx0S8lgyX4d0itDLfWeGzMkKfOR0kujoIoY8YM1o7xLQPhyXPe@vger.kernel.org
X-Gm-Message-State: AOJu0YxR15+Mqp592wt/KtI7IPM80hGuLVh4wf3nlOx8lBrhmaeYuKH3
	RvSkpw7b74ZeZQfmIyIzZiYrhJII5ZrZl70onMTU+UhZqWmEIkUCKTM=
X-Gm-Gg: AZuq6aIGDEoxV2/QNYiIdbMarD015LH56SnnErg9OHf0cE6kN/OC/Q0lV9kvlfFv09j
	tv1sWOBNlsm9UNbK70OiFD7kAfNJRhsaC1fpkQr+1OpGBfYTTw+32/9AgHsNIMbFQ4K1GlKH8NX
	R8J3FyMzDPnhulSypfQUVxTNr3IjAnb6IdhxlChwD7nLvf1iDuGYbYE1zNyzBqrSe47Zt6QwmnA
	t1+fIOZQUTMN6WP1jetL0WKB8gwWxlXNwTJfWpwEa6ZRQ68KkcABfLLe4gjesmsBtQgjhVy4PnA
	dwCT9wq0HbCaCVimDNgu6Azm3UflYCo7WsMfJo/6yczAwuxHf0NNkA3BbqNrBX8hgOCnZsoS1vf
	sOdvKJtKYMKKtfyhDNVYAry24rW4Xs+IPa6Ctblv6yyCdTKolFnsHsMsYH5WaNR5HGxKoAyOy5N
	cjL+VqUJPrwAjKRwAPGZc/eg44EIR81wsrh64lfcW8a2DOuBzt9CT4m8u4EyTayWkI6z3usk/Hn
	CDTmTMQS3ZYusAk
X-Received: by 2002:a05:7022:20f:b0:123:2d00:1668 with SMTP id a92af1059eb24-124a00e861emr496547c88.49.1769493629755;
        Mon, 26 Jan 2026 22:00:29 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d90d13esm21240114c88.2.2026.01.26.22.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 22:00:29 -0800 (PST)
Date: Mon, 26 Jan 2026 22:00:28 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 0/5] net: devmem: improve cpu cost of RX
 token management
Message-ID: <aXhUfC7ZyYge1jti@mini-arch>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260120170749.101e8bcc@kernel.org>
 <CAHS8izMZxM6rcF+7Lfw=KFv4dmbHGSUrQBPmxO+sYj=V3TRuwQ@mail.gmail.com>
 <aXe2QhzL4DoVbesQ@devvm11784.nha0.facebook.com>
 <20260126173124.1f0bb98e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260126173124.1f0bb98e@kernel.org>

On 01/26, Jakub Kicinski wrote:
> On Mon, 26 Jan 2026 10:45:22 -0800 Bobby Eshleman wrote:
> > I'm onboard with improving what we have since it helps all of us
> > currently using this API, though I'm not opposed to discussing a
> > redesign in another thread/RFC. I do see the attraction to locating the
> > core logic in one place and possibly reducing some complexity around
> > socket/binding relationships.
> > 
> > FWIW regarding nl, I do see it supports rtnl lock-free operations via
> > '62256f98f244 rtnetlink: add RTNL_FLAG_DOIT_UNLOCKED' and routing was
> > recently made lockless with that. I don't see / know of any fast path
> > precedent. I'm aware there are some things I'm not sure about being
> > relevant performance-wise, like hitting skb alloc an additional time
> > every release batch. I'd want to do some minimal latency comparisons
> > between that path and sockopt before diving head-first.
> 
> FTR I'm not really pushing Netlink specifically, it may work it 
> may not. Perhaps some other ioctl-y thing exists. Just in general
> setsockopt() on a specific socket feels increasingly awkward for 
> buffer flow. Maybe y'all disagree.
> 
> I thought I'd clarify since I may be seen as "Mr Netlink Everywhere" :)

From my side, if we do a completely new uapi, my preference would be on
an af_xdp like mapped rings (presumably on a netlink socket?) to completely
avoid the user-kernel copies.
