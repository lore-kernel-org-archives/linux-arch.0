Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E1A36A35A;
	Mon,  6 Jul 2026 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364652; cv=none; b=ezZ3C4KGhwsg0/3M3QBG7b+5kHrN03CvdY3MOKyLDC8r0DvYoK3uYQlZOLudBj/4Ab5Vc1CZ+at4xEKNGCXyNRfA+jcgEBSwoaA/6lPtTnJMLuRY/9xMufPaCluOhfPB59LQPPLYHCOiziZN0jzd9oHat7KMgEpU+jw9fafZGNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364652; c=relaxed/simple;
	bh=5RLGVNDU4DrZCMKu/FBMg+Wv3SGC379Wmbng5p/GOgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHSlsBQ3WNM/DxpZusdS5DE7C0YTLyckJ5mjpt8BUnxisAFgj3NuRYuG86ZuEOoz2aJvGV62VcY5Y46XmQpO0nw37OCTij9iVz0BbdMhJKJIRVH4fDt0bt9fREAj81w7GmVs6kOmNOFUngKZyjHHe/QHMZ2i2CpdnuYFH42ZOj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KpAuzBeB; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KpAuzBeB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nfQ9zgkT3aT8H14uNPHLZ8/j4bpyM4lzgfsqYe3S6Vc=; b=KpAuzBeBJtQ64gMrvuYN/20KRv
	zq/lmv0s3X0jJ7Jr0n9YSIX/WC9XRI5KFZRYy9Y02wnbDEywUXMugU8USNGZTsUlPp5wyZbxV2ly4
	3U9pihOJ26YKM4PCrNeBcrqyHgMVksn/wNIe3aeGh+/3/MjeH07bUNz7whObLZso3IUEgVdz5Vl77
	8B5IUmdc7CVlZW091q89uIQvg0wvPaxnk0DqARUO/BFhMMM26oma0LV85Cwpys/xUh2y2twkT7/aK
	a86HIfK1LkTrxQ7JCPlLnPN8h3Ho5UK5Uu9NrL5XnToj0xCQxcrICbBvA1PckDP1GKNtLW5Iihzb1
	fk0si0Bw==;
Received: from 189-68-33-146.dsl.telesp.net.br ([189.68.33.146] helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wgobf-009swn-HG; Mon, 06 Jul 2026 21:03:51 +0200
Message-ID: <39c3f5cb-5b56-423b-b679-eafc67bbf44f@igalia.com>
Date: Mon, 6 Jul 2026 16:03:46 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] arm64/entry: Unify user mode handling
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Carlos O'Donell <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@aerifal.cx>,
 Torvald Riegel <triegel@redhat.com>, Darren Hart <dvhart@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Arnd Bergmann <arnd@arndb.de>, Uros Bizjak <ubizjak@gmail.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, LKML
 <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260705-tonyk-robust_arm-v4-0-e0fd0fa259d3@igalia.com>
 <20260705-tonyk-robust_arm-v4-1-e0fd0fa259d3@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20260705-tonyk-robust_arm-v4-1-e0fd0fa259d3@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 05/07/2026 14:56, André Almeida escreveu:
> Currently, arm64 has two functions to prepare and handle context switches
> from userspace: arm64_syscall_enter_from_user_mode() and
> arm64_enter_from_user_mode(). The only difference is that the later calls
> rseq_note_user_irq_entry() that sets rseq.event.user_irq as true.
> 
> To ensure that futex_fixup_robust_unlock() works correctly, unify the
> handling from user mode functions into one that always calls
> rseq_note_user_irq_entry().
> 
> Other architectures calls irqentry_enter_from_user_mode() for syscalls
> and interruptions, that sets rseq.event.user_irq as well.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>

It turns out that this patch is not needed at all and 
futex_fixup_robust_unlock() is already working correctly for arm64. The 
user thread can't call a syscall in the middle of the vdso function.
