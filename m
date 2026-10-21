Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792592814;
	b=Lb/HeyvmrDnHrcFe+V9PxJxPSRFWkFsbEWEjsRlmugOl5BcLZHp0zoXpUKI5TDSScdtQ
	 WkYn9Jdce5lNC039SOrdGkDHs4UQkfMF7PymTzyXUuorKsUKHhbYLKMYyOHRdn/9J8vBW
	 vmn8F2ovNhBDzB9CgWoGZaw+qKbNFH7QqjxueeBP1AHjptzAowmk3cAeBJ4BnctNceijB
	 842OFm9cLeL4PSByXrQ7Bx437t8OFhbRIP008juvLcN6VZGYDXXi0wccx0hQO0zCtc1VX
	 WPLrid/ZfbUx7AE4y6Kpx4a71ZO1TGLkaDJPbvr2rmrnnAq3zQMx/NJsSVI8kdBv/Tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
	b=dHnby1KxEy/JAVcycTjHuP364DMs9vslszUmhNSDqOo1HfbsjhJWO5fxSk6hrdEt0wmM
	 7I/OQIViU+CWpr6yuaJ1R+WpRfvvWNKMzfpE7S5N1Mw2OAAZctYVHZzb4cvOPfTiBrrwA
	 dcnQRAzd7pCrLPA4aA7uGReNIlWSC13135ee7C2eSN0ot0ALOMrSB3ejRu2up9m4/LIVs
	 8gcBQJ97phURKw3nUw4qy/KOGgWQqBy7aCcLK7AsGQecF/wg2Ac8xYSKWQFUO3K1IMNCh
	 gwCUQedSRZTtqwuoMxywUqeqso1MecuMfAbJl9T8rGLCvHs+zoWVTRlRVc18vNJkjYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BRqHAhOJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C42C606A322
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 14:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C42C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BRqHAhOJ
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b3f7763d88so1014407a12.2
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 07:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792592812; cv=none;
        d=google.com; s=arc-20260327;
        b=frgImxZiBrmLtUg9pCrsysOH0rVQ48/Sb2+f1Y+9nGB2FfWSlZ07vQrxoIrT5Yycd+
         maNXC7inAk9xw6iKLJTImCR2ax1tK5oElY6JTN1//nTVDlbqNO5ClWb75bUdQr+9hzZ8
         8T6NWaiH40LxQLGavdVlfoK2n9Pc8MLQTA+Tl+nRYIj/ZA4FKirS5/k80jDd3a5Wvx8t
         LB+6/q/lDEdqmPZI6OS2tl5DChVYyHcDCMAhA+d/oU7p5/m2SQpjJGssg1TEkmZpQQIe
         XCOKOG9/TTXoCc+aNPiLdk0X7ytt+GJ9gENeYYmg7i7079DuUV0gpwW92I8Qa/7Uq+BG
         0XVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        fh=okEqebdSwSRmDc68mA+VW8mqHnYPRJene8K6Tvu7w2I=;
        b=nVGW9rBVSkkFNYgmE/qo713kLGJ9OJ3EiWEa0+dVGO37lHXexgUd1r4E4p1PT3UPq6
         o2cX4Yt/O8biEP6t/vYVbXBBgB6kBLEBXTRMzWkIn8yJRPvEyg+Q2CRREXNIGYVB8pMp
         pYutEkeoWDF5Q8tIRv7VooG5COwdtEbex1M2vtSynNTe4fBUA3TznVaIr8+GK/OdQsvg
         jZnEWwh6Z7M70OwyxwIl+b+zl919MEVP0cOCGSLq9Ft8Or0iov/s9ZngLui81TITcxc3
         uTeTpbblGMiC0DqVhZyUpdJlarXgsLbnU14URbjQt7BrpGNO8qwhHF2yiqXSk28GYZvQ
         kCCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592812; x=1793197612; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        b=BRqHAhOJRFQGCZ0436cerbXsvDGcjOTtcEFCOpJRV+nbVKbSAKMl662tBLFTfb2Sg5
         NFxQNyHoxxgYHQR13h13k71ankQp/N0fxgwfPZdFZZwD0LZwBvhOQiky2tnvBNcGVE92
         vpRJ7hzp6lhKrZveGyDGkQ94JZjS5rrim4/SQCOenhyqo5st97RuKWVFwTkWZQ5bTbIw
         iWX7FjROAHIvHplEaKREmJYGpSp7sUQFKLAPhXVjYlSpM8WQnUK4iSviJf2DCzgxJwf5
         mmlBS+ISZT3vDsrX9Xx3+f3KYgz6TnHUVdIwJP9bY9OfNIdfJdTh5lFsIo+qwhCRzOmH
         nAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592812; x=1793197612;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HZWCDTWe8myvVLhLnC3gRwnDw2Z9dfDRU9KvUScIux8=;
        b=hUCN7cJU5spU74FgFrhM/Ire4iKxgms1/yl8mF8IBCGq/6sKSR/NTBRA6GrPI4kMbz
         G9l8ZQ4I7HBPmcy125EllJ7AsgBBDRAJdvnD2+Ipgr8C9c81aFc7/h7DhBzcFQ1EcB9r
         0dtWKDsRkRGWgNMl0x64jddQ/VizREKI/N2qTVyUK9HU9ut3B0/2x9w2IlXMsZAZEQ5R
         h/zY6l1gQCC5OGJH8BrofuW25biOrzi1KPSRo6+xqZJeyGNmc2ZCRxpNMJ7dbH7B1ch5
         kKUnrPhFs9MqulV9c0L+oFfyoMKab4zG03vGyvV2MrqESSaa0vvwww+trCGYvr5Fg82p
         9i0w==
