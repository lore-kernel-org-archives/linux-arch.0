Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F9A3BADA9
	for <linux-arch@vger.kernel.org>; Thu, 11 Jun 2026 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170719; cv=none; b=i8WK4kwAUZUqM47XcvxOl/gyF0evHyNbUjKx4DptzZomeISJFtZhz5J/Wgs7G8Fx2ZJW42mjbZCytsgdlXmlxVs4FLgJT9quJHaexBjsgF/PgjKRycXP6rXdU/BJIcxvWatC+mqoHfByutViSGOrPzzCaspJmWhpRRKqobDWznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170719; c=relaxed/simple;
	bh=kNPLZmfssJekzdvb4cuoNxf9QPode5jfaxyfBMiR+30=;
	h=Cc:From:Date:Message-Id:Content-Type:In-Reply-To:References:To:
	 Subject:Mime-Version; b=OQGCjy+PqNqe4AxKKQquJxxbAcIvKSk7eBz3uAOFSNavKsab8Jp3piU0ODfXdwkPymDhO5FZubmmbJQIMNWMjtk3fhjrISPYEs9lW3lIeZYNxp7MJ7K5KvcZKH5AabyeVPd+AbGJW3TutzFJ3cvkI9myZokXdqbHPISSgAo9u8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JceRipBg; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JceRipBg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1781170705; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=c9l8T6vuQd8ofYyGxx3NB8W3+1YzVxoYB7Bmx+2O71A=;
 b=JceRipBgMnyCRSncb1gLxnjk1tDDIUwYUSfCVm6p3SAF8MkXhHndETHQk+4e5cLPnD93C5
 GsPld2iGj6XCVhEn3+0+/gmsYTxLA5lOMKiNMbLyadk4zCp6Mi+sjHxHqr4vi6AcCEcyzu
 ACqFI1bvgsb03URfC02v/4u0frmXndutq+ep7SXNtP3tLodBI3f9y8DcFlCSdiSre2e09L
 CWkEtxFe2tpwk8OODH2NH1WsOJ1vWCmEGeSfWQ+S1KzcFW87OMay3NOcTNpTRo9MlyDJEs
 BdarHub4dXuqDyVMdWu3RHxT6j4PvnmAIJD4fpudFlrpIbroi1i1hv8lQ+OX/g==
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <x86@kernel.org>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a2a820f+d57ec4+vger.kernel.org+lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Thu, 11 Jun 2026 17:38:02 +0800
Message-Id: <20260611093802.74707-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260610191920.GBaim4uMX3z6OqJwHr@fat_crate.local>
References: <20260610191920.GBaim4uMX3z6OqJwHr@fat_crate.local>
X-Mailer: git-send-email 2.45.2
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
To: <bp@alien8.de>
Subject: Re: [PATCH v4 6/8] string: introduce memcpy_streaming() helpers
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

On Wed, Jun 10, 2026 at 12:19:20 -0700, bp@alien8.de wrote:

> On Tue, Jun 09, 2026 at 08:01:32PM +0800, Li Zhe wrote:
> > That said, I see your layering point. If arch/x86/include/asm/string.h
> > is the preferred place for the arch-visible wrapper, I can move the
> > wrapper there in the next revision while keeping the x86_64-specific
> > implementation details in string_64.h.
> 
> No, 64-bit only's fine. We don't put any new features into 32-bit already
> anyway but that wasn't clear from the commit message what your goal is.

Thanks, that makes sense.

> > Thinking about it more, I agree that this is hard to justify for a
> > generic helper. For this series, what really matters is that the
> > struct page copies in patch 8 can use the existing x86
> > memcpy_flushcache() fastpaths where that is beneficial; I do not need
> > patch 6 to impose extra selection policy on unrelated callers.
> 
> What I am asking is, you need to show numbers why those helpers exist.
> 
> Your 0th message is talking about measuring this in VMs. If this workload is
> not VM-specific, then those numbers don't matter. They're just handwaving.
> 
> So I'd need a good justification why we need the changes before we go any
> further.

Understood.

I do not currently have access to physical PMEM hardware on my side, so
the numbers I posted so far were all from a VM-based setup. I agree that
this is not sufficient justification for introducing the helper / x86 nt
part of the series.

For the next resend, I will first split out and resend the mm-only
subset, and drop the helper / x86 nt part for now.

If anyone  has access to real PMEM hardware and is willing to test
whether that part shows a measurable benefit there, I would greatly
appreciate it.

Otherwise, is there a preferred way to justify or validate that part
without physical PMEM measurements, or is the right approach simply to
keep it out of the series until such data is available?

Thanks,
Zhe
