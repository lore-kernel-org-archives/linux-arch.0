Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC53D3D00
	for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2026 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784010206; cv=pass; b=J2i3W9gTiE2At50R5faZZwj/H7mpzake+gj6dopiYQwiV+xXts6k4hQRE4z5Gp33NUYOz6Q2JXYVO7sIp0KkgskFBpHbvCSnH8evZV5Q4fq8VMVmGbvMJ1BNSQakNui+gk8WmI8J54iDwdRzXAIBd4T3oHcbOkLsBfjdWhl8ERk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784010206; c=relaxed/simple;
	bh=Wnrg0Gu0f2+9+eCpNmhH2Vvi2/B647p4odZ67Sj98Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1rTEcx46e88QUCoZrX/0KBYclX5ykDYmK6o2qCWoQTWk+COvjwkDyhngikdm4USwAdZXMuvUI8nDuijGQUmDESzNLmP/iFAwunIdGYgkEU5sk73PbVqs2JN8ecCJth2mHNskSYhGlRGXi3tAE2DcOZuSwPnZdZYua+0kjCI1gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C5yZtrYa; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C5yZtrYa"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4513435cdd2so1461723fac.2
        for <linux-arch@vger.kernel.org>; Mon, 13 Jul 2026 23:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784010203; cv=none;
        d=google.com; s=arc-20260327;
        b=DyRTtNrpNoGx13jkXWtx3+PepKvLDHX4Z4zDm4mad+Iwt/r3b8Yr1Kc+HgCx8cSety
         jQ2gZDzu05/T/p09gS3vuIlCxG1qHLbAq/V5o5DjnG5dFwM6C4qVpf2JvCm5tu0G1IIL
         k1BVKefta+9bUQNny9E/yltBexYixElEOtnU7ThVrbne4FPZg+No1urZSJAnvddI/O5q
         uzgQ72MayUOy8yuSbHcd7Ej/TdhR4lm0ZoW9nLS7icPtCcd64u1T8XIg33Z9vHVCYJA4
         gRXbceUn/4D3SRp6MMD8Vk8YkBXzQQ7QxN4orkqmaCTn9qEgAekUYlmaF8eZxdCctYHn
         y/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UmwZ2JdGpnQjzlIbtGvTSfdYg7lmImsp/NzZpGZ4h5M=;
        fh=ETIwW2nmwLIMmRi2Qu8I7I0gJOcL+LYAlTHGuh/x7UY=;
        b=rqJ2+8nVMzjvD/o1wMO/TbR6MkCUaxpjY4wfndwmcB1sk4DJkOQHs1DrzYTtpCEuZ/
         /iEcS6CGzwxBXimwjyOqfvra7uvmVhvwZ/iWTr0gEVKYHXunxNwiIxKz/7HkDt8cYFN5
         p7Os+z0hNxXtP9fK5N/sCXoYd+EvEjlRVqQi6IWw/Oybbr6LgJ4RiQta5NsNSfFxBHLM
         G0PXjYx0OEM6mbtigkvu4f3iLO7Q0TrKQ8bpe/lNzYjNRBrRLAh/7qq5N9B2144tFZWE
         Zuf+iyTG7miGGpTpOQXfhNN8GbgW1WSxzON1AiNjw/0G9PWCuPr5CjTepDXwZlXqFLFH
         TttQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784010203; x=1784615003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UmwZ2JdGpnQjzlIbtGvTSfdYg7lmImsp/NzZpGZ4h5M=;
        b=C5yZtrYaiOai+7as/nU2LgehtiklETKyJnzwc2vxBneqEmyzoH+JQh4eQyBUziM0lG
         C5BFzgkQ0c2YxmZDEwST2r64De/ECjJmxzDv2TrvOOCpuQTfRfVb87y/yoDNNyxYiYGK
         hGT+t4qBr1h2v3f0HU25s3P6QndmCuieG7ZWLNGT48IjDmJevjgX4rG6V0Kt7bbf0DHg
         wfJwy951dE9B5rrv9Xvd3Zl37pc6fokNAUUTN/MbomosKUGuFZnUbp3pbRH5WLoo9fxQ
         5PXbFNjVnwVb/4ZUmvXNnJapsE4j+3FyH/bOMiIVDa7gFXhWuKtSN1CJrzKAthipaDP2
         LOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784010203; x=1784615003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UmwZ2JdGpnQjzlIbtGvTSfdYg7lmImsp/NzZpGZ4h5M=;
        b=fBIKUENbztaM42GbIW6h1Pg0KvBpaJYKI2gT3GCW4K7N8++YZCDzxrljKX0PVmNeFp
         x5aqf0Zy13KQJhLL2CH+BjmXMJvaEdnFuVvR9TtvB4MH6XJhkhwrgEGmnT/ICbe4lLML
         x4PGWB2kgplmUS2MwDT402cVWy7D5Pze1UOCSutHbOQxkP1EOCP4FENuBjisv0PUDs/K
         i+ROgTzK/WEbXhqnKksdLWnsZH8zKPNX7/neDY0uyF9LdhT1qjUvnvccI10C4M1YQrxr
         +EziPASevJm3EmfsV7U1ybK1Pl+lXsjcj0RneGE843XICyvQL6JTUs57YruRnvPiqcbk
         FLHg==
