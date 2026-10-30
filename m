Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793335088;
	b=tEUVbLvQqYHesDFpgwijGZsGOI5/Mc6bKVXs1TrXKATF+h7VcymRCWiEb1HhQM3IPSnF
	 LDOXbgyC1+2fDoUVkS+HnceHTPFf3D/ovu7wzJQafCbS/oeKWwNOSXd6ZZejLRpo+jaks
	 xXK6s0KIKzAkVJcndBAHu5ympcbJ/O3q3/BOPA7AoOekowEAm+yGb5PxZ0/ZpLdwJYxaU
	 xz6eYDRV1YDguQqevJa2YUhg8i2Jyy4wbz3N4m2TTO+1K+JD0WTdb3UbB76zLMl2pwxRv
	 qj8gHmyw32b6FBtXQ3idral9Do4MmdUt7NdYOBQv370OKOVrqixv2tmKgYkBQhsM9xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793335088;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=WwvcOsEObJ8qzzuuobsmrvvwKxGTjF3cc2+TTpbW1e0=;
	b=xXia2cN3vuYKVkgWNl64MDPty6ldAebpE5dQSF2F6CLB6GKdqLjx5Nk0rFmmpQcfuKAS
	 VSo28wBbHDA0uIFsWWwYXcO0z1X36ASkMnEqpav9mN41Kr43zpRAZzT+/1B5ss2y3QA+H
	 AmTL2xGVq9yQ7zD1q5GpoeXYGB0rkVXEZqipRVZWawhFtBYNj/DDpOWTKELQRSyJnmfXA
	 UoPvbQImCmxkgAtaS84s21KB6EeUd6ZUG8z6ngQGbBPzshIuUbwXxW1P70Gj56O32+4Ys
	 jh755UUmjK75F5UUix8OkGUXj6BTCh4E09IJnzXvkSe5+E5sFE0YPaqzYY0Rawe34zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=NJPsdvAy;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74A0606A31C;
	Fri, 30 Oct 2026 04:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B74A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=NJPsdvAy
Received: from kali (unknown [4.213.232.17])
	by linux.microsoft.com (Postfix) with ESMTPSA id B148C20B7166;
	Thu, 29 Oct 2026 21:37:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B148C20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793335074;
	bh=WwvcOsEObJ8qzzuuobsmrvvwKxGTjF3cc2+TTpbW1e0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJPsdvAyMdl07uIfgdrypurLmehiQZeL4zrhUYZxR96TMW5UhWVD/k6TDPncHWr08
	 HBDhGEi+B7G362mYoL0sIW0o2+nYfbIXv9oTWCTovARis9B9tYry7LlUyDoTTX9uPX
	 WKbEfCrsL3+VJgHmXIOzVAcYs4vOqZdpgIkHgEhs=
Date: Thu, 29 Oct 2026 23:37:54 -0500
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
	will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@kernel.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, rdunlap@infradead.org,
	david.laight.linux@gmail.com, broonie@kernel.org,
	boris.ostrovsky@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v16 00/16] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
Message-ID: <auQfIuQdpd2i2IrX@kali>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
 <auLHZnaCIajW1kxX@kali>
 <87v76lezeq.fsf@oracle.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v76lezeq.fsf@oracle.com>

On Thu, Oct 29, 2026 at 12:31:09AM -0700, Ankur Arora wrote:
>
> Sahil Chandna <sahilchandna@linux.microsoft.com> writes:
>
> > On Fri, Oct 16, 2026 at 12:08:21AM -0700, Ankur Arora wrote:
> >> Hi,
> >>
> >> Changes in this version address sashiko comments [17]. The major change
> >> is the change in the exit path in __smp_cond_load_relaxed_timeout()
> >> which allows us to simplify providing ACQUIRE semantics in
> >> smp_cond_load_acquire_timeout():
> >>
> [ ... ]
> >>
> > Hi Ankur,
> >
> > I tested this patch series on an Azure Cobalt 100
> > (neoverse-n2 on 64-vCPU Hyper-V guest (Standard_D64ps_v6),
> > on v7.2.12 + this series + arm64 cpuidle-haltpoll enablement[1]
> >
> > cpuidle-haltpoll loaded with force=1, guest_halt_poll_ns=200000.
> >
> > Baseline: no cpuidle driver(only WFI).
> >
> > Workload: PostgreSQL 16.15/pgbench scale 100, client and server in
> > the same VM over a unix socket, with single run:
> >
> >             with (-S)                         TPC-B-like r/w
> > clients  base TPS  haltpoll lat avg   base TPS   haltpoll  lat avg
> >    2       38658     +89%   52->27us     5299     +86%    378->203us
> >    4       72987     +99%   55->28      10305     +87%    388->208
> >   16      300895     +91%   53->28      42035     +83%    381->208
> >   32      590987     +93%   55->28      78319     +85%    410->221
> >   64      987749      +0%   65->65     130675      +3%    490->474
> >
> > Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
>
> Thanks Sahil. That's very helpful. Btw what's the (-S) option with
> in your first heading?
>
Hi Ankur,

This is the -Select Only option running one statement per transaction,
more info captured in [1] [2].

TPC_B like runs small bank transfer transaction.
> Just to double check: was the VM  created with any special option
> such as kvm-arm.wfe_trap_policy?
>
No, the host in my case is Hyper-V. The cmdline does not have any idle
related parameters.
console=tty1 console=ttyAMA0 earlycon=pl011,0xeffec000 panic=-1
> --
> ankur
>
Regards,
Sahil

[1] https://www.postgresql.org/docs/16/pgbench.html#PGBENCH-OPTION-SELECT-ONLY
[2] https://www.postgresql.org/docs/16/pgbench.html#TRANSACTIONS-AND-SCRIPTS
