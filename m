Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795815676;
	b=lOARltAX+pdGaUxKSiY0Knz23l87x0cBoiq9KMJG1vItYm/B8/30CCly5KJS9HIck4te
	 +dwcJb1Iig7QRrPWR5xm4m7kBGO3KzxrpLYMITzOwjyCVoKUtLDis0lsl0XN2ksa41bUR
	 6649RDrVxvIciqmv9onXy1s/NoIF0cWmtbMilXY+OcM8n+win1MPgFs18mB3ukAbZdvUm
	 1O48dQ4qf8OA9Ga06oIwADpBBpKh8ELTSV0J3kQYzgnBg4ekPH5PGtlHz819ZXGJ7IjLL
	 TplsfpJO0P4Kx49zke5+rt1ai6m3PRjq6UA6WyHzLxzawPAbN5me3K2zsvgapcnTHiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795815676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GNjJtSmgBzeJqa75AyMuB1FfpMIGeExfgQrDDeRI15s=;
	b=a9yMI1hrvsdbn1DHQvqy5YUvbcs0RJ1W519zoooda1cC3SYPF+OjY9YVsiIZPedHPTZL
	 QrhZL4nu982KclV1r+pFJHrMwG596gspiesE5+Z4mWKzETXdp4/ZYfX3NA2ZWwod7xjJ9
	 sNonSyg1sIi1lXFK4nnDIlx8ncaUoroV89Laf/w2S6g9m5TbLE5gBjw8NQj1J/ibbsS8V
	 ZH2OmUXR5x7g/iC3hhFb3UAhYoalpx94iVnyf8xMMbWrCoja9x7irr68uthZgqLUoCyvJ
	 GBCUU8ddCzquc1OiEWltOsjqj3BNKKRBcNxGtbykZ3T4RjQsGJrk9gYlbE6E8nP/Pkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rlJzjc+L;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20161606A31C
	for <linux-arch@vger.kernel.org>; Fri, 27 Nov 2026 21:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20161606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rlJzjc+L
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so109121085e9.1
        for <linux-arch@vger.kernel.org>; Fri, 27 Nov 2026 13:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795815674; x=1796420474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNjJtSmgBzeJqa75AyMuB1FfpMIGeExfgQrDDeRI15s=;
        b=rlJzjc+LyIk9Bk0QS6P/I8TDEexyuBC3YqrMNuS8l9ecZxXqzecIXHrsa2+jjLCIkd
         AvdgA+lDcovhfWDGGXxDDTraLo/z7WixYN6CS0WFtDPjvWLKrdb2LmuL8SVsyVcmcUAE
         w7uKvqNGQ6fgCtW1/YqXftDsvKWqzLc/etNTUBIImSolgJ458EFpxfvonhxlMSH2he0w
         gpZYXR2cdjzW3qoLBTUFALao2MhHDceARIdwR8T5fNHKRhO5CZKehhou/RRtD33QzCTW
         J9VxQgQTSkBjmppRZyAfVgxgVnOD9jDbF3HW5K6gfIlLPnr/76nWxRQFxdk3GCbefAfK
         3+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795815674; x=1796420474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GNjJtSmgBzeJqa75AyMuB1FfpMIGeExfgQrDDeRI15s=;
        b=q/SpX4c9J+LKKCG7P8yxiyjEBaUSytzMbNTsvP7vIQ6gZaYxNYE2Wr9w0piui0Hvt4
         usxmK4fXdwbI5BWyS0tJkncZHXktGNAhTXXvWsKrGbEdU5RW973YOjlcaqWHOHUQ4axu
         SFPV8le1HqS36hyGZyBTRMQU4he1YfNPZ22G50y/0v+iAIHGevQNlyidFRi+NEPZInP6
         d8pdfQTbTpFIGzZG1VCuPU/AaTcRt9/6z733quYxKD/ZoBYOhaikBQBED9VVbhY/ElwV
         lTHC9nwQt9Br9UxxEIked0oFAwxcM+fspvqtADcgPKuUTZ80gJRs0oZ2QYcQ3OF7eZxO
         n1LQ==
