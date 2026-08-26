Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9210913777E;
	Wed, 26 Aug 2026 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787708064; cv=none; b=Yhlbco7QgEcjPNnmSeGNGilOk+jWantb1KBwFAkFrg8UTHmtR9MBC/Swpj1sXHBX2BZkBI59e4SU91UwRrW4p36llx+PGwJR8s865aW98ZcgSUeIzkbnW0dVaQ1IuJvrdhHayEg09MTXDEZ+ahnFqXo7NSnCVGC8xdGRBxOOzBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787708064; c=relaxed/simple;
	bh=8mvVAM5/C4VKX+uyn+Ue+KiWk4xHiIhC8s/6hAlyMMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2nqq40Q9ZbQX84zZ7tsKX8SIKOsIkx1ngTV2KaSqxoTaNsj/KzcpJM6yk9gqc1SYuhuqiv/pnXjH4xVCR8g8SB0yhwClAZsyAav++lUphX7cxZzCTKxx0kZszUqxKvq0Q7w3PApdZTRmeyBm7TdmeNi+YV6tSWcIhaiXLXadj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=j6is/86G; arc=none smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="j6is/86G"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CF1D84E1377;
	Wed, 26 Aug 2026 01:25:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.96.17.28])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2F6304E1551;
	Wed, 26 Aug 2026 01:25:03 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shoe-Trade: 329137dc4d059e0c_1787707503612_153827419
X-MC-Loop-Signature: 1787707503612:1092170596
X-MC-Ingress-Time: 1787707503612
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.17.28 (trex/8.0.2);
	Wed, 26 Aug 2026 01:25:03 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4hV6QN4m4Qz1V;
	Tue, 25 Aug 2026 18:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1787707503;
	bh=8mvVAM5/C4VKX+uyn+Ue+KiWk4xHiIhC8s/6hAlyMMs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=j6is/86GlPmrZ409Z13BQVNYvcmsOqVE5NPB3rajquDkLuKgFEq0vQWaBy2ze21v2
	 guCgQsPzj672ix7aiK7PSuDhiCMVjcjSMi5txQiqHwQLAfOf8Q+hShk7ufHCvwCnu6
	 /OOITLkG4BMZPC1jlQGIAZRiaTZPHCF39n3GLKv+l55qryyNpe2zkTeOVzWiW9IfKV
	 U4T5po5xCW5Xej0JU0qJ7HjxmAtVCs9RuJ5fB+qIkZXb2R7sB5qT4/LKDKeIHj1LOQ
	 jU8YPXWFwRY8qmN6V26lMSe1iKhNLDNkTu+x6NyKkDURg3qwofhyDd7XtCE6LBvdVX
	 DHlAkm+mFg8/w==
Date: Tue, 25 Aug 2026 18:24:57 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, dennis@kernel.org, tj@kernel.org, cl@gentwo.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	bjorn@kernel.org, pulehui@huawei.com, puranjay@kernel.org,
	thuth@redhat.com, ajones@ventanamicro.com,
	ben.dooks@codethink.co.uk, rkrcmar@ventanamicro.com,
	samuel.holland@sifive.com, zong.li@sifive.com,
	conor.dooley@microchip.com, tglx@kernel.org, debug@rivosinc.com,
	seanwascoding@gmail.com, andybnac@gmail.com,
	menglong8.dong@gmail.com, cyrilbur@tenstorrent.com,
	wangruikang@iscas.ac.cn, atishp@rivosinc.com,
	apatel@ventanamicro.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	bpf@vger.kernel.org, arnd@arndb.de, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, qingfang.deng@siflower.com.cn,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v8 3/3] riscv: store percpu offset into thread_info
Message-ID: <20260826012457.ig3rfmji7vywf6kc@offworld>
References: <20260703122832.15984-1-cuiyunhui@bytedance.com>
 <20260703122832.15984-4-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260703122832.15984-4-cuiyunhui@bytedance.com>
User-Agent: NeoMutt/20220429

On Fri, 03 Jul 2026, Yunhui Cui wrote:

>RISC-V percpu addressing currently derives the base offset from the CPU
>number and __per_cpu_offset[]. Cache the current CPU percpu offset in
>thread_info so percpu accesses can load it directly.

fyi on a sifive p550 I am seeing this_cpu_inc() cost dropping by ~15-20%
an adhoc microbench measuring/grouping various calls.

Thanks,
Davidlohr
