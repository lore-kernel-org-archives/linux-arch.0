Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200240;
	b=RvoXjOcVQsJpi7HsELUtGRWjdjMTrD9aPoxS49XAYbe7cS4PwhgAAbcT8kVSqJ9XueIm
	 CmLB3YUa+7eG5y472hxK6PFBxdx5YjM/CgYntSeay62aYGRbSFNG41UJLguep98pDREvq
	 1MvXpo2Vu6yNp7Ezw6Qs1g4sxviDbWPvG+futIEpbWXkd8LMux85Vp41J2Kzq3oIe3pe7
	 kEFg1IoOupqLaeIYQi71bDp/AmU4RzfpV3IWJacMvI6WZeQS1Ezu8LHQ3Mbw4/gAcO11y
	 f73HGhkXHQSMGzKB/ah6/6wYCXOZ+ANww7t5/Kf/4bj071WIqKHHc57ex0jc3MtYMig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200240;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=1zNWv97CstwBNheuwZjrwa0R2kSphitL/TC9zaG/Pkw=;
	b=5I8CaGX1GH5jYGYPckR5ml3qqf5XKCAF94bWniQ81Pid+rFT6ttfSJU76cAcDXHefZ/3
	 H6qCDYeDkO70IgqE+F39ofsDnROI4PNReBeymGIoJ0WBKiuMtee3WR54r93nvIhFVVFpS
	 DY4TpwAm/QiVSSOKPsPjeA90KvoH8IRcBlgBWmiCPrCN7Hj6AJjR2F4irM10F1k6/QIDD
	 /MUVskKkwPp4j4Tan7bCs8v2vF7NulRvPlEobJ3YDYBksAluLbTEw4j9SAH0zY1H+MM/a
	 wBlvUFKCyPxVF06JbuUDkmNf9QPd1u+LNYenW+rZjI86ccyilxamuNZ+PiIe1Ug8mJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N95gnPXL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8C1606A31C;
	Mon,  9 Nov 2026 04:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N95gnPXL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1152D1F0089F;
	Mon,  9 Nov 2026 04:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794200240;
	bh=1zNWv97CstwBNheuwZjrwa0R2kSphitL/TC9zaG/Pkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N95gnPXLnpzv+UXjUpQJCQWPHnwlMCE3wfy8ChEdK4EBt37m07f/VDaAK11B2doNk
	 DpoWmXLnxhO33o2Rq+cqHz/6ZzWH2CI/Ab9KsOobE+JX3xVTT75wULQ2YLb5lYadTv
	 +fFW0HXQF2FStsCCbpdQMoIzPuinc28mvJ1Y1CAH9pGxmXXd/uDtWLoWkaXjWZicqs
	 mS9AeVlEqfs/uy+GFLoSw+lYuFZeng03TFRq82FCbwpVaVIMxga88hFuR1VVt/SdGJ
	 eiHwh7d2xs2CsPWvXC0GvHjOLiQhcO88/PK///+rvCTcwyZTUyTAhdgOWPFu3GN5ch
	 aDiNcK/jSWjDg==
Date: Mon, 9 Nov 2026 12:37:00 +0800
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
Message-ID: <avFN7LbSK0q1gsB6@xhacker>
References: <20261108110406.97495-1-cuiyunhui@bytedance.com>
 <20261108110406.97495-2-cuiyunhui@bytedance.com>
 <20261108213254.67805ef0@pumpkin>
 <CAEEQ3w=5QwwvMJFJkpS51APoBjhed6oriCkvcieRdUFWrKtmSg@mail.gmail.com>
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
In-Reply-To: <CAEEQ3w=5QwwvMJFJkpS51APoBjhed6oriCkvcieRdUFWrKtmSg@mail.gmail.com>

On Mon, Nov 09, 2026 at 11:47:43AM +0800, yunhui cui wrote:
> Hi David,
> 
> On Mon, Nov 9, 2026 at 5:33 AM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Sun,  8 Nov 2026 19:04:04 +0800
> > Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> >
> > > RISC-V has no asm/percpu.h, so this_cpu_*() read-modify-write
> > > operations use generic implementations that disable local interrupts.
> > >
> > > Implement RISC-V-specific this_cpu operations with preemption disabled
> > > to keep accesses on the current CPU.
> >
> > Have you looked at some of the schemes (I think arm64 has the latest,
> > but also s390) that do most per-cpu ops without disabling preemption.
> > In particular they save the pre-emption check when pre-emption
> > is enabled.
> >
> > Basically the code tells the scheduler which register contains the
> > per-cpu data so that it can be 'magically' flipped during a context
> > switch.
> 
> Many thanks for pointing this out and suggesting this optimization. This
> is a very useful suggestion. In the common case no preemption or migration
> occurs, so the preemption bookkeeping and reschedule check are unnecessary
> overhead.
> 
> Implementing this scheme for RISC-V will require additional changes beyond
> the current series. If this series is otherwise acceptable, I would like
> to land the current this_cpu_* support first and then prepare a follow-up
> series using this approach.

Hi Yunhui and David,

During the merge window but before rc1, I implemented a riscv POC
following arm64's preemptible this cpu scheme. Each operation records
its per-cpu pointer, offset and address registers. Exception entry saves
and clears this state, and a noinstr c helper repairs the saved offset
and address registers on exception return after any migration.

However, my PoC is based on current percpu offset.

I planed to sent it out last Sunday, but then I found Yunhui sent
his percpu series(which is up to v9, I didn't know this before) on Sat.
So I hold on the sending.

Now would it make sense to rebase the PoC on Yunhui's series patch2 and
patch3, especially the percpu offset optimization? I can post an RFC
with this rebased implementation.

Thanks
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
