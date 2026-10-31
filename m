Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793454945;
	b=vHQr4FAjxPul69y3wT0Rrx/hIlx5WXucIHmyCreNrpLHrCI3u0UK5vGo1OKvDLOqCe3H
	 38c1nI3CJneeu4Wbiga9YfeTio6Q8S7Zc93goAukcaBlXRWQU11K61dJU56Jw8Rirxk6e
	 CsxSUZ7iofSu7/X1ExiYBUxLepsw34j0vV3Tsx9s6Zs5nagSZ+qVRXNyTLh/vVUh3xbn1
	 RRB8HNX34fjHUFwalwLF/5JoKOCUBNNc1QuGz7Y21WRinYkmLHXV0WpYwauaQFNVi72DE
	 rSSrZHyAEme5FXmEQqVb3UK59axvUiKxSLrwANSj1SURg8Z2YLUKPuD0cG4hyczE5kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454945;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=zuwM5CVnMPYRTsQ2zk+vWa+3BadmP9dyz74B+bdHmF0=;
	b=SOQIT0Rhzuf+3QenP2pUdfQOXUbrlB4K4e0eGffv1EMoBP16mJKsHig0ZhsxZ8UgmwfR
	 AjUUzhDrqO9G9LYdpjqgb9J5KQr7utCrvTqt345ELQ7lbyMteX/OnHN7QPyu21rfwdMXT
	 ocjC2A7r0gpddpNLvojnPStck1Lx4O/4fcAPkPR0lhhfz8iJRAI134cf07T1L30MGVlaY
	 HZBlYX5E2JuOXa1fuVbhm8N/Ultqt9GwqfewjocO//ovAj5UMrbbUKQv3g41CD70MJeZz
	 6QbKxrO2GVrfpxCwrp/SYFeT5jHBEsfenslxA9x1JshbMqoKLJzS6RlX3HaSbjY96dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AqCh+Yfp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74A3606A32A;
	Sat, 31 Oct 2026 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AqCh+Yfp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174FB1F00A15;
	Sat, 31 Oct 2026 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793454944;
	bh=zuwM5CVnMPYRTsQ2zk+vWa+3BadmP9dyz74B+bdHmF0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AqCh+YfpQCCqL8CrhVxo8BEzEwuwwKIORnVBxN5OOyDPmkOrZypR2Cx75mzGOfEhk
	 CnxKlI5lgfVuWkoxf3w9GSH3TsVEtuvz3NPDEDPYIbtb56iBSKB9MME1kB9infUPWq
	 NWNGeTD8/EOyTAApPUVnNg15pQf7rQVcijnvFGUHxeKr/jexuwyMVF5aBkRr65z2Ek
	 +0LE/V9WFXmn8YeEm1STMDFg4jP8P3qbBdI0CNxeMLQdB5YMoxVhiozytBQgRFPMuy
	 tKCCXfQ7Q8zFZdAJkhro2+TEcHrLWg190UGI0vnPEJrtVpskpm77A9Wr3vOEEuO0+I
	 Dv+mcXVWoVu+A==
Content-Type: multipart/mixed; boundary="===============6180907473628245553=="
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <33ce2cfacb0d57a90dfe08484cdf752e0f66d3e620292a0a891c816e29aa21e6@mail.kernel.org>
In-Reply-To: <20261031130959.23472-11-wanjay@amazon.com>
References: <20261031130959.23472-11-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next 10/13] bpf: defer kfunc and struct_ops registrations until first BTF use
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: ihor.solodrai@linux.dev,almagui@kernel.org,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,linux-trace-kernel@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,arnd@arndb.de,linux-arch@vger.kernel.org,x86@kernel.org,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,mpohlack@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 31 Oct 2026 13:55:44 +0000 (UTC)

--===============6180907473628245553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: defer kfunc and struct_ops registrations until first BTF use

TL;DR:
- btf_get_fd_by_id() may return an fd for a half-built vmlinux BTF after a
  failed -ENOMEM parse round, possibly racing with struct_ops table updates
- a permanent -ENOMEM may be retried forever, with the queue never dropped
- Co-developed-by lacks a Signed-off-by

> bpf: defer kfunc and struct_ops registrations until first BTF use
>
> [ ... ]
>
> Co-developed-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Jay Wang <wanjay@amazon.com>

The Co-developed-by: tag is followed by a "TODO-NEEDS-IHOR: Signed-off-by:"
placeholder instead of a real Signed-off-by: line from the co-developer.

