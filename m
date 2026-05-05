Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CFC3DCD8D;
	Tue,  5 May 2026 07:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965612; cv=none; b=eZmXZ6LghdeZz5iZbvyZdTvsoClwBzpv7UAPTWX42/oU7wB+TsMOZqIAjhLo5Yg89sFqu0X4aI+jwOLZep0YjSTFl+2vZtpteagdPzTH43QCLfaQpK6LFJ2bkVWQOAmYVYFEs1t7j5WT4XGcDXuf0XdGlwtTiZ4Uj0ruZwwXmfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965612; c=relaxed/simple;
	bh=Z0FXQFs0XgCitklm42p+eFCRXoSwhNl8YaZgF5P9pKc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=avacILT6F0XzWRQtG7yjb+gqwIc+WLbZHDC6rTgybEkGTI17LkGyovMpfHtxTrx7e03T3q7O9Tp3G/kXLxFDVHVcTU3vgpJGWxk6bZ4b/LyeXrKYx5tquSQeN+WV/YSIhXEj1wJXfdT5JqzXpWSPj80PgHGK2NvQm+h+f7ZqtJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZxWbBvY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZxWbBvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E591EC2BCF6;
	Tue,  5 May 2026 07:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777965612;
	bh=Z0FXQFs0XgCitklm42p+eFCRXoSwhNl8YaZgF5P9pKc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=AZxWbBvYjHzMwBGYAn0U/L+Y4nNRwAOnQ7QKBncZ5DofsMttNhg1rsqFqCAox2z4/
	 VLC8c51H6eGo4up2Oc9WzaBpVdjqlowLNCCdtrbnljiGBQOVebgMS8cmbhe4lEoUOR
	 YOUd4azIaiomeZtl+96K3UoRYPsTZCtUEYVtgzTDr47ziJI9XzLSYAno5EeSCiFszF
	 I0bFBlGGW91/979neAvZamO6efbThBqQq+v1advRIdvH24/vBNcixvmB4Ru5RePWTW
	 fTQkhHnQa+GFAtYyExdmfSAVa6wcAcfYaOQxhKk7LvgTC5vEJdzwI0EBfhAIJcGSDy
	 iIAYNNRsm+sqA==
Content-Type: multipart/mixed; boundary="===============8001377551619871004=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2b13d3da553b3d2b09d94c046e80281f972d997b3e9037a0b215d6663135711a@mail.kernel.org>
In-Reply-To: <20260505062026.91724-2-cuiyunhui@bytedance.com>
References: <20260505062026.91724-2-cuiyunhui@bytedance.com>
Subject: Re: [PATCH v4 1/3] riscv: io: avoid null-pointer arithmetic in PIO helpers
From: bot+bpf-ci@kernel.org
To: cuiyunhui@bytedance.com,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,alex@ghiti.fr,dennis@kernel.org,tj@kernel.org,cl@gentwo.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,bjorn@kernel.org,pulehui@huawei.com,puranjay@kernel.org,thuth@redhat.com,ajones@ventanamicro.com,ben.dooks@codethink.co.uk,rkrcmar@ventanamicro.com,cuiyunhui@bytedance.com,samuel.holland@sifive.com,zong.li@sifive.com,conor.dooley@microchip.com,tglx@kernel.org,debug@rivosinc.com,seanwascoding@gmail.com,andybnac@gmail.com,menglong8.dong@gmail.com,cyrilbur@tenstorrent.com,wangruikang@iscas.ac.cn,atishp@rivosinc.com,apatel@ventanamicro.com,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,linux-mm@kvack.org,bpf@vger.kernel.org,arnd@arndb.de,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com,qingfang.deng@siflower.com.cn,linux-arch@vger.kernel.org,llvm@lists.linux.dev
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  5 May 2026 07:20:07 +0000 (UTC)

--===============8001377551619871004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index 09bb5f57a9d3..6f5d70313c83 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -56,6 +56,8 @@
>  #define __io_pbw()	RISCV_FENCE(iow, o)
>  #define __io_paw()	RISCV_FENCE(o, io)
>
> +#define PCI_IO_ADDR(addr)	((void __iomem *)((unsigned long)PCI_IOBASE + (addr)))
> +
>  /*
>   * Accesses from a single hart to a single I/O address must be ordered.  This
>   * allows us to use the raw read macros, but we still need to fence before and

Arnd Bergmann raised concerns about this approach in his review of v4
(https://lore.kernel.org/all/3720c3a4-cc0d-4ba8-97ae-35def0189e2e@app.fastmail.com/).

He points out that the NULL pointer arithmetic warnings are actually
useful because they indicate real bugs - NULL pointer dereferences that
will crash the kernel if the driver is ever loaded. The proper fix is to
ensure drivers have 'depends on HAS_IOPORT' in their Kconfig entries.

He suggests removing the custom RISC-V PIO accessors (ins*/outs*)
entirely and using the asm-generic versions instead, which already have
the correct #ifdef checks. This would be a cleaner approach than adding
guards to suppress warnings.

[ ... ]

> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index ca5a1ce6f0f8..d799e5ccc943 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1205,8 +1205,12 @@ static inline void __iomem *ioremap_np(phys_addr_t offset, size_t size)
>  #define ioport_map ioport_map
>  static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
>  {
> +#ifdef CONFIG_HAS_IOPORT
>  	port &= IO_SPACE_LIMIT;
>  	return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
> +#else
> +	return NULL;
> +#endif
>  }
>  #define ARCH_HAS_GENERIC_IOPORT_MAP
>  #endif

Is this change necessary? The function definition here is already
guarded by the #ifdef CONFIG_HAS_IOPORT_MAP check, which should prevent
it from being visible when CONFIG_HAS_IOPORT is disabled.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25361792504
--===============8001377551619871004==--
