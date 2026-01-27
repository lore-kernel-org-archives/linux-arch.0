Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7B0309DAF;
	Tue, 27 Jan 2026 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539719; cv=none; b=WyfCamuyAlgDaaLPgSLrR4HFTvbsb/YEgxLzvK7n2bDVbS3U+UX+mKPFqMKO457+RDi87SkwPLQPHeurRPFzNRdCxzPvnMka7XewDvrt1HPtxdNnzpQde5DPftyWGQng/F0Ql8jRNe3vVjiyy1Tl1mwuEsMnCr7XMGVTxOHDKtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539719; c=relaxed/simple;
	bh=9Kb41GNzFdnMC+EFq433D0Buo8fGVFgZu1BYS4b9488=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2oZBXaOl77Ojh12QcwuaaHF+XegB+zctAJfcHxzOahBn8u+fekGhO+Cicpp1Ocl81frjymcgYyxcHjtuP3K2nAHSi7m24twNZ3l2cAW2pllLzOtzGPzp8wu51YfVQmaCeLGqOwZyuHuZFye0cl/COCLYJ+N/Ck23LmmJ+jF9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X2XQH8xm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X2XQH8xm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=obdC9iXBZdS6X6d26P7qD6oiizDlQ0sUiMP+WtFKBeM=; b=X2XQH8xmsnFy17u8Wtukg1lls0
	cCSpQfIIHvvQzC8rb0ntZFmRy9i3NLmxkQwZUgIIXuaggogve2YG2VV0Uxo5PphWN3QqF7VoSj/sL
	1XkPKIc7jKeFnirKiuNCp9rRD4UpqZQEjd17OVQNf8kDeKCjcHAYdy8WNt/yLM9TBNiJ1GX8sEM6b
	Yo5nLuV7oY5/77a8c0e5BzW+nD8WBAFIXeWsHwk5DRh3V9g51aVT0DPzSQCkPtdSnExaxCWR1Y24a
	0TPi+oKuFALaJJuqyYSz51tWhMdJ5EdI/RSqDXcyvCWJ4SXZUVjlLXg+dsAt3USinCubcf9rQOs5S
	k35eD8BA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vko6w-00000007rWg-1HVN;
	Tue, 27 Jan 2026 18:48:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 117F5303076; Tue, 27 Jan 2026 19:48:20 +0100 (CET)
Date: Tue, 27 Jan 2026 19:48:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ron Geva <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>
Subject: Re: [patch V6 07/11] rseq: Implement time slice extension
 enforcement timer
Message-ID: <20260127184820.GC3372621@noisy.programming.kicks-ass.net>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.068329497@linutronix.de>
 <20260117095737.GG1890602@noisy.programming.kicks-ass.net>
 <3FF1C1CB-ACE5-485A-8BFB-AFE561CA6EC1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF1C1CB-ACE5-485A-8BFB-AFE561CA6EC1@oracle.com>

On Fri, Jan 23, 2026 at 05:41:16PM +0000, Prakash Sangappa wrote:

> The database setup is on an older environment. The python script provided does not run as is.
> So, modified it to gather the stats by parsing trace-cmd report output.

I 'wrote' it against this thing:

  https://github.com/rostedt/trace-cmd/blob/master/python/tracecmd.py


> ========================================
> RSEQ SLICE HISTOGRAM (us)
> ========================================
> 
> Task: ora_dbwr_lmb-666257    Mean: 1593.058 ns
>   Latency (us)    | Count
>   ------------------------------
>   EXPIRED         | 3
>   0 us            | 8
>   1 us            | 116
>   2 us            | 25
>   3 us            | 2
>   4 us            | 1
>   7 us            | 1
> 
> Task: ora_dbwd_lmb-666196    Mean: 1548.641 ns
>   Latency (us)    | Count
>   ------------------------------
>   EXPIRED         | 6
>   0 us            | 19
>   1 us            | 203
>   2 us            | 33
>   4 us            | 2
>   5 us            | 1
> 
> 
> [..]
> 
> Task: oracle_668951_l-668951    Mean: 1797.796 ns
>   Latency (us)    | Count
>   ------------------------------
>   1 us            | 5
>   2 us            | 1
>   3 us            | 2
> 
> Task: oracle_671571_l-671571    Mean: 3285.425 ns
>   Latency (us)    | Count
>   ------------------------------
>   1 us            | 1
>   3 us            | 1
>   5 us            | 1
>   6 us            | 1
>   10 us           | 1
> 
> Task: oracle_672277_l-672277    Mean: 2361.600 ns
>   Latency (us)    | Count
>   ------------------------------
>   1 us            | 4
>   2 us            | 3
>   5 us            | 1
>   7 us            | 1
>   9 us            | 1
>   11 us           | 1
> 
> Task: ora_dbwb_lmb-666192    Mean: 1548.157 ns
>   Latency (us)    | Count
>   ------------------------------
>   EXPIRED         | 10
>   0 us            | 24
>   1 us            | 182
>   2 us            | 39
>   3 us            | 2
>   4 us            | 4
>   5 us            | 1
>   14 us           | 1

Thanks! that seems to confirm that 5us should be good enough for you
guys too.


