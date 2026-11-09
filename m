Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226613;
	b=RuT3O8h8KSiD/V14Ji8eX9+8I8ZgEqddPHIt8HlxiqDEo84wyFN3V0yVh2bOzh86zp/M
	 hNhO0SBD/0zHng1DSFQoKbDm5lwDsjak0sptDuhk5nvfkEgQAlOdfOq+Z1hHV8u1oJs0D
	 kgH5Gcz1JFzsBjvvY8epq8yc69YLv19XuYlOZ9hM5HUl0rIX6wN/32f2MU24wZMN4nyFQ
	 vLWSh9Tdw4YYW9O10Cgc6ssjHwAcMkhyqSA/ttXhZd+fiKvrSuUAW93vle/rgYCp0FbxN
	 0szdpnewMtRT6ozPPJ729kW++Qydd7+oCkJgyJkCvjS2aROmaE0budnrJcVSrTVjPhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226613;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=5EAH61NrdU977284xwlV7JSstKvYCuFCm0A7SE4qcvQ=;
	b=O107qajctKEbwJhr+6KLzYm2t1TRuVeoxC8hwuKMBWfolub47gbjAa1cxLrA1NayTmRj
	 iBTJWppY+xQzFElBYCGbVVvpgM43pgO9cZAbsNKlPorcy73O10gWV9pF18sLk76ppD6D2
	 CugWy9YyyzCDkZ2qsOCv4alvAQYcw+bUm3j3KTgECvI0lL77vTKD1YtBkTobTRiarK6Sd
	 A3aZrXJDz79ixtsh1SPfXdtzFesD8dd7FszwsQVKEOejPMR33TdtdAiX/btG8vxOcebXE
	 qS6YYt2B0h4hnAFMOMgQoucU/JXhywvi1bpFgSf6YCWPWkb+Hh50tGAtmFvWrRy4ThQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g73xGVzK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294CB606A321;
	Mon,  9 Nov 2026 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g73xGVzK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D681F0089F;
	Mon,  9 Nov 2026 12:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794226613;
	bh=5EAH61NrdU977284xwlV7JSstKvYCuFCm0A7SE4qcvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g73xGVzKCsDCS81GLV3KO4OFB+mRx9gp+NMwK6egST5kX7bwDxGGd2lnD7uWsxe38
	 R5NM6ziSg0LlEvaNIXKBbKwC00C4d7ldcVdjBJW9bkVxWdHlkdf7soUAAa3GwGjXLi
	 TmVjZjVVQoNt45UGIxXVQ35Pehm9piXaesD3pTL2MxmsWlr+JzGRhRafI4M2LZoa9a
	 1UvHyvSVIqq+XJt/TEhZOJ7ZL6SpNvGNR9TdWjxhXYEmmiwZDGAAbNYJmZ4iCjm+3U
	 lrnUwP/yqdHKHv6auYd8/eW/fhenAirqnZiMsL2RLxLbnP72L+aIR1eSDLrgwlB7E5
	 EdCDcA/rSJCLA==
Date: Mon, 9 Nov 2026 19:56:30 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: David Laight <david.laight.linux@gmail.com>, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	dennis@kernel.org, tj@kernel.org, cl@gentwo.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, jolsa@kernel.org, bjorn@kernel.org,
	pulehui@huawei.com, puranjay@kernel.org, thuth@redhat.com,
	ajones@ventanamicro.com, ben.dooks@codethink.co.uk,
	rkrcmar@ventanamicro.com, samuel.holland@sifive.com,
	zong.li@sifive.com, conor.dooley@microchip.com, tglx@kernel.org,
	debug@rivosinc.com, seanwascoding@gmail.com, andybnac@gmail.com,
	menglong8.dong@gmail.com, cyrilbur@tenstorrent.com,
	wangruikang@iscas.ac.cn, atishp@rivosinc.com,
	apatel@ventanamicro.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	bpf@vger.kernel.org, arnd@arndb.de, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, qingfang.deng@siflower.com.cn,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, dave@stgolabs.net,
	emil@etsalapatis.com, ihor.solodrai@linux.dev, broonie@kernel.org
