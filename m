Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793454943;
	b=P1Fr2OgMp2TlgbLUMotBkM1tSZk1XZJuE8rW3q6bLhE0MVy2QPoNUIJM851Gt6YIkK4G
	 nzmn35rPI2uNJMxIy4vY0JNOVDroefMJWJ31gL3ABnh4FdZD/ocwAiCeBDE92dMu+lLXv
	 7hrbIo5tHtojbcN4OxYFi34mtLGOP0UnRQsjrWp1TtpLMwYIXeKVFE55078CLQ81sJo0o
	 2txyYtLhNQREJW51KD5pr4jg+4oIlzDJwLpj66KLy6wKmluPCZDK/8VDVAV8bp7J6LGDE
	 d+8ZCMkPV3uq2zLMr6ggcmWb+N/AonKPvji1BMZXthQxlKETaiDTPZm3Xebc6jov35Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454943;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=WEC9jjWhMZfqLHobPRhgMsjiYpIhXAIDyZsD6lALi1Q=;
	b=YMNug1Kr0O4Wnrr6lOD5HFJPbI7rnATQV9+C4Ud17nVZ+CtQ/M9VTrk9NWfYocTem5kY
	 1K5JXDM1AmCYu5h4RBK+Ls1fi1XLHDOk1pVSfxxUEBqjumgqJ57LkrM1DGvRJafKv8CDp
	 j8UDnmvNMUj2GYd8zIW1cPJmput1bI6o+IKb13Z9lkV4wbY7gju0HTtSu1LHGeNpPgFNo
	 Qk09f9SSUYxa/7R1qkVxs4xRCBqW6ZZNEwoSxvwNJR+aNowpuF+uB6kvf/Wv9FFL5APrp
	 WmtEoUSeUQrW6OG5/sp56huQVyLOX6BrXq08yoC7/de/0er7AcRvoyS2FQ6Nw8PQMuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qqxtz0j4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4339A60A2600;
	Sat, 31 Oct 2026 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qqxtz0j4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5A71F00A15;
	Sat, 31 Oct 2026 13:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793454942;
	bh=WEC9jjWhMZfqLHobPRhgMsjiYpIhXAIDyZsD6lALi1Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Qqxtz0j4kAlU1eLqexdob1pR0pBjv/lFgit7+jegjyPJK3jri36unRSO7BEMj7KGt
	 MZ49OFqKrTAAebNpNrNCyOETEyN9aNqdh2+u7YGJ4YDWWdAheOP8l4eyMjUAfgN5Cr
	 kzk4h76ZQaEyXtyw7SqiYGZRmpPsBZMkNEw+p6jV4twxmi8cJOrgQSD51b9xVMG7+I
	 4BFlfBBSKhXy8B2tmVSM+527N2ixVVLP/psj9Gglq+Yjg2hSgi6FoI7nnhE+SHfVT8
	 W2TrDSnyNh7+7bJ04pUs4QUu/xn9jMwdcVvQHq3TF4dKqdvC/vgrcvWerZjgT/TjdH
	 IdjqbYxK+wYnA==
Content-Type: multipart/mixed; boundary="===============7036568890307472938=="
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <df56aa51cd704ab9a9b03d3574e6ab4c61d5e6d4cdddc17f4b0253f67cc077da@mail.kernel.org>
In-Reply-To: <20261031130959.23472-12-wanjay@amazon.com>
References: <20261031130959.23472-12-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next 11/13] bpf: keep module BTF until the vmlinux BTF is parsed
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: ihor.solodrai@linux.dev,almagui@kernel.org,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,linux-trace-kernel@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,arnd@arndb.de,linux-arch@vger.kernel.org,x86@kernel.org,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,mpohlack@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 31 Oct 2026 13:55:42 +0000 (UTC)

--===============7036568890307472938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: keep module BTF until the vmlinux BTF is parsed

TL;DR:
- Possible NULL deref oops in btf_parse_kept_modules() if sysfs_btf_add()
  fails for .inline, hanging BTF users
