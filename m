Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794139127;
	b=UFjij2Y58TU+6giFqEdrp++0S2T8Vrn8hPGaLUQKFbbq5Tu+BDlkgHAFRdPsABGYmIxP
	 prZcIsaYDzJ4MKpBa7gSQrIE89N437R8gxWb4cxdaQWBFuGvvBvIss4OO3k3t2ncFs2/N
	 iKnHLful9yqG+B1//U0mF3/nIZBmd05V5rfuYy65KWCiX+cVQhmBAJysCUGL/6uv3Rdbw
	 Lwa531dUuRI5uEbVBObBCPxNhWtMo06idpCvcjgzfpdOqu4nQ1NhfcxXRsFj6Dk1ub6xw
	 6TJDMLQtl5ZO1rpkH4ygZRi3cNzepEuePKWp+iJOQMbdIDWqbU0rKZ7Gnu8UHb6poUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794139127;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=frdSBuiNZsaClAfWL1rszk93uoKIYFoT/2az2pnoHt4=;
	b=tWuqIF4Idhl3X9bmIWOWz1V5RqvWsBBoppemHxZTcSYWxo2+ISWmaovd47fCwdTKFzQL
	 6OpC7LqD8LbHx6urhwiaNJeWgx5Ko4rp2qO0j7W5qGC+dbTqT2NNR8/3CgfI4VjTlyR+3
	 8wnMcA/U9V9dQGs+EDp9zLVwBwdQc8o3ykekuIl5cm8vF5LDOYbdDoLgPLPMqDQsEaeim
	 9LPNxZMV9/VCT72CRAb5VLrXn7uvXqfIiKjQ8yveWQeogtOrX594sghaVAsup6ancTGnH
	 Yk4/0XTig7+i61xMwKJAuS4LBQWyggsPC3MtEOBlgEUKACArZBl0cUGRVcUoTaZFvbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=fail reason="signature verification failed" header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItgUl6Pz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C146606A321;
	Sun,  8 Nov 2026 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItgUl6Pz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A932C1F0089F;
	Sun,  8 Nov 2026 11:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794139126;
	bh=frdSBuiNZsaClAfWL1rszk93uoKIYFoT/2az2pnoHt4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ItgUl6PztSGNn2uQTaSE+c6elZ9dMsyQ66yn/YThcn1L1YS4hJFN5IQlHvj/kF/z1
	 2d/R7zA2en/UUgYrH/8IyMFqGeJtvBopjb584BWfSR2dG/uCQvL8WWgq7iczslSCHW
	 g9jh31BAYYxunw1f8Ybd70aYzBl7tUwxFyf83fm2gqAAuXqBEIzgRMhXPK+sWrknzs
	 yMomCSE/ysWqphi5xPPltDnJvmfe7v1TaeNySdKNo6HydM3ejnHBPeHMRBnoylZmCQ
	 ut7bXtq2vbcTEu6vTCD0q452CzUGVIplVMci32BvaekxFaPtw37zCLVdnVlEtEhCt/
	 qcPGw/hRNSamQ==
Content-Type: multipart/mixed; boundary="===============7105721968340737727=="
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <61dfc5e627706ca6bd1b23fbc8e9e4af7196ac827d3089fcc038079536f848eb@mail.kernel.org>
In-Reply-To: <20261108110406.97495-2-cuiyunhui@bytedance.com>
References: <20261108110406.97495-2-cuiyunhui@bytedance.com>
Subject: Re: [PATCH v9 1/3] riscv: implement this_cpu operations
From: bot+bpf-ci@kernel.org
To: cuiyunhui@bytedance.com,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,alex@ghiti.fr,dennis@kernel.org,tj@kernel.org,cl@gentwo.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,bjorn@kernel.org,pulehui@huawei.com,puranjay@kernel.org,thuth@redhat.com,ajones@ventanamicro.com,ben.dooks@codethink.co.uk,rkrcmar@ventanamicro.com,samuel.holland@sifive.com,zong.li@sifive.com,conor.dooley@microchip.com,tglx@kernel.org,debug@rivosinc.com,seanwascoding@gmail.com,andybnac@gmail.com,menglong8.dong@gmail.com,cyrilbur@tenstorrent.com,wangruikang@iscas.ac.cn,atishp@rivosinc.com,apatel@ventanamicro.com,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,linux-mm@kvack.org,bpf@vger.kernel.org,arnd@arndb.de,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com,qingfang.deng@siflower.com.cn,linux-arch@vger.kernel.org,llvm@lists
 .linux.dev,dave@stgolabs.net,emil@etsalapatis.com,ihor.solodrai@linux.dev,broonie@kernel.org,cuiyunhui@bytedance.com
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  8 Nov 2026 11:58:45 +0000 (UTC)

--===============7105721968340737727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> riscv: implement this_cpu operations

TL;DR: this_cpu_write_N casts val without parentheses, so expressions like
"zero - 1" or "a < 0" may store different values than the generic code on
RISC-V; no in-tree caller found that triggers it.

> diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
> new file mode 100644
> --- /dev/null
> +++ b/arch/riscv/include/asm/percpu.h

[ ... ]

> +#define this_cpu_write_1(pcp, val)	_pcp_protect(__percpu_write_8, pcp, (unsigned long)val)
> +#define this_cpu_write_2(pcp, val)	_pcp_protect(__percpu_write_16, pcp, (unsigned long)val)
> +#define this_cpu_write_4(pcp, val)	_pcp_protect(__percpu_write_32, pcp, (unsigned long)val)
> +
> +#ifdef CONFIG_64BIT
> +#define this_cpu_write_8(pcp, val)	_pcp_protect(__percpu_write_64, pcp, (unsigned long)val)
> +#endif

Should these casts be (unsigned long)(val)?  this_cpu_write() passes val
through unparenthesized, so the cast binds only to the first operand of an
expression, which changes the stored value compared to the generic
implementation:

  u64 pcp; u32 zero = 0;
  this_cpu_write(pcp, zero - 1);
    generic:  0x00000000ffffffff
    here:     (unsigned long)zero - 1 = 0xffffffffffffffff

  int a = -1;
  this_cpu_write(int_pcp, a < 0);
    generic:  1
    here:     (unsigned long)a < 0, which is always 0

This is the same problem arm64 fixed in 885bff055a0f ("arm64: percpu: Fix
this_cpu_write() casting").  I did not find an in-tree caller that
currently triggers it, but a future caller passing a binary expression
would get a different value on RISC-V only.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42475504268
--===============7105721968340737727==--