X-Forwarded-Encrypted: i=1; AL+hErF3ImEScxS6lSbc2pdmD91uL/uCsej6kKoqjTsFyoCKcqYpC6TemjjENKCA2Af+XizGNFMnYCnYKlIG@vger.kernel.org
X-Gm-Message-State: APuU4Z+qJHs7nRYOmXoQPLaPbI4z/HZ01KMzcnhe6fjA5Nz7UVwc2cF/
	h+RlOueLMGZUzOpwIMPmHSyS5MnBfKS+Qs4wEizx2G2ZqYkI7lQlh0ZZ
X-Gm-Gg: AZFdTZcU2UfYzyZRjmoS8N1D1GCx3xGHY6+/ICU6XLi6Ijd6cEk+7lodg3qcVvMM/mB
	D7KIA4QJT/GLa6PJLOy3BZ1MuEHTEr6CB9ugxVUtWeSXEdR0uygS5E45vas8Q6IGZA/A0uc7VEs
	4ye8ho76eEZe7UUTPgrkRO4HpvKNFyxgrKxDklYcPRKFjPF4tiTYMPhPI4vlldvtgFPkyade34e
	Lq2q7DibDw+9gGt+XJi4/QDDvSeVFbLq5b5pswWffrDcJ52dGJ6/zq9vdI5FaUTkFTGu6gnwnTu
	6pUCnIbOJIEtp1MXBFR3z1kUbnO5c34A94YDQx0tsS8FjCopXDcztdUxH7ucy+rEX8NRgSZWhZw
	I6zX8hmW1DeF8DHNR+1pQun6km7CQhWdiEvrQhG/54tgwqReSZAOC2iumSyEYEwYdYRL7hY3CId
	zHlpZ1aovfvvnvktwo1eX6lE3ozATtWKTGIxIm+OxpIxfUaauQd0umi4hwrHUUmKbLfZDhKc6Jr
	7KkeNs5oOqxTA3MPmO/t9uo1jF2H/Of2ZBT19HNY7bHvrFsieTn0rspD97C5m7blrEOlFnYfvKF
	iyAO4XZZDKJAx/suVVRC2rOkiQ==
X-Received: by 2002:a05:600c:a085:b0:4bb:85d9:156e with SMTP id 5b1f17b1804b1-4bb8880fe46mr518939935e9.11.1795815674386;
        Fri, 27 Nov 2026 13:41:14 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bbb97e5356sm37714445e9.4.2026.11.27.13.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 13:41:13 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: jarkko@kernel.org
Cc: aleksa@amutable.com,
	alex@amutable.com,
	alexei.starovoitov@gmail.com,
	arnd@arndb.de,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	containers@lists.linux.dev,
	corbet@lwn.net,
	dhowells@redhat.com,
	ebiggers@kernel.org,
	giuseppe@scrivano.org,
	hughd@google.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kees@kernel.org,
	kpsingh@kernel.org,
	lennart@poettering.net,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	luto@amacapital.net,
	neal@gompa.dev,
	oleg@redhat.com,
	paul@paul-moore.com,
	ptikhomirov@virtuozzo.com,
	sergeh@kernel.org,
	skhan@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	zygmunt.krynicki@canonical.com
Subject: Re: [RFC PATCH v7 00/26] userland: Userland containers
Date: Sat, 28 Nov 2026 00:41:03 +0300
Message-ID: <20261127214103.542291-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <awOQDOel_72Xwjm7@kernel.org>
References: <awOQDOel_72Xwjm7@kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jarkko Sakkinen <jarkko@kernel.org>:
> I personally think that "getting in" should not be a goal in the first
> place. I care more about that whaever gets in has a high bar of
> quality enough. It can be something different than this but
> when I read the LWN article about Cells I was alarmed enough
> so that I had to do this and prove my point.

I think that Bacik's patchset has better chances than yours.
I think so, because (as Bacik said) it was tested in Anthropic, and also
because Brauner reacted positively:
https://lore.kernel.org/all/20261021-zeitig-niemals-clubmitglieder-b3973fcebd38@brauner/ .

So I suggest reading Bacik's patchset and say what you don't like about it.
You will have chance to influence Bacik's proposal before it will be merged.

(Note: I am not kernel developer.)

-- 
Askar Safin
