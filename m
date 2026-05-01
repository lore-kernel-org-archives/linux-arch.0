Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB7F191F94;
	Fri,  1 May 2026 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777642377; cv=none; b=fPVehykvpQ0rOL+U6il1S+IU7UbRzRfHmgyKXXTTBUU8ZnkxPXP82PmEWPiu51X5khr9gWoloQ3Cz2f3uBw2FTBCcxsB2LfHGnhXby7G1O3/nMFIdc1KYpo0DJ5ggp60064TfJEW1T6IMP67MM7O4vunnX2D3i3bFvo/aTEQP9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777642377; c=relaxed/simple;
	bh=AqyZXLeYzsJx+rZc7e1F5Sgu3BjZdoUpHMsJoKlvEcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXfQFYjsBE7XZPVDCKILODpVPcgk1lOByqcXuqQat0yVnxS2zJ6GONer+jnmDFVChcMedml91e++Z7exXwGts5OXar5VaDa5MVIS3cbepNFkKr8pMaWlOGKGGGHHL0+k57HiTenX+oVgEY4o0yUKYdNfvFKGHXPtBPkWwcSQbAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=jTKGB8Ia; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="jTKGB8Ia"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id ABB84C7B79;
	Fri, 01 May 2026 13:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1777642368;
	bh=IszU0JG/WWa2O3f5MsRNZrb+ulmlJxnxUGQwsmnwYmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jTKGB8Ia7D3+Zec5q4aruW2aznDUx+x2QbIxrQuVAh+HqJGpjaqhURhOBdhrZQbag
	 IWI5DhN3gDaOvxMrnc27MCpjJCByfrwPcadWoUrn575D9wcu8ZvKMjWZVZYlBfomtK
	 3l6KDosr8VPVi27Gi5jVQsMZxMlTisX765e0Z9hk=
Date: Fri, 1 May 2026 13:32:44 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v5 0/7] locking: contended_release tracepoint
 instrumentation
Message-ID: <afSrfOyn90vGC6ER@shell.ilvokhin.com>
References: <cover.1776350944.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776350944.git.d@ilvokhin.com>

I plan to rebase this series on top of Linus' tree to pick up Vineeth's
patch [1], and send an updated version next week.

In the meantime, I would appreciate feedback, especially on: 

- tracepoint semantics across different lock types
- overhead concerns in hot paths (e.g. qspinlock)

As a follow-up, I am also working on an RFC to extend perf lock
contention to make use of the contended_release tracepoint, so feedback
in that context would also be helpful.

Feedback from locking and tracing maintainers would be particularly
appreciated before respinning.

[1]: https://lore.kernel.org/all/20260323160052.17528-1-vineeth@bitbyteword.org/
