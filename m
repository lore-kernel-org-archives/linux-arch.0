Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47E53563D4
	for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037829; cv=none; b=svpHn397rRx6Xv+l8rMcj8yESOjENarxJFEha0ncG06uNfYwEAPFvFyCAaHHIpt0ypFBMpPVXrKFFYND1DdEkfihGTnYXDZPSSLqmz5g35w4SBOqvB/V5SEyCRcNqYm1+XXAqKQjBiFMOpKydnmLbltWr4hFO1rjat7uIjKfNQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037829; c=relaxed/simple;
	bh=BSx3qFPNO/NMYwuSHNZB31nKRkS0Y90uuNokhVUvaPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uINfYaAK4VbIW7RkAg7fQPg1WRlUJjDbAEJUFQnGNKQPMf2cgLvc4v3JTE9OL7U8PCU6sx9NWLRZ4Ke6We0Lvr3jh/Mttg6h+zu1QHbyDEhDcSd37sLmbZzmdDVKjupSun5TvQoUeVL+ZsyUhzWUXAjYBNTykvw7MLXlttxzM94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=LmX7ETwm; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="LmX7ETwm"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8f231f3b130so88746785a.3
        for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777037827; x=1777642627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uWWbj/VPS78zqXVF7C00n2rbNCSFE3WHczyNV5IMoNo=;
        b=LmX7ETwm+ZO/lr2eJaaaoYplLnQ67tHwdCp7kA0z1dX7YDpyOrIynIrIR5l/s9nRQg
         cGQrPUasocBBXobw7LDy2Mtqk/VzTQr2g5S8LTKm9X6GOB3cZhUCNr+Wp1EQnc3mpPPu
         ZJMDUgLmqQX8t5rX5P4AGZhG1J2EUVnNHN3AEp1mNbBEauM1CO7uJ9TaEZGzQIllpUYO
         LXRSFEeg3V/M/68OF8DvwD8mWRwTBBOlFGDKFh0hXUxRuJhp0jvZjix4bTlph0c1Vggd
         X35XsAvgC7lvP4sK4qLjqXK3GZAsqyQDmjhgYSzRiRuPVE9JBNPlFuyQhwCvL8uEqrff
         RNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777037827; x=1777642627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWWbj/VPS78zqXVF7C00n2rbNCSFE3WHczyNV5IMoNo=;
        b=JZtoIsXCYk5XzLL0QYBmb8kmZQ3MlsedeQSfWtP2Yoav282Ea9XCt48j3/ygL8yPV0
         Z2QWCAqO3nB5tkHEII97b/CUg8grwDAYEV+3Bd9IC+LI1JY9KAL/T5FLRAa4JztW8kmc
         cyJEtaoldDP6Sphq1YFPRL47z/z8zTa0s1WeGLpkTzfy/7IFQSGsY+xWYrZqW6SwnfDU
         ZAcCKy9metLihL+rdBOmdmNe2ykxpSfZbQkDPbXdkohitHUutieQh6KId5eViAP43pV3
         8NbXatEXzT2qzhVB8HmM803rtoYb0A8ILwA2oCWzBKtnnDfIgg0qr/FVHu2FTyfAj/yB
         xACQ==
X-Forwarded-Encrypted: i=1; AFNElJ+B0xZ2Sqf4PxQqcdDLYOJYEUpuveOnpQRoL1F0KFrNDKrz8GPH6Sk7WDh26s/Bv5tY1U72NrdkwKxU@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi1nyEEkJijod7cT3waN9gxDcI2D1XZZ6A/KWICiTvIZ5zOHog
	jZ03MDxHRgCUHYZSc4uklBobbK/fGeascBBkU+wlyF7vE7kNIexVinpeLHuKcrMNYp8=