X-Forwarded-Encrypted: i=1; AFNElJ//7Ck6pM9GQXynEjbgd+12Gg7wjQwX4WiQJXzbnEtxTfIs3lj2Z4wt73GoSvSWKcXa3+ibAPKQxNh1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxys2ZT6ZNso1Z1S5I1VaK9+x1qqCZBlMhK32M5O972Xgs+5eoW
	l9koicYm2hRTo8l7BC9ulu/6wLkSgnqrAFLiexZrH7joTfTeDqocHzTuqPUh+IdY4vVkZYeI8Gf
	ciINowOMXGljKIOIPdmb//iQqWFI/EfkhiwGq/oDtmg==
X-Gm-Gg: AfdE7clovpajLEcTnwhZUCRe0xH1odWrEmqu9aUFgKUiFslwW0GB68VU30EhzvEtQ8a
	xGP0+PY4F5aL6pKD/8pKus3A9elret1/PonjMOyP+Kljmf8BAFsOBZocSNkjepNvUVTzIUng5ZN
	lg5etu7dfAf+AFNXxtq5BW8g3eSDM0WOp87pmxVig4TCL9cvqCaWurw96rD8vH2YqIDsvjJSGfx
	MXjEhRrCp6deIXkJ+CIgVXo8nAxFDnZ4eyNN6hDj6RSRhaJQ1ZduVBPP0cHOYtiK6n05TtD1S0=
X-Received: by 2002:a05:6808:1b24:b0:495:f79d:b08e with SMTP id
 5614622812f47-4a47a6c1d27mr439710b6e.21.1784010203197; Mon, 13 Jul 2026
 23:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703122832.15984-1-cuiyunhui@bytedance.com>
 <20260703122832.15984-2-cuiyunhui@bytedance.com> <74ffb0c5-4edd-7b64-3d3f-be76c2aec4c2@kernel.org>
In-Reply-To: <74ffb0c5-4edd-7b64-3d3f-be76c2aec4c2@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 14 Jul 2026 14:23:12 +0800
X-Gm-Features: AUfX_mxF_EkkHPpXwVLSHWKREo9gY6a3BeqhKBMKR6LcYXx54wa2zu3a3fsDMQ8
Message-ID: <CAEEQ3wk8gK9pam2da=o5mbfzU3-5EtfH5nyhAoVfCoy+7UuCGA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 1/3] riscv: io: avoid null-pointer
 arithmetic in PIO helpers
To: Paul Walmsley <pjw@kernel.org>
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dennis@kernel.org, tj@kernel.org, cl@gentwo.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, bjorn@kernel.org, pulehui@huawei.com, puranjay@kernel.org, 
	thuth@redhat.com, ajones@ventanamicro.com, ben.dooks@codethink.co.uk, 
	rkrcmar@ventanamicro.com, samuel.holland@sifive.com, zong.li@sifive.com, 
	conor.dooley@microchip.com, tglx@kernel.org, debug@rivosinc.com, 
	seanwascoding@gmail.com, andybnac@gmail.com, menglong8.dong@gmail.com, 
	cyrilbur@tenstorrent.com, wangruikang@iscas.ac.cn, atishp@rivosinc.com, 
	apatel@ventanamicro.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	arnd@arndb.de, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, qingfang.deng@siflower.com.cn, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, Jul 14, 2026 at 2:04=E2=80=AFAM Paul Walmsley <pjw@kernel.org> wrot=
e:
>
> On Fri, 3 Jul 2026, Yunhui Cui wrote:
>
> > When port I/O is not supported, exposing the port-string helpers is bot=
h
> > unnecessary and can make clang diagnose null-pointer arithmetic from th=
e
> > PCI_IOBASE based address expression.  Keep the MMIO string helpers
> > available as before, but only provide the port I/O variants when
> > CONFIG_HAS_IOPORT is enabled.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks, queued for v7.2-rc.

Thanks for queuing patch 1.

That patch is independent and safe to take as-is.

For patches 2/3, we later found that the percpu try_cmpxchg fallback path c=
an
expose a variable-shadowing issue in the current RISC-V cmpxchg macro
implementation in arch/riscv/include/asm/cmpxchg.h.

I'll address that in the next revision of the percpu patches, so please jus=
t
take patch 1 from v8 for now.

>
>
> - Paul


Thanks,
Yunhui
