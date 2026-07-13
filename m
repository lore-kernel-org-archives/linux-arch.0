Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431434DB6D;
	Mon, 13 Jul 2026 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965832; cv=none; b=dQjeaO/VMu5+Hz2MtXkTR0zYIOuQT3ZJnUvVWcxQZnsmxt43evRgydeXA223qC2vGN0eQV1QKed0QlU/e8f6d4W9yO9Jp9mJ9n1lknrPft7FSoAFwg6wCen2o8yeRFV5JT1sVG1zXMKv/eoszTb9YuBSEBJq0GCW+WJ1jEYWtmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965832; c=relaxed/simple;
	bh=XdjFqq97CsKnnRSJEwXzRQMYq4/jhzVvgO9flQ46L0I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fEuXoxTxKNX14fT+FhZ9odjXRBSK4Byo7MKuPOamT7c4VElRMk/QaXABQlvCLrVPjJf3TFbL2VpNZnXlJsh8auolPV5xVyHky7b23zSix/01KOxn+uCwTORQY93gGUF9tNXb+lxZk0Op83Fvqvu4ekR4i6o6eCKvl+6wnMLnzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESOKP2rZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESOKP2rZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A7E1F000E9;
	Mon, 13 Jul 2026 18:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783965831;
	bh=0R1cR7bKh7ixS3Ep3XrpKwenEOmJrkdIxyoKz6OerB0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ESOKP2rZPyACXFW/kfBTOgmI3+3qmraqLbjJMYdrj3rjM8G8wl+2yrsV7SboHyQbQ
	 cBQkXKgK008NzCXQZBYUI1VDd6+5Mm6vuxOTstiYXXI/Q3pDB2tCojuKfgnSuCvzjM
	 mN9qDvnOrt37OWH8edLykRMnH6QeT13rxLkBs8tWhSHW0bDEv2Ir070kOlNO1UcyVh
	 f6rkxiqi58tXvghJ0k6P9qzrj/Dwdz3FJfy2KGLkNvzJXlFaRJ3mvnyhXloQv8wM33
	 XLg8vWZPxDV6NMnxwRU0qLkg+LHyAJ8SoA/7d8IkuYuaefHVETGtQdaIk/CCXPTt4L
	 6ZeGlodc0aoBg==
Date: Mon, 13 Jul 2026 12:03:47 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
    dennis@kernel.org, tj@kernel.org, cl@gentwo.org, ast@kernel.org, 
    daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
    eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, 
    yonghong.song@linux.dev, jolsa@kernel.org, bjorn@kernel.org, 
    pulehui@huawei.com, puranjay@kernel.org, thuth@redhat.com, 
    ajones@ventanamicro.com, ben.dooks@codethink.co.uk, 
    rkrcmar@ventanamicro.com, samuel.holland@sifive.com, zong.li@sifive.com, 
    conor.dooley@microchip.com, tglx@kernel.org, debug@rivosinc.com, 
    seanwascoding@gmail.com, andybnac@gmail.com, menglong8.dong@gmail.com, 
    cyrilbur@tenstorrent.com, wangruikang@iscas.ac.cn, atishp@rivosinc.com, 
    apatel@ventanamicro.com, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
    arnd@arndb.de, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
    morbo@google.com, justinstitt@google.com, qingfang.deng@siflower.com.cn, 
    linux-arch@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v8 1/3] riscv: io: avoid null-pointer arithmetic in PIO
 helpers
In-Reply-To: <20260703122832.15984-2-cuiyunhui@bytedance.com>
Message-ID: <74ffb0c5-4edd-7b64-3d3f-be76c2aec4c2@kernel.org>
References: <20260703122832.15984-1-cuiyunhui@bytedance.com> <20260703122832.15984-2-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 3 Jul 2026, Yunhui Cui wrote:

> When port I/O is not supported, exposing the port-string helpers is both
> unnecessary and can make clang diagnose null-pointer arithmetic from the
> PCI_IOBASE based address expression.  Keep the MMIO string helpers
> available as before, but only provide the port I/O variants when
> CONFIG_HAS_IOPORT is enabled.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks, queued for v7.2-rc.


- Paul
