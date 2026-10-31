Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793454201;
	b=PkphfHDoP4zDVKSLlts8WKUJXE6cv6A4jWvKAQDQd+ijU0yWvp8H91YTdiwQ6q5ga9pj
	 fr1lAxlRBECNGGnPbVjnXpKroDAhUQD0ooaVZh1lB7y0y7Eeoza5W86wH4cdBYCvOUrYL
	 rI6klYR2rLxUg+v2NaKZw7rSmXtAMXCA33ul3MtzHJO/zXoh/n2O2lkQevqrgYEyYEBUR
	 Zpj5J4FhrkGLrO1/jMw5fjZGEkXF6HMuiJwVnsmAUoaImweXUVRlqiCcMtvDQzwG6dips
	 3vSaNTKpYiQ7ObSzmNUq8TZG/WMb5UrpwPWRr494WYlGAast7hQQONNTK4kRC84e3BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454201;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=/3QIoDxh4ZfJDNF85SK3xAmU1m/92IEBeqvqPnhUvUU=;
	b=ZU8NAaHnbcPFtEtAwzEGF3n/ORjLTkqAH8h2GEUmWnChTcRQ93sZU92XbFvBw04zJsMJ
	 dXAsKB5/+I5GvxVltmqxx2MMSy8lrgpHPhkwPa0PQ+outJ7X4GasbEQkA0y0exjuVlnw4
	 6IJCfUv5/e04Va1MZmDaKohoi7hkXCm4vXtiSBA1KWV51kZJaC3pxObA2onCbidJO+2hK
	 Zg0zcFPMx6DXs4sQFmkeT3xogwr7/jOn7D0T23VmDBoy6D0q7tUWjifVgJ8/mJshhiGg6
	 iiJLqj+/nCiVMNKtxWoxdn9KYb3DYLyl7ZI7doZvpWhsI37iOEu2m1YYVYU/NTkdI/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkIftn2O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A6B606A31A;
	Sat, 31 Oct 2026 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkIftn2O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AEC1F00919;
	Sat, 31 Oct 2026 13:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793454200;
	bh=/3QIoDxh4ZfJDNF85SK3xAmU1m/92IEBeqvqPnhUvUU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FkIftn2OkpwnkV6gos9ANTeOHNf3B4fGkhTogS/fg0/5HEUJqPl5WZ40kcBbdba0N
	 lnHSDI+/GG5kZ9+Y5s9WVTeD2bS4jxKDOaGgJFesy8Bx0brnTnh7IpnmJywNnpBaQ1
	 1F675+hH0abuAv9EAMGmDCaBUs9xLPWnOL5VoryJaXvFJo8GU0ZdtS6dHhxb0Ux1V1
	 D3dmFc0NarOmwP+Um0vmGJhhWU9ac3Gv1XhZKtBEpgSNnUPt5g1LIFrTzb9ZHxxxwB
	 ZwaapDrlnsivRfW07B0yf3X4+bgiwRQg7n7iawiS3pOrQGcVLud3lZp/UZYdR1+CdO
	 ku4xERm5plGlg==
Content-Type: multipart/mixed; boundary="===============1857917533697366889=="
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <da17bdf7c8df8932b3b7adfdc3796a512c0302c72315be2ce16fd928763ee6df@mail.kernel.org>
In-Reply-To: <20261031130959.23472-4-wanjay@amazon.com>
References: <20261031130959.23472-4-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next 03/13] bpf: check CAP_SYS_ADMIN before looking up bpffs delegation names
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: ihor.solodrai@linux.dev,almagui@kernel.org,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,linux-trace-kernel@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,arnd@arndb.de,linux-arch@vger.kernel.org,x86@kernel.org,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,mpohlack@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 31 Oct 2026 13:43:20 +0000 (UTC)

--===============1857917533697366889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: check CAP_SYS_ADMIN before looking up bpffs delegation names

TL;DR: Commit message only: the "TODO-NEEDS-IHOR:" prefix on Ihor Solodrai's
Signed-off-by line looks like a leftover placeholder, so the tag isn't parsed.
The code change itself looks fine.

>     bpf: check CAP_SYS_ADMIN before looking up bpffs delegation names
>
>     bpf_parse_param() resolves the symbolic values of the delegate_cmds,
>     delegate_maps, delegate_progs and delegate_attachs mount options with
>     find_bpffs_btf_enums(), which fetches the vmlinux BTF, and only then
>     refuses a non-zero mask from a caller without CAP_SYS_ADMIN.  bpffs can
>     be mounted in a user namespace, so any local user can run
>     "unshare -Urm mount -t bpf -o delegate_cmds=any bpf /mnt" and get
>     EPERM, after the lookup.
>
>     That is free today because the vmlinux BTF is parsed at boot.  Once it
>     is parsed on first use (CONFIG_DEBUG_INFO_BTF_LAZY, later in this
>     series), it would let any user make the kernel parse it and keep it
>     parsed until reboot, which is what the option is meant to avoid on
>     systems that do not use BTF.
>
>     Check the capability first.  An unprivileged caller could only ever set
>     an empty mask; such a no-op delegate option, and a malformed value,
>     now fail with EPERM as well instead of being accepted or failing with
>     EINVAL.  Privileged callers are not affected.
>
>     TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>     Signed-off-by: Jay Wang <wanjay@amazon.com>

Is the "TODO-NEEDS-IHOR:" prefix on the first sign-off line a leftover
placeholder?

With that prefix the line is not parsed as a Signed-off-by tag by git, b4 or
checkpatch, so the only valid sign-off on the commit is the one from Jay Wang,
and the commit has no Signed-off-by matching its From: identity.

The same prefix appears to be present on the other commits in this series.

Should the line be resolved before this is applied, either to a plain:

  Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

or dropped?

The code change itself looks fine.  The unconditional capable(CAP_SYS_ADMIN)
runs strictly before the old "msk && !capable(CAP_SYS_ADMIN)" test, and
privileged callers see no difference.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41205212136
--===============1857917533697366889==--
