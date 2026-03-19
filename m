Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A3B35C19B
	for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2026 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930163; cv=none; b=tdB26zmUfirtyqK/e8XSch0OLIvFezBwfSEyCghLoizvbQ53GxKMKdhUkBGP2+vN5/S5RabOU0eY9+jAdBnBPJNs4WiZqQxCZMVgMpvicZMqHGgeCJhC6vPcnK8fVnINMXJNgd6J+8q4SDSJF6F0bgNi6ZtCLYSZXId9OEMWP/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930163; c=relaxed/simple;
	bh=Evs56mbBGrc90rf5Avs+YgxUnnNU/75HgapY7N2z4x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5UsAI5nTEsUvb0ovBhWbcO+8i6uIvduVKR20b8iL1nfOBGkti8WXJtNNfCxv8D9j6kg7u0qe4sffORch8CV/GlD2iJrMG5uPp7ok0AO+73QhFGoYflw6eGycODst2TyvmHAawljGUlTw0mHI4E4vXdTmeYjFwCRBEyKhHd5H1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMlDDde8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMlDDde8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5421C19424
	for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2026 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773930162;
	bh=Evs56mbBGrc90rf5Avs+YgxUnnNU/75HgapY7N2z4x8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hMlDDde8DsrwkOWo5HT/EiF10MKN88FAeNV16reePkJmv1ytzYUpR6CIayyMirfDl
	 BTHM66NNkBQKPrhQpEf24TsX0iYp3ARyLj/9oGvT6nDOEbBqw43rVJkCBVAIJL1y4e
	 4mKkO2qIXrOA8WWf07XWXDO/8cFh7My91Y4DZ5dBAk8hJ3egM1FuLsF6xC5tLC9onJ
	 xL8RXdr4hokpvx3k3nzAoXaDBeFRlImEA9ipIBYkkCkWFphy9DTcN5lqGwV046y6lh
	 lwEj/QHdVBwjIi9qW7WslKlg86INtuKw8s3gLoi2+x8xInH/5KbnbXCo2HHBTNW7dr
	 ugBH/slUSm5uw==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7947cf097c1so10533417b3.2
        for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2026 07:22:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzTEMtxfo1BTw64HWfMhJeWdVB1rvsEDH+GCPYqiJwF105FzaxTfXEKtFCWxshwwvk2MzpLZHkMzKf@vger.kernel.org
X-Gm-Message-State: AOJu0YwjS+I3Qo+va3/8FhPxTrXQ10zP4uiiEeF7bL9IjJqTSTfzd6sN
	HBBTpwJe/tk0hgJb5AnsCzunanYwhX0mXV4/44kNO8KufEfqXVXBWmUNCNArfCdctX7qms2jgA4
	VXFaHTPTpw9+uPIRnkkqyS+g5Q64hhJI=
X-Received: by 2002:a05:690c:4510:b0:798:50ee:5b02 with SMTP id
 00721157ae682-79a71c5796fmr79996147b3.42.1773930161009; Thu, 19 Mar 2026
 07:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317082020.737779-1-ruanjinjie@huawei.com> <20260317082020.737779-11-ruanjinjie@huawei.com>
In-Reply-To: <20260317082020.737779-11-ruanjinjie@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 15:22:30 +0100
X-Gmail-Original-Message-ID: <CAD++jL=7pfMzFWuARfRVUBXRc4ezvQC5TCZD_X4qw5Yad4fchg@mail.gmail.com>
X-Gm-Features: AaiRm53EffMsAfPr3uekOiLcpbY4S2zx2ontAzqaUIvPI77DCokZR1JuXIQnFzc
Message-ID: <CAD++jL=7pfMzFWuARfRVUBXRc4ezvQC5TCZD_X4qw5Yad4fchg@mail.gmail.com>
Subject: Re: [PATCH v13 RESEND 10/14] arm64: Inline el0_svc_common()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, arnd@arndb.de, 
	peterz@infradead.org, luto@kernel.org, shuah@kernel.org, kees@kernel.org, 
	wad@chromium.org, kevin.brodsky@arm.com, deller@gmx.de, macro@orcam.me.uk, 
	akpm@linux-foundation.org, ldv@strace.io, anshuman.khandual@arm.com, 
	ryan.roberts@arm.com, mark.rutland@arm.com, thuth@redhat.com, song@kernel.org, 
	ada.coupriediaz@arm.com, broonie@kernel.org, pengcan@kylinos.cn, 
	liqiang01@kylinos.cn, ziyao@disroot.org, guanwentao@uniontech.com, 
	guoren@kernel.org, schuster.simon@siemens-energy.com, jremus@linux.ibm.com, 
	david@kernel.org, mathieu.desnoyers@efficios.com, edumazet@google.com, 
	kmal@cock.li, dvyukov@google.com, reddybalavignesh9979@gmail.com, 
	x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 9:20=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:

> After converting arm64 to Generic Entry framework, the compiler no longer
> inlines el0_svc_common() into its caller do_el0_svc(). This introduces
> a small but measurable overhead in the critical system call path.
>
> Manually forcing el0_svc_common() to be inlined restores the
> performance. Benchmarking with perf bench syscall basic on a
> Kunpeng 920 platform (based on v6.19-rc1) shows a ~1% performance
> uplift.
>
> Inlining this function reduces function prologue/epilogue overhead
> and allows for better compiler optimization in the hot system call
> dispatch path.
>
> | Metric     | W/O this patch | With this patch | Change    |
> | ---------- | -------------- | --------------- | --------- |
> | Total time | 2.195 [sec]    | 2.171 [sec]     |  =E2=86=931.1%   |
> | usecs/op   | 0.219575       | 0.217192        |  =E2=86=931.1%   |
> | ops/sec    | 4,554,260      | 4,604,225       |  =E2=86=911.1%    |
>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
