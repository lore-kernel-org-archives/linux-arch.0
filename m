Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B453325B091;
	Fri,  3 Jul 2026 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783112552; cv=none; b=BVAtMJwfzymj4FjBlHDrs4rYF1ad/9cd37FiuLDaaSiX/1ocweNraYSGpB5lHdd7jsSA7n9+u5ENiuT1uKYpZhNLMsbavgvEGDq+pfkcsLoM5EIPq/7/5/n0+AME/lYc7fDfI+QSA3JdZCxpB+7nLteLNaHmBqQto7wr3KzCRys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783112552; c=relaxed/simple;
	bh=jxr5ijdZCgTtQEj6ylU1K7gQJE20AMx2EEi5P8ijo2g=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YyGGU6E/+2QpcKjrTNBTIv9M4bcdJ92M5+ilQ/EZWJWBwheemdIFik9zydqZrl+7wnvKQ4YA+oPmrNhsrnC1YhQH06/BqY8f6r9BkXf8/bp3uGqruIjetHV4LZ4OBZ6CPzN3r2yD3COXqp/1BWvaZzN8PeKzTuBvNXABqH+LlsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxG157Of; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxG157Of"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E9A1F000E9;
	Fri,  3 Jul 2026 21:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783112551;
	bh=Kxy/nHrA/YPl3oQA1s1YUJFp/UiroxEca2CIOkGyN+4=;
	h=From:To:Subject:In-Reply-To:References:Date;
	b=QxG157Of+hFM+LFQ7BvmTo4/2xtWWbjNv088utFW0+XMcajzFhzht7bVw+dS/5+ve
	 z13t+B9J2d3OEuDdefTJaMFUi/E8wR9R4/Gm8FumDxvtidM05Sl+GmAf2UF3yFReVv
	 mqr0Uto/z7L5q4vJJuYvvkeRGjFR+vVDM1RsyJd1bHmq1AjopoNWuiUQKDN+DOiMd5
	 UKtcLljh6CArSl8nMs/YrmJNWbVz3y0ScJwJjIVzXckAgbDblGcbOkJB3HG6JTvDY7
	 ze5vM6LRITBpSbB+6er3+uBCHXU5LgTycppqNNQ6CQSegRpkLv+Lmifi7rpWsij9EC
	 tLM3kGlume1GQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 dennis@kernel.org, tj@kernel.org, cl@gentwo.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, bjorn@kernel.org,
 pulehui@huawei.com, puranjay@kernel.org, thuth@redhat.com,
 ajones@ventanamicro.com, ben.dooks@codethink.co.uk,
 rkrcmar@ventanamicro.com, cuiyunhui@bytedance.com,
 samuel.holland@sifive.com, zong.li@sifive.com, conor.dooley@microchip.com,
 debug@rivosinc.com, seanwascoding@gmail.com, andybnac@gmail.com,
 menglong8.dong@gmail.com, cyrilbur@tenstorrent.com,
 wangruikang@iscas.ac.cn, atishp@rivosinc.com, apatel@ventanamicro.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, bpf@vger.kernel.org, arnd@arndb.de, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 qingfang.deng@siflower.com.cn, linux-arch@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v8 3/3] riscv: store percpu offset into thread_info
In-Reply-To: <20260703122832.15984-4-cuiyunhui@bytedance.com>
References: <20260703122832.15984-1-cuiyunhui@bytedance.com>
 <20260703122832.15984-4-cuiyunhui@bytedance.com>
Date: Fri, 03 Jul 2026 23:02:28 +0200
Message-ID: <87bjcnlrbv.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jul 03 2026 at 20:28, Yunhui Cui wrote:
> +
>  extern struct task_struct *__switch_to(struct task_struct *,
>  				       struct task_struct *);
>  
> @@ -122,6 +129,7 @@ do {							\
>  	if (switch_to_should_flush_icache(__next))	\
>  		local_flush_icache_all();		\
>  	__switch_to_envcfg(__next);			\
> +	__switch_to_pcpu_offset(__next);		\

Why do you want to go through the indirection of current:

> +static inline void __switch_to_pcpu_offset(struct task_struct *next)
> +{
> +#ifdef CONFIG_SMP
> +	next->thread_info.pcpu_offset = __my_cpu_offset;
> +#endif
> +}

instead of using __prev->.....offset, which is right there available?