- Possible use-after-free of rolled-back module BTF via btf_idr (low severity)
- Kept module BTFs may not be cleaned up on permanent vmlinux BTF failure

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index e31f8b3fecf4..c7234bcba874 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -9396,6 +9399,149 @@ static DEFINE_MUTEX(btf_module_mutex);
[ ... ]
> +/* /sys/kernel/btf/<module> and <module>.inline */
> +static void btf_module_add_files(struct btf_module *btf_mod, const char *name,
> +				 void *data, u32 data_size)
> +{
[ ... ]
> +	attr = sysfs_btf_add(inline_name, btf_mod->btf_inline_data,
> +			     btf_mod->btf_inline_data_size, false, NULL);
> +	if (IS_ERR(attr)) {
> +		kvfree(btf_mod->btf_inline_data);
> +		btf_mod->btf_inline_data = NULL;
> +		return;
> +	}

Can this error path leave btf_inline_data_size non-zero while
btf_inline_data is NULL?

When sysfs_btf_add() fails for the <module>.inline file, btf_inline_data is
freed and set to NULL, but btf_inline_data_size keeps its value.  Before
this patch that did no harm, since the field was never read again.

With CONFIG_DEBUG_INFO_BTF_LAZY, btf_module_keep() calls
btf_module_add_files() for a kept module before it is parsed, and
btf_parse_kept_modules() later passes the two fields as a pair:

	btf = btf_parse_module(btf_mod->module->name, btf_mod->data,
			       btf_mod->data_size, NULL, 0,
			       btf_mod->btf_inline_data,
			       btf_mod->btf_inline_data_size, &inline_data);

btf_parse_module() checks only the size:

	if (inline_data_size) {
		inline_btf = btf_parse_split(env, module_name, inline_data,
					     inline_data_size, btf);

btf_parse_split() then sets btf->data = NULL with btf->data_size = N, and
btf_parse_hdr() does:

	hdr = btf->data;
	hdr_len = hdr->hdr_len;

Since a real .BTF.inline section is larger than
offsetofend(struct btf_header, hdr_len), the size check before that read
passes and hdr is NULL.

The trigger is CONFIG_DEBUG_INFO_BTF_LAZY=y with
CONFIG_DEBUG_INFO_BTF_INLINE=y or =m, a module with .BTF.inline that loads
before the first BTF use, and a sysfs_btf_add() failure for "<mod>.inline"
(the kzalloc_obj() or kstrdup() in sysfs_btf_add() returning -ENOMEM, or
sysfs_create_bin_file() failing).

The next first user of the vmlinux BTF would then oops inside
btf_parse_kept_modules(), holding btf_vmlinux_lock and btf_module_mutex, so
later BTF users and BTF module load and unload would hang.  The later patch
in this series (4d32ca0c95ea) only touches selftests and does not change
this.

The old load-time path guarded this with:

	inline_data, inline_data ? inline_data_size : 0

and the new kept path has no such guard.  Should btf_inline_data_size also
be cleared here, or should btf_parse_kept_modules() pass
"btf_mod->btf_inline_data ? btf_mod->btf_inline_data_size : 0"?

[ ... ]

> +/* Undo btf_parse_kept_modules() of a round that is not published */
> +static void btf_unparse_kept_modules(void)
> +{
[ ... ]
> +		btf_mod->btf->data = NULL;	/* the kept copy */
> +		btf_put(btf_mod->btf);
> +		btf_mod->btf = NULL;
> +	}
> +}

[ ... ]

> +		if (!IS_ERR(btf)) {
> +			err = btf_alloc_id(btf);

Can a module BTF that is rolled back by btf_unparse_kept_modules() still be
reachable through btf_idr?

Kept module BTFs now get btf_idr ids here, inside a lazy parse round, before
the vmlinux BTF is published.  If the round fails with -ENOMEM,
btf_unparse_kept_modules() rolls them back with btf->data = NULL followed by
btf_put(), which frees a module BTF only if nobody else holds a reference.

btf_get_fd_by_id() tries to close this window by calling
bpf_get_btf_vmlinux() first, but it ignores the return value:

	/* kernel BTFs get their ids while parsed, before they are published */
	if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY))
		bpf_get_btf_vmlinux();

	rcu_read_lock();
	btf = idr_find(&btf_idr, id);
	if (!btf || !refcount_inc_not_zero(&btf->refcnt))

