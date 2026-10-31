Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793454206;
	b=aKChXKb3MZp2l7gb1rdYI0/dkjXr2ZPLwEE0BZBBJyYvpLULVqf7b0b47lxbcCgaKOoi
	 Z3PrrO+Hga9ULLx+FpnECMTJyt2U9tjccmdGcasxjrRGoH0Q/y0Lre+r1O1uOfFJ+OVuX
	 4wnG1/xtiLd8DMpjg39nZ7rv+KrkGMpBBevMXESZoplHloC90X10QUnOxESKu/Ae8OWp3
	 arj/NXRh7ljyKwXKrMSpKJK/drFoq3lZo1r+2lERn6zgKtrLO1BKI6K4L/7aN5tGawlkK
	 UK80UfnC79OGbxdM0kKcc666CAgPOGLXZ9Ihuty1tLpgvspf3Pi7v7R9RcKv7IhAl5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454206;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=K/3NpGaOdOCqKy0a8BAsT2YmdkWElJhbX3+c/KHAt7M=;
	b=ED4DFQDxoHZioTdBAya9OAPvONWTNZmdLR1ARlNDeM4mx4l61+VSY2GkEV23sYulaBDu
	 QZy8V996K3WkthmJ5oVqnfceisHzWjb6qxygqUXhAi5yr4zBK6+c4z2fWQOmTjUDswWMI
	 MBmfd9hrFsNi9EokfLxkrc4tdNQfrKuUaQYj0AWp32UMHDIFhq8QTF6k1RL5EdGNIj5nM
	 s8A/FGSKbGjMQIWAxQlfiK477DNvJPQVo1i5g2zPRdHplvWCpzHbshBudQQpwBhIcxuSV
	 +jcRmYXjC8VTdvCJ15idVIy20o38nZGW0B4MGDiR3x1pCDJAxIVTTHu4+8bKuDo0Rww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGLHA7QH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D915606A322;
	Sat, 31 Oct 2026 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGLHA7QH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C9A1F00A02;
	Sat, 31 Oct 2026 13:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793454206;
	bh=K/3NpGaOdOCqKy0a8BAsT2YmdkWElJhbX3+c/KHAt7M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CGLHA7QHL35PGdIJ2e9gXahPunJnzTXMbOqojkffoN8nTSZMKVEtzZdydz3VlSepV
	 qm0xkdgXRor96yV2WJRAyBPV3/oeModYxXopFfzZSZbIvKw2b3mHCC0Y8Xh/aKYTWg
	 tb+snBpAF/dDUhp45oqlQ8XWV9wPy2t7iGmj1oQArmEVudrNdS9kCyqdepv+11WOuA
	 XA+nT5H7eokTadpc2aEjlm8bgMVK5RT3eGX5MqbNd2s6nX05ojdu7OcHeSsQdpIi7M
	 SgjGgMIOy5Z+ZzhjjsLgs9LepIQqVPYaToed5TKmqMSYXGR++ETdvaaNoNDVVKUbqf
	 YpvNm1fEcQugg==
Content-Type: multipart/mixed; boundary="===============5978086059840683749=="
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <83ccd128fbdbace58c73028a40bd77eafadd86168bebf213801692bb97fb216d@mail.kernel.org>
In-Reply-To: <20261031130959.23472-8-wanjay@amazon.com>
References: <20261031130959.23472-8-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next 07/13] bpf: parse the vmlinux BTF before taking cand_cache_mutex
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: ihor.solodrai@linux.dev,almagui@kernel.org,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,linux-trace-kernel@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,arnd@arndb.de,linux-arch@vger.kernel.org,x86@kernel.org,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,mpohlack@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 31 Oct 2026 13:43:25 +0000 (UTC)

--===============5978086059840683749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: parse the vmlinux BTF before taking cand_cache_mutex

TL;DR:
- New early returns on vmlinux BTF fetch failure may skip verifier log
  messages in btf.c, contradicting "No functional change"
- Author's Signed-off-by is a TODO placeholder