X-Gm-Gg: AeBDievCjJAxtOOcErUJ2sWRbQSuyyQ05Yzzv5U3AEO3CRoPCEpEqaDtgl7fN40gAat
	rDo8i47b329O5tJ4EjQgqZIBYpTAQd++Zd6P0ATW3K4XIx2w3JH/9J9xh7teDZCpp5hQQ6NWY4E
	rYAO8U0jnjqL1pYvNyDcaKB4v8J09/BPqHb8qvQGUGAkeQQ/Ak1yLwGqXGq7fZy2GUUCxrtyAcX
	S3jCqb3SVgHh6LRg73eOQhNVbMbovm6LaPo7e7lN0IiyrUQrvPeofyE4kt5n2kLqRA2tncAy7KP
	exLvENlqRMgox3gKvpYfabCHN9d041yvkBwQ2Wp2CZxI0YX+raKY+jvOomdBKf+kIs5S6KFD/Ge
	GOZ+c1I9yuZnFo/4X2asATHlxNdMZQyyV5F78xBjLansaDuwGoLdPqXSgq1XTQ07nEIaMr/ljSI
	fIL/vc/rGbx6Lfi/oSKG7LKcbWezP0f08Rcyubeh5HPugMeKYlXLktmJqwOYglFA==
X-Received: by 2002:a05:620a:17a3:b0:8d0:27b8:fb7 with SMTP id af79cd13be357-8e79246cd79mr4470598685a.46.1777037826446;
        Fri, 24 Apr 2026 06:37:06 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe98dcsm1992846185a.7.2026.04.24.06.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 06:37:06 -0700 (PDT)
Date: Fri, 24 Apr 2026 13:37:04 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <lance.yang@linux.dev>, peterz@infradead.org, 
	david@kernel.org, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	ypodemsk@redhat.com, hughd@google.com, will@kernel.org, aneesh.kumar@kernel.org, 
	npiggin@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, arnd@arndb.de, ljs@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, shy828301@gmail.com, riel@surriel.com, 
	jannh@google.com, jgross@suse.com, seanjc@google.com, pbonzini@redhat.com, 
	boris.ostrovsky@oracle.com, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ioworker0@gmail.com, roman.gushchin@linux.dev
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush sent
 them
Message-ID: <aetw4aoABYj3keMh@plex>
References: <20260424062528.71951-1-lance.yang@linux.dev>
 <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>

On 04-24 06:30, Andrew Morton wrote:
> On Fri, 24 Apr 2026 14:25:26 +0800 Lance Yang <lance.yang@linux.dev> wrote:
> 
> > When page table operations require synchronization with software/lockless
> > walkers, they call tlb_remove_table_sync_{one,rcu}() after flushing the
> > TLB (tlb->freed_tables or tlb->unshared_tables).
> > 
> > On architectures where the TLB flush already sends IPIs to all target CPUs,
> > the subsequent sync IPI broadcast is redundant. This is not only costly on
> > large systems where it disrupts all CPUs even for single-process page table
> > operations, but has also been reported to hurt RT workloads[1].
> > 
> > This series introduces tlb_table_flush_implies_ipi_broadcast() to check if
> > the prior TLB flush already provided the necessary synchronization. When
> > true, the sync calls can early-return.
> > 
> > A few cases rely on this synchronization:
> > 
> > 1) hugetlb PMD unshare[2]: The problem is not the freeing but the reuse
> >    of the PMD table for other purposes in the last remaining user after
> >    unsharing.
> > 
> > 2) khugepaged collapse[3]: Ensure no concurrent GUP-fast before collapsing
> >    and (possibly) freeing the page table / re-depositing it.
> 
> Sashiko questions:
> 	https://sashiko.dev/#/patchset/20260424062528.71951-1-lance.yang@linux.dev
> 
> (I never know if my Sashiko emails are welcome/useful.  Maybe Sashiko
> said the same stuff about v9 and it's all wrong.  But better safe than
> sorry!)

These emails are helpful; but, I do not believe you should have to 
manually follow up with a link to every new patch series.

Perhaps  Sashiko could automatically send a summary email in response to 
the cover letter, or provide a link once the reviews are complete. For 
the kexec ML, we opted-in with Roman to receive automated emails from 
sashiko.

+Cc: Roman.

> 
> 