A possible timeline:

T1: BPF_BTF_GET_FD_BY_ID runs bpf_get_btf_vmlinux(), which runs a round
that fails with -ENOMEM and returns with btf_vmlinux still NULL.

T2: takes btf_vmlinux_lock and starts a new round: btf_parse_vmlinux(), then
btf_parse_kept_modules() gives module M's BTF the id X.

T1: idr_find(X) and refcount_inc_not_zero() succeed, and an fd now pins M's
in-progress BTF.

T2: a registration hits -ENOMEM, so btf_unparse_kept_modules() drops M's BTF
(refcount 2 to 1, so it stays in the idr with data == NULL), and
bpf_get_btf_vmlinux() does btf_put() on the round's vmlinux BTF, which
frees it.

The BTF behind the fd then has base_btf pointing at the freed vmlinux BTF,
since btf_set_base_btf() stores a raw pointer and takes no reference.  Its
types[] also point into btf_mod->data, which is later adopted by the next
round's BTF and freed at module unload.  Using the fd, for example as
attach_btf_obj_fd, where btf_type_by_id() falls through to base_btf, or with
BPF_OBJ_GET_INFO_BY_FD, which copies btf->data, would read freed memory or
NULL.

Before this patch only the vmlinux BTF was in the idr during a round, and a
stale vmlinux BTF is self-contained (its data is never freed), so this needs
the module BTFs added here.  It requires two -ENOMEM rounds plus a
concurrent CAP_SYS_ADMIN lookup, so the severity is low, but nothing
structurally prevents it.

Would returning early in btf_get_fd_by_id() when bpf_get_btf_vmlinux()
fails be enough?  That is not complete on its own, since T1 could also race
a later round.  Would it be better to allocate the kernel BTF ids only at
publication?

[ ... ]

> @@ -11199,6 +11337,11 @@ static int btf_apply_deferred(void)
[ ... ]
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +	err = btf_parse_kept_modules();
> +	if (err)
> +		return err;
> +#endif

Is anything going to clean up the kept module BTFs when the vmlinux BTF
fails permanently?

Kept module BTFs are only parsed or dropped through
btf_parse_kept_modules(), and btf_apply_deferred() is its only caller.
bpf_get_btf_vmlinux() calls btf_apply_deferred() only when
btf_parse_vmlinux() succeeds:

	btf = btf_parse_vmlinux();
	if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY) && !IS_ERR(btf)) {
	...
		if (IS_ERR(btf))
			btf_drop_all_deferred(PTR_ERR(btf));

If the vmlinux BTF fails for any error other than -ENOMEM (for example
-EINVAL from btf_parse_base() or from btf_vmlinux_data()), btf_vmlinux is
published as an ERR_PTR.  btf_drop_all_deferred() cleans up the queued
registrations, but nothing does the same for the kept modules.

Every module that loaded before that point then keeps btf_mod->data and
btf_inline_data allocated, and keeps /sys/kernel/btf/<mod> and
<mod>.inline, which serve module BTF that was never validated, until the
module is unloaded.  Nothing is logged for these modules.

A module loaded after the failure is not kept, because of this check in
btf_module_keep():

	if (btf_vmlinux)
		return false;

so it goes to btf_parse_module(), fails with the vmlinux error and is
refused at load (unless CONFIG_MODULE_ALLOW_BTF_MISMATCH).  Two modules can
end up in opposite states depending only on whether they loaded before the
first BTF use.

The commit message says a kept module whose BTF cannot be used ends up
"without BTF, logged, and its files go away", and that does not hold on this
path.

Would a counterpart to btf_drop_all_deferred() that walks btf_modules under
btf_module_mutex and calls btf_module_drop_kept() for every entry with
btf == NULL, run on a permanent vmlinux failure, make both cases match?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41205212136
--===============7036568890307472938==--
