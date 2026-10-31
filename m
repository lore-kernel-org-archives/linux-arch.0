Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793454203;
	b=ZHVLPpPz9qjCDAx14zX0UhEd4DCKc2HsQ4UMaxi2ouPR6Hw+rmrzEkzLFEVkl8RJOFx1
	 tSHhyOX44fYws/vIgsvw1TGEiM8LQCj6ZoBJ3K6LZiqIcyRl15Zc7Tp9WxXtBjTy4Wjrl
	 UhKpus5klY93cnok1R82OsgUt2fMfMIGzo/u/m2XWueDYZkfHcIeQKYf2WbJyuFCO6Y0F
	 bFZM/UpR1Ull7hG6DCVp5ADdaoBGYdGFi7N79j3m239z0oPthWP8eTXJ+k7Z65LMRvQYn
	 F9LclYphOtOjJ3DpZDd4AE6wnPtH1Z721aEdU7bGk+5dosnhheYE6M7QRWWTeupGJ7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454203;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=66bgSKb0DOWL4SFUCIicrUlT3Lz+gWTcaaEHqOFnbvs=;
	b=tmXyMmN07nI19qFjSkZRPkFtJ21mvQpItN9+6EGpzaoDnbOZ3+n24A8K7LqkLJvlFuvL
	 xORUDDX41U1aoH6UyJd/xrEvv/6syd0JXRfeVQnBcNFbyt0Av8tf7cv0FuhoOnRHquy0Y
	 U1Hy2704/noaZxZnQSO9g0XbO20ySdzsrrVhWQBKs5EyDgu3yN603cIHq0Pd88GJ0zOnc
	 uYU82QhuNYTOfrVDjhHGJQujEHg1dWZXRaoqcy+9tO2tJogbv/i5N0M42DbTw+pl7PwsK
	 002r3xN6LPuGUOD6K/FyFI9UwVpOmd1JgHE/H4EYb2R8V2VYoSeB4pBkTaSgscbj21g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eA0mAa2z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4D9606A324;
	Sat, 31 Oct 2026 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eA0mAa2z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A481F00919;
	Sat, 31 Oct 2026 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793454202;
	bh=66bgSKb0DOWL4SFUCIicrUlT3Lz+gWTcaaEHqOFnbvs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eA0mAa2zpNV970IeSP3nCf8NZ/Lo5128hSuJJkq9RoO5z+Wxup+loZ9BC1MYkevi5
	 mv+BPh6ZStV+K1XWrSt3U5UbsWDj2vxoGeo52REvpZSywVkspdyMIm+/LMCkHD6qWH
	 1DQKqgFSRoY1nRQHIJ3AfRZ+FnwETJ+lU1EJDzEUNpKlqF8QjbqzGdtO0Ku7Weqj7P
	 A2jEbxQgVmXr8hGkohLjyaOMA61/7sa+6ZV/gQxx1XDKAAgJmNN8Fv8DFV383P87ss
	 mhtKSXYiCSbKdLvvPVkmkpQvGQX5oN/Zbcd6yo9LN6jkAEAGJCunJuG2B+mnE3gUTa
	 qbtTcU4EqEFZw==
Content-Type: multipart/mixed; boundary="===============8608813931786842918=="
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <77f8506fd544603f9852ce2dc5b520d69a471ae727537cf4fe3896df90b8e804@mail.kernel.org>
In-Reply-To: <20261031130959.23472-5-wanjay@amazon.com>
References: <20261031130959.23472-5-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next 04/13] bpf: move bpf_get_btf_vmlinux() to btf.c
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: ihor.solodrai@linux.dev,almagui@kernel.org,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,linux-trace-kernel@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,arnd@arndb.de,linux-arch@vger.kernel.org,x86@kernel.org,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,mpohlack@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 31 Oct 2026 13:43:21 +0000 (UTC)

--===============8608813931786842918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: move bpf_get_btf_vmlinux() to btf.c

TL;DR: Commit message only: the author's Signed-off-by is behind a
TODO-NEEDS-IHOR placeholder, so it won't parse as a trailer; most other
patches in the series have the same placeholder.

> bpf: move bpf_get_btf_vmlinux() to btf.c
>
> Move bpf_get_btf_vmlinux(), bpf_peek_btf_vmlinux() and btf_vmlinux_lock
> from verifier.c to btf.c, next to btf_parse_vmlinux().
>
> Parsing the vmlinux BTF on first use (later in this series) makes the
> accessor apply deferred kfunc, dtor kfunc and struct_ops registrations
> and kept module BTF under btf_vmlinux_lock.  That state lives in btf.c;
> with the accessor and its lock there, it can stay static.
>
> No functional change.
>
> TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Jay Wang <wanjay@amazon.com>

The author's sign-off is behind a placeholder prefix, so git
interpret-trailers will read that line as a TODO-NEEDS-IHOR trailer and not
as a Signed-off-by.  That leaves only the Signed-off-by from Jay Wang in the
trailer block.

Documentation/process/submitting-patches.rst asks for the author's
Signed-off-by ahead of the sender's.  Should the placeholder line be
replaced with a real "Signed-off-by: Ihor Solodrai
<ihor.solodrai@linux.dev>" once the author provides it?

The same placeholder shows up in most of the other commits in this series
(2a58754b9ead, 32ad8adbb1a8, cc9b43c0e23c, 699a8e9536e8, c97dea7ddbb0,
38e2751cdb40, 66c4a6a9293d, e46b5971bc91, cae96a9f7395), so those would need
the same fix.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41205212136
--===============8608813931786842918==--