X-Forwarded-Encrypted: i=1; AKwUvBzbiPyrpqvJVR2utXHnhQWyu+05uW6OvajSiGiN7J95A7mOdqX/jMCfgAaz4iZtf7MTyyWNnFdYLZrG@vger.kernel.org
X-Gm-Message-State: AFq9FYLX7meIgkeDTp5JzLcMaMb/MXzFa0gZcBTAj7EPCYGSgM5gfSGF
	xQWhzlKSSVc+4+/8DEnesCNQFm82ghFpW8t6jHeVUNHhp948pffv9LzIq8NNrYoBtp2IHwfkZXQ
	2CpxeFcK4Pa5xtkJ/qeFvCuckfp6jCDc=
X-Gm-Gg: AYBFou1xHcWZ0JJJnOi91egQtgDjc2/zmSIgv7Afr/NKUnes5gOr0xcN/eLPRtuZIQD
	x4+juDMH6MQ8+fb2qB11rLCKLPxJhYKzKGPRlEu8HG3VLoOHzK1ktgqV3/YklkdK8pNKmPyB2io
	V3LcDfhDeRKumArFT6sLDSmCiui0foWBj4dJ43/XjQtYZ/AYDW6KuDZj1RdUMMN7G8GdjZLQEJT
	nCtSfHq4i8qQy0y9U1zFEeEZaqSZgXmmzDGiyqWWvXEC6k4IX1SdpD5/goyK02NG04UAzjctJvC
	GKVGlBTFuW+7beQqyRDwtHIDLpMxLBIA3FUIWiwRmczgAmz6Kb+Wbj+FZLtsalXN20twsjN1xIG
	+z2pbDuxqriRBzJOc3qQ4uvUEgJRmVWcNlqs7
X-Received: by 2002:a17:906:c105:b0:c33:ca5e:8ddb with SMTP id
 a640c23a62f3a-c46796b58cdmr190770166b.28.1792592812271; Wed, 21 Oct 2026
 07:26:52 -0700 (PDT)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792552161.git.jan.koester@tuxist.de>
In-Reply-To: <cover.1792552161.git.jan.koester@tuxist.de>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Wed, 21 Oct 2026 16:26:15 +0200
X-Gm-Features: AclHuK9oo5ZYObAiFZur0ih7xDKEBxlKdO-BvoDx6w0mXhpoTx1_PdEXJcogV54
Message-ID: <CAPJSo4UJPnhLFAYRXE-_M2_Nin6=Ff02AjayD10cB7946MvJDQ@mail.gmail.com>
Subject: Adding dreaded Windows SID-style, or. Repeating history, the bad
 chapters. UUID/GUIDRe: [RFC PATCH v2 00/41] UUID and GUID user and group ids
 (*_r system calls)
To: Jan Koester <jan.koester@tuxist.de>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-nfs <linux-nfs@vger.kernel.org>, linux-cifs@vger.kernel.org, 
	netdev@vger.kernel.org, audit@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Oct 2026 at 13:24, Jan Koester <jan.koester@tuxist.de> wrote:
>
> Hi,
>
> this RFC series lets a user or group id be a UUID (RFC 9562, version 4)
> or a Microsoft GUID as well as a classic 32-bit number. Processes can run
> as such a user, files can be owned by one, and credentials, ACLs, keys,
> System V IPC, sockets, signals, audit and procfs carry the whole id.

Are you Linnux guys aware that this is just a variation of the
*DREADED* Windows SID that this patch tries to introduce, just with a
new name?
Maybe, before doing this, read about Windows SIDs, and why they are so hated.

Secondly, the whole idea of doing 128bit hashes as UUID is not new,
IBM DFS had it, and had many iterations of security issues via hash
collision exploits. 40 years later all this horror comes back. Does
history really have to repeat itself?

Lionel
