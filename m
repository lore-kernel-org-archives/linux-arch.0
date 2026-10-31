Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466188;
	b=WQu4rJ5lhmrIDHRxLefdvTSy9MV/eF9Q+n7wb/21lItAVjiowRxUAVK30l5cQh2dAJKB
	 nS4D7XEKAwPzMZ0I8d8yV3Ntm0QTJ6AnaYnEt/IhnaZABSuQqXFG7R/r1CeIEesE5pD0F
	 IdZN7lKL9kRMGM2r384GR6uDViBXunrFkV83a5yYqYtllfKVt58lfzPSIxtmFinHF/eyS
	 8hv8GXJF1QtMjn5eE5vuoQ2cqUHuoM2LYftMVfYqiu4l+4fCJXjEAIHxjKlSbl9xHsXFi
	 7aUIVh2iSUIJj17jmHnh28Z/rDKilH0R7ccNqXWRXhsGRfokUFjbV7OPJ1p8jea4QlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=gba0XFZ/wiG7mOW6sD/3lIcnTLkNzkhvuJnY/kVtgnw=;
	b=oTvYP8XA1wQxYXzCMi2m3GZjJbxXNk9MRdn6rehQL1MxdI30P4gVy4VQForJ9X+z9g5u
	 n0Id7YTxfsVyw26rmZPUvW2OSwwDBoF054n9SxOUnpKsiLpk7I8NJToPi9PwMstvyp6GG
	 yAc7lLW8nHEdPXzJDhDICvyIuSZBK87WCimvjfFGznQU9v6VeYDwsk4BCwwYcXhKauF5n
	 gQcpNmrYSIYdMbIehImJVAzEeHJulAnAqp8vFED6DqIFC0rzxVkKF/9QxYvfQDOGlzpmu
	 +g+73ZXcseRljoZ0Fdl8Loo9v+IwHp5oRcujcYlVFTzOmB4LEZq6xuzsYUSEDI6QpVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i8E3v5cp;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C1C606A31A
	for <linux-arch@vger.kernel.org>; Sat, 31 Oct 2026 17:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0C1C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i8E3v5cp
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a06b436dffso418128b3a.3
        for <linux-arch@vger.kernel.org>; Sat, 31 Oct 2026 10:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793466187; x=1794070987; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gba0XFZ/wiG7mOW6sD/3lIcnTLkNzkhvuJnY/kVtgnw=;
        b=i8E3v5cpMSfAi1mqqro21Q/8Raqh769HEWZJL46CwnM2v9wK2OLVzJsAuCSE9qf3zq
         tQY50fNwQDpf+SJSRQlAgqkCXH0WUUKhP57b7/iP77Uf3WNogA/laZGasAKdFWEz783R
         toarBNdQRNtB75h9qwyX3N4XLDJa/7DPVsqKt+7a6In8nxnIlpSFdU2WiAXEmjKaF5ks
         XnZGp+AauqkTqlVVZmUVXtl4Ag0HgI6GlxH75NYUPYnvp305gsOHdLStmb2NDkg/ihGG
         sRkldpqZ/xsViTVAvbYKqxtnovFp7bSCwKkO/qhbTEhCAOOAoI1dYAM/lSLdEuekL6SG
         SZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793466187; x=1794070987;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gba0XFZ/wiG7mOW6sD/3lIcnTLkNzkhvuJnY/kVtgnw=;
        b=TBeovdMMA0s/gxjDDzDJCxB3xTOr/CxRiAMYOoyhJ9H8Hv+COkYPM1TJ2oqlNiQlSJ
         nGwj4mbc8X0OL909f5KzBF9KRajE+T9bPpivlCN9PyFoTZZZUka+xyXFLrHROmIhFrt2
         ZH5ldq+6au51L/Ju2CeGJUqBJz+pGV5RRlui6ZxoGgiNFYdOOCTzLxY3cxecOVB5H7zH
         uQWKnjBYFcxTtJcnT2309v1efzABQ2HZGHP7VdxQo/ztrlb1XiEexdEK+yKLoyHcOHn5
         QurxtvYHVSd3HQm45yFjX/Uwq/bAj8A2VwiHsnkNbj9Ln8tVNCJ6a1XLplgS++OqpLUD
         egIw==