Should the placeholder be resolved, or the Co-developed-by: tag dropped,
before this is sent?  Documentation/process/submitting-patches.rst expects a
Co-developed-by: to be followed immediately by that co-author's
Signed-off-by:.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -6928,33 +6928,70 @@ struct btf *btf_parse_vmlinux(void)
>  struct btf *bpf_get_btf_vmlinux(void)
>  {

[ ... ]

> +	mutex_lock(&btf_vmlinux_lock);
> +	btf = btf_vmlinux;
> +	if (!btf) {
> +		btf = btf_parse_vmlinux();
> +		if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY) && !IS_ERR(btf)) {

[ ... ]

> +		/* a lazy parse that ran out of memory is retried by the next caller */
> +		if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY) || btf != ERR_PTR(-ENOMEM)) {
> +			if (IS_ERR(btf))
> +				btf_drop_all_deferred(PTR_ERR(btf));
>  			/*
>  			 * Order the parsed BTF contents and the globals the
>  			 * parse populated (e.g. bpf_ctx_convert.t) before
>  			 * the pointer publication. Pairs with the acquire
>  			 * on the lockless fast path above.
>  			 */
>  			smp_store_release(&btf_vmlinux, btf);
>  		}

Is every -ENOMEM from btf_parse_vmlinux() really transient here?

btf_vmlinux_data() in kernel/bpf/sysfs_btf.c, from the previous patch in the
series, also returns -ENOMEM for a permanent failure.  Its comment says
"ERR_PTR(-ENOMEM) if that cannot be done (now: memory; for good: no copy of
the compressed BTF)".  If the vmalloc() in btf_vmlinux_keep_zst() fails,
btf_zst becomes NULL and every later call ends up at:

	if (!btf_zst)
		return ERR_PTR(btf_vmlinux_broken ? -EINVAL : -ENOMEM);

From then on bpf_get_btf_vmlinux() never reaches btf_drop_all_deferred() and
never publishes btf_vmlinux.  Every queued built-in registration and its
kmemdup() copy is kept, no "dropped N deferred BTF registrations" warning is
printed, and each later caller (verifier, BPF_BTF_GET_FD_BY_ID, the
CAP_SYS_ADMIN BPF_BTF_GET_NEXT_ID, module BTF parse) takes btf_vmlinux_lock
again to re-run a parse that cannot succeed.

This also looks different from the commit message, which says "If the vmlinux
BTF fails for good, the queue is dropped with a warning."

Should btf_vmlinux_data() return a different errno for the permanent case, or
should this retry test be able to tell the two cases apart?

[ ... ]

> @@ -9300,12 +9337,16 @@ int btf_get_info_by_fd(const struct btf *btf,
>  int btf_get_fd_by_id(u32 id)
>  {
>  	struct btf *btf;
>  	int fd;
>
> +	/* kernel BTFs get their ids while parsed, before they are published */
> +	if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY))
> +		bpf_get_btf_vmlinux();
> +
>  	rcu_read_lock();
>  	btf = idr_find(&btf_idr, id);
>  	if (!btf || !refcount_inc_not_zero(&btf->refcnt))
>  		btf = ERR_PTR(-ENOENT);
>  	rcu_read_unlock();

Can this hand out an fd for a vmlinux BTF that is still being built?

The return value of bpf_get_btf_vmlinux() is dropped here.  If this task's
own parse round fails with -ENOMEM (the commit message names the case where
the task is being killed and vmalloc() gives up), btf_vmlinux stays NULL and
btf_vmlinux_lock is released.  Another task can then take the lock and start
a new round.

btf_parse_vmlinux() gives that new BTF an id in btf_idr via btf_alloc_id()
before btf_apply_deferred() runs, so the idr_find() plus
refcount_inc_not_zero() above can return it while its kfunc and struct_ops
tables are still being filled in under btf_vmlinux_lock.

That seems to conflict with the commit message ("Nobody else sees btf_vmlinux
before its kfuncs and struct_ops are in"), and with the assumption in the
drop path of bpf_get_btf_vmlinux():

	/* nothing saw it: drop it with what was applied to it */
	bpf_ctx_convert.t = NULL;
	btf_put(btf);

If the second round also fails with -ENOMEM, that btf_put() takes the
refcount from 2 to 1.  The BTF is not freed and btf_free_id() is not called,
so a second, partially applied "vmlinux" BTF stays in btf_idr and can be
found by BPF_BTF_GET_NEXT_ID and BPF_BTF_GET_FD_BY_ID until that fd is
closed.

The fd could also be used while the other round is still applying
registrations.  For example, BPF_PROG_LOAD accepts a kernel BTF fd as
attach_btf_obj_fd, and for struct_ops programs the verifier then walks
btf->struct_ops_tab while btf_add_struct_ops() may krealloc() it.

Would returning the error from btf_get_fd_by_id() when bpf_get_btf_vmlinux()
fails (or at least on -ENOMEM) close this?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41205212136
--===============6180907473628245553==--