>     bpf: parse the vmlinux BTF before taking cand_cache_mutex
>
>     bpf_core_find_cands() calls bpf_get_btf_vmlinux() with cand_cache_mutex
>     held, from btf_get_ptr_to_btf_id() and bpf_core_apply().  Once the
>     vmlinux BTF is parsed on first use (later in this series), parsing also
>     parses the module BTFs kept until then, under btf_module_mutex, while a
>     module going away takes btf_module_mutex and then cand_cache_mutex
>     (purge_cand_cache()).  That would be an ABBA deadlock:
>
>       cand_cache_mutex -> btf_vmlinux_lock -> btf_module_mutex
>       btf_module_mutex -> cand_cache_mutex
>
>     Have both callers fetch the BTF before they take cand_cache_mutex, and
>     make bpf_core_find_cands() only peek with bpf_peek_btf_vmlinux().  The
>     ordering was found by design review.  With the whole series applied
>     and the fetch moved back under the mutex, PROVE_LOCKING reports this
>     cycle at the first rmmod of a BTF module after a kernel CO-RE load
>     parsed the BTF; with this patch the same sequence is clean.
>
>     No functional change: the BTF is parsed at the same points, just
>     before the mutex is taken; a broken BTF fails the load with the error
>     of its parse, and bpf_core_find_cands() handles a missing BTF as before.
>
>     TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>     [pass the error of the fetch on instead of -EINVAL from the peek]
>     Signed-off-by: Jay Wang <wanjay@amazon.com>

The author's sign-off is the placeholder line "TODO-NEEDS-IHOR:
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>", and the only real
Signed-off-by tag is the one from Jay Wang.

Can this be applied with that placeholder in place?  The submitting-patches
document (Documentation/process/submitting-patches.rst) expects a
Signed-off-by from the author, and checkpatch will flag both the unknown tag
and the missing sign-off.

Separately, the commit message says "No functional change", but the verifier
log differs when the vmlinux BTF fetch fails.  Before this patch the fetch
ran inside bpf_core_find_cands() and both callers logged the failure.  After
it, the new early returns skip that logging (see the comments on the diff
below).  Could that sentence be reworded to match?

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 3e947bdb224c..095362c0a1cd 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -8608,6 +8609,10 @@ static int btf_get_ptr_to_btf_id(struct bpf_verifier_log *log, int arg_idx,
>  		t = btf_type_by_id(btf, t->type);
>  	}
>
> +	/* parse it, if this is its first use, before taking cand_cache_mutex */
> +	vmlinux_btf = bpf_get_btf_vmlinux();
> +	if (IS_ERR(vmlinux_btf))
> +		return PTR_ERR(vmlinux_btf);
>  	mutex_lock(&cand_cache_mutex);
>  	cc = bpf_core_find_cands(&ctx, type_id);
>  	if (IS_ERR(cc)) {

Previously a failed fetch came back through bpf_core_find_cands() and ended
up in the bpf_log() just below:

    bpf_log(log, "arg#%d reference type('%s %s') candidate matching error: %d\n",
            arg_idx, btf_type_str(t), __btf_name_by_offset(btf, t->name_off),
            err);

Doesn't this early return skip that message, so a load that fails because
btf_vmlinux is an ERR_PTR (btf_parse_vmlinux() failing with -ENOMEM or on
malformed BTF) now returns a bare errno with nothing in the verifier log?

Earlier in this series, commit 32ad8adbb1a8 ("bpf: fetch the vmlinux BTF
where kernel types enter a program") added vmlinux_btf_err() in verifier.c so
that every fetch point reports a failed parse:

    verbose(env, "in-kernel BTF could not be parsed: %ld\n", PTR_ERR(btf));

Would a bpf_log() before this return, along the lines of that message, keep
the diagnostic?  None of the later patches in this series appears to add one
at this site.

[ ... ]

> @@ -10725,8 +10731,18 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
>
>  	if (need_cands) {
>  		struct bpf_cand_cache *cc;
> +		struct btf *main_btf;
>  		int i;
>
> +		/*
> +		 * Parsing the vmlinux BTF takes btf_module_mutex, which is
> +		 * taken before cand_cache_mutex when a module goes away.
> +		 */
> +		main_btf = bpf_get_btf_vmlinux();
> +		if (IS_ERR(main_btf)) {
> +			kfree(specs);
> +			return PTR_ERR(main_btf);
> +		}
>  		mutex_lock(&cand_cache_mutex);
>  		cc = bpf_core_find_cands(ctx, relo->type_id);
>  		if (IS_ERR(cc)) {

The same applies here.  A failed fetch used to reach the bpf_log() in this
branch:

    bpf_log(ctx->log, "target candidate search failed for %d\n",
            relo->type_id);

and, at BPF_LOG_LEVEL2, the candidate cache dump that follows it.

Can this return PTR_ERR(main_btf) leave the CO-RE relocation failing with no
log output at all?  Would a bpf_log() here, matching the other fetch points
in the series, make sense?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41205212136
--===============5978086059840683749==--