X-Forwarded-Encrypted: i=1; AKwUvByoK5M8uA/OnYnfSMvILtftpqFIC5Ggoe6g3Ajxo6JMZcvPh0olaHxVF8/PUX0R+WtAmo6rZjGC8JWi@vger.kernel.org
X-Gm-Message-State: AFq9FYKDeR1BSNzRA8hYDOnZO2l/Z/jHbFTioz5teKBThLVI/XJOG+sH
	qNrf8Kc/jhCkbwR7nu8sAxR+MJYsPL0Y/EyDuMtghw9UpjYG6/Goeqcc
X-Gm-Gg: AYBFou3wjpogrUw0cNyMyC7fB5u7bO1MQFp8ok6o+nzIzeHDbuY0Fs/GCyiBhEmJ2SH
	5k1fEEM8ovxMpSznIETwnrSO46kik9dsUUBV7ziPQaHCT4k5kmdq+MkHMNfqVk5zZrCMowM0LNB
	UzjRMjatzwgCdOeb62HCHWFgETuLX0RM1g4aVDL5kevkbuLkfNQ22G/WL5+/s6mCdmHI8PwAVCD
	HHEVGOYv5cDyZMaXdXGVt6VnMKjm+B476Yfup6WGDY6/DuxJlSrl68gTFDH2mO1qRy10RIqk3Ah
	WCU1Y6xo4Tuq3N4USyiDZvJzwdNS+CuLS/ndx5EeHjBF0M62IuPbp6MChO2FsrUd51/GLMi3gQs
	JYwTvFTeeueiDkfFSEsSp5C6dWJUq38bydDBpuGbzN1msBAlUTTF4iDCBWrvSmJrjG8vcq8NYe1
	mGbtm2uGnlYxEVZgzlmF+3bXyfb7EmHakxepmBFeRHQVmzCMLiyVs+FrHNKNTDpL9MOfZNlGwW8
	9HkWXPgZnSWR3cF8Cob7nnu5x6cnkGOlzbBiPxBCCvXxfuV3z3P4ImZDI2AxkGk45Kq8UNRmk+4
	o/fXErwWLyYgFdahAmpvi81n0ODl/bk/Ly3Ak2xRwT/VSVFhT0e2WmcvaeYzxrSPnCYfbCNkz7G
	sTy5CrDgnHqE37aQemqkZ0yoZTQrCGkTjL3EQ8Ol4mxuDRJMwIJ85af0=
X-Received: by 2002:a05:6a21:b91:b0:3e8:e974:e45a with SMTP id adf61e73a8af0-3e928e26581mr4547143637.63.1793466186813;
        Sat, 31 Oct 2026 10:03:06 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aadad94a8esm817264b3a.55.2026.10.31.10.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 10:03:05 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 17:03:04 +0000
Message-Id: <DMJ6PAVGV9ND.29T5161F064JL@gmail.com>
Cc: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alan Maguire"
 <almagui@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>,
 <linux-kbuild@vger.kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 <linux-arch@vger.kernel.org>, <x86@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hazem Mohamed
 Abuelfotoh" <abuehaze@amazon.com>, "Bjoern Doebel" <doebel@amazon.de>,
 "Martin Pohlack" <mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: Re: [PATCH bpf-next 03/13] bpf: check CAP_SYS_ADMIN before looking
 up bpffs delegation names
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jay Wang" <wanjay@amazon.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
In-Reply-To: <20261031130959.23472-4-wanjay@amazon.com>
References: <20261031130959.23472-1-wanjay@amazon.com> <20261031130959.23472-4-wanjay@amazon.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, Oct 31, 2026 at 06:09 AM Jay Wang <wanjay@amazon.com> wrote:
> That is free today because the vmlinux BTF is parsed at boot.  Once it
> is parsed on first use (CONFIG_DEBUG_INFO_BTF_LAZY, later in this
> series), it would let any user make the kernel parse it and keep it
> parsed until reboot, which is what the option is meant to avoid on
> systems that do not use BTF.

Any user can do that without this mount.
/sys/kernel/btf/vmlinux is 0444. With patch 9 one read() decompresses
5.5 MB into vmalloc_user() memory that is never freed.
The parse is the other 2 MB.
After the first use the kernel has what every BTF=y kernel has today.
There is nothing to guard.

> Check the capability first.  An unprivileged caller could only ever set
> an empty mask; such a no-op delegate option, and a malformed value,
> now fail with EPERM as well instead of being accepted or failing with
> EINVAL.  Privileged callers are not affected.

That changes what user space sees, with or without the option.
Drop this patch.
