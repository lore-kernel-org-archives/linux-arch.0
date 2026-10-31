Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793454939;
	b=TpaMc2IahT0mbl1sThPwpmw9+8bEMSEXycmBacOW2PicoaT6gO2jXvpw2VNT8WO4QGD2
	 aEuWIu5vopM/10x0KSUc2GhLG253fZCozZauyCS6BsPmRForrqbiJ34Z3auXO/ReGJcvl
	 LdG9MC7qCRdF8rLEnRk44sewi9OyS6OPgh1jkO3Ut0tUPK5XTB5qWpUdf2FUkVuVBPy5V
	 Kf4K7qFTdykHaEarPO/35S+UjPtkB6V0V+NUc+AutDXO5hzO1/5g0FLOlMQuXciXmcWP+
	 DHxaSNIcns4H4SrrvcV6mF/yJk0zttcK2juxZWk4typmNMIqbcGUfq7ngHNvNCg18fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454939;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Ny+/jqAJ/Xd58NYiZIs8Bj8CzFfC3B3HaUMlmBS8x5U=;
	b=xH7Rf7Nq4hYc9iNSyLYswoKz096E1wY38d7cDtYHCq8iXeBJIo7QLxMgyVKKzQ20Ao4r
	 YuM+DOahnJ5da3k0cCOyb4oROw0iu+uRgbYiv0l3CPxpkcyFCSNzvohQE/KNgjt6cxQEj
	 QVY2YI2ZxK/VYp2apdiVjAXqNZgcD4WO9CKHpLugl7sn3O6OGxDgBSpBFFtOfKgHMXw/q
	 jGYTY59F5P1x4z+0ss1mARTxqchrvtht+0IOG8sffFytSm2ba2eT5lcG51/lbw4KajkkY
	 wx87BD0NE/nfmyYlb6L8hkhJwRGkTyXzquR6Ee+35PI01V90L21qqUEPtWLKGPAfGoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AylG4p+Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E217606A31A;
	Sat, 31 Oct 2026 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AylG4p+Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871EF1F000C1;
	Sat, 31 Oct 2026 13:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793454939;
	bh=Ny+/jqAJ/Xd58NYiZIs8Bj8CzFfC3B3HaUMlmBS8x5U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AylG4p+YFfdrnCe0OUqIlv2SWuLoXVwvhd/1ttt7ojEFCUXoaOEJpZX8y6+OgG1yb
	 8VLZxNQag0Q5hdL0QVdB7mfVE/eZMurdo6jM5mDJuKxETze6zsTnFnGSyxElAFfSHB
	 EDJdRHmbHaWL4o/Vf7XpmassJpdEiTozpuiSLuNttcPPsXN/WO2LSs79aPOPLTM4Xt
	 gVExkiRleWHrRcHYmogOATxqjbwW/LyaBiGf6AdSUzV91OrV4kvJNKiWjSOl9xIhzu
	 OkgPaN2cAdrzIn+9q0tOqSLQ4g2kG48afrvt5nryTqRpD70UoBDHA8RAcn6TT6Hmdm
	 g4rJunGVz5EoA==
Content-Type: multipart/mixed; boundary="===============3267991115175372107=="
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f0e118762de35375fd8b6c5db9f93d01ed75338f6e974f44f44e7fc3ba25237a@mail.kernel.org>
In-Reply-To: <20261031130959.23472-10-wanjay@amazon.com>
References: <20261031130959.23472-10-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next 09/13] bpf: keep the vmlinux BTF zstd-compressed in the kernel image
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: ihor.solodrai@linux.dev,almagui@kernel.org,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,linux-trace-kernel@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,arnd@arndb.de,linux-arch@vger.kernel.org,x86@kernel.org,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,mpohlack@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 31 Oct 2026 13:55:38 +0000 (UTC)

--===============3267991115175372107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: keep the vmlinux BTF zstd-compressed in the kernel image

TL;DR: Commit message only: the Co-developed-by tag for Ihor Solodrai is
followed by a "TODO-NEEDS-IHOR" placeholder instead of a real Signed-off-by,
which checkpatch would flag.

> bpf: keep the vmlinux BTF zstd-compressed in the kernel image
>
[ ... ]
>
> Co-developed-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Jay Wang <wanjay@amazon.com>

The Co-developed-by: tag for Ihor Solodrai is followed by a placeholder line,
"TODO-NEEDS-IHOR: Signed-off-by: ...", instead of an actual Signed-off-by:
trailer.

Documentation/process/submitting-patches.rst says that every
Co-developed-by: must be immediately followed by a Signed-off-by: of the
associated co-author.  As written, the only parsed Signed-off-by: is Jay
Wang's, and checkpatch.pl would report "Co-developed-by: must be immediately
followed by Signed-off-by:".

The TODO marker would also end up in the git history.  None of the later
commits in this series (e46b5971bc91, cae96a9f7395, 4d32ca0c95ea) changes
these trailers.

Should the placeholder be replaced with Ihor's real Signed-off-by:, or the
Co-developed-by: tag be dropped?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41205212136
--===============3267991115175372107==--