Subject: Re: [External] Re: [PATCH v9 1/3] riscv: implement this_cpu
 operations
Message-ID: <avG07pmpcLGkq5i-@xhacker>
References: <20261108110406.97495-1-cuiyunhui@bytedance.com>
 <20261108110406.97495-2-cuiyunhui@bytedance.com>
 <20261108213254.67805ef0@pumpkin>
 <CAEEQ3w=5QwwvMJFJkpS51APoBjhed6oriCkvcieRdUFWrKtmSg@mail.gmail.com>
 <avFN7LbSK0q1gsB6@xhacker>
 <CAEEQ3wmViZNwxXr8q477yHjtABStEJecCHS8=5s_UAk1hYgyfw@mail.gmail.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wmViZNwxXr8q477yHjtABStEJecCHS8=5s_UAk1hYgyfw@mail.gmail.com>

On Mon, Nov 09, 2026 at 01:49:05PM +0800, yunhui cui wrote:
> Hi Jisheng,
> 
> On Mon, Nov 9, 2026 at 12:57 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > On Mon, Nov 09, 2026 at 11:47:43AM +0800, yunhui cui wrote:
> > > Hi David,
> > >
> > > On Mon, Nov 9, 2026 at 5:33 AM David Laight
> > > <david.laight.linux@gmail.com> wrote:
> > > >
> > > > On Sun,  8 Nov 2026 19:04:04 +0800
> > > > Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> > > >
> > > > > RISC-V has no asm/percpu.h, so this_cpu_*() read-modify-write
> > > > > operations use generic implementations that disable local interrupts.
> > > > >
> > > > > Implement RISC-V-specific this_cpu operations with preemption disabled
> > > > > to keep accesses on the current CPU.
> > > >
> > > > Have you looked at some of the schemes (I think arm64 has the latest,
> > > > but also s390) that do most per-cpu ops without disabling preemption.
> > > > In particular they save the pre-emption check when pre-emption
> > > > is enabled.
> > > >
> > > > Basically the code tells the scheduler which register contains the
> > > > per-cpu data so that it can be 'magically' flipped during a context
> > > > switch.
> > >
> > > Many thanks for pointing this out and suggesting this optimization. This
> > > is a very useful suggestion. In the common case no preemption or migration
> > > occurs, so the preemption bookkeeping and reschedule check are unnecessary
> > > overhead.
> > >
> > > Implementing this scheme for RISC-V will require additional changes beyond
> > > the current series. If this series is otherwise acceptable, I would like
> > > to land the current this_cpu_* support first and then prepare a follow-up
> > > series using this approach.
> >
> > Hi Yunhui and David,
> >
> > During the merge window but before rc1, I implemented a riscv POC
> > following arm64's preemptible this cpu scheme. Each operation records
> > its per-cpu pointer, offset and address registers. Exception entry saves
> > and clears this state, and a noinstr c helper repairs the saved offset
> > and address registers on exception return after any migration.
> >
> > However, my PoC is based on current percpu offset.
> >
> > I planed to sent it out last Sunday, but then I found Yunhui sent
> > his percpu series(which is up to v9, I didn't know this before) on Sat.
> > So I hold on the sending.
> >
> > Now would it make sense to rebase the PoC on Yunhui's series patch2 and
> > patch3, especially the percpu offset optimization? I can post an RFC
> > with this rebased implementation.
> >
> 
> Given the substantial effort already invested in bringing this series
> to v9, my original plan was to land the current implementation first
> and add the preemptible scheme as a follow-up.
> 
> However, if the consensus is to move directly to the preemptible scheme,
> I will implement this scheme in the next revision, building on the
> cached percpu offset introduced in patch 2.
> 
yes, I suggest go with the preemptible design from the beginning. It
avoids introducing preemption-disabled wrappers that would later be
removed. But your preemption-disabled version isn't dropped, it can
be used for performance comparison. We can do similar benchmark
as arm64 does:
https://lore.kernel.org/linux-arm-kernel/28978498-348e-4cfd-af72-1146a106e96b@arm.com/
