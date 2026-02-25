Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71C2E2DDD
	for <linux-arch@vger.kernel.org>; Wed, 25 Feb 2026 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050295; cv=none; b=AEfkawSLT87urOuhLNEiDqEgZeUdb8pj0C8A6vwZ8a3jjcNyAfnBF9p21QVa9hCwaYE5DAC4hTVbYFOeAqandHAo2lVHlOU30XWD/gty80MtvKTxQJ9p/okkyHwzMTNoiee3MTKbe3A7Ps3dtiaPxvMRXjOxp7SKg1oCWbTVeQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050295; c=relaxed/simple;
	bh=xb240UHeJZUpSheryUetfPnHX+Or5u1jl7cIe9qLxno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U2j/FtbDkKnScuyYChduNBxW640DRVDFFK2mX0hAobpDLQRrpb3BqMBLMZpb2thMuJ5faMp2fuptUyq1vUNtQG/ieqawodPKnHByWGDzdLCb0IEcyQcdmTldJqsZV5ncnK6Tis0CTHyxnbiALVsp08hfQVaTerpIHRkY6zl1BSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+5JWYKQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+5JWYKQ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aad5fec176so185405ad.2
        for <linux-arch@vger.kernel.org>; Wed, 25 Feb 2026 12:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772050293; x=1772655093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l12W4BbMOvS46dH8NvG0bfSFtU9wMtIxMN8ZzhevNqI=;
        b=A+5JWYKQxnVD5EXVFIur1MWNAwKcG9bCb8KIfudNJB8x0qwjHebgxy/crsMHdJS24L
         DRcQrW5JWjwpIrdX3ETKgM7lz1RAl1c88RBgO0nXmcuqQvL0k+IgQLKfjxAO/s8PGzkr
         8l0dP8jzHoDSTvbWPf+rn08l4cDvJ7msSoYWUwT3i5jOoowTFyFzam2Yfj3rlrdBH2ws
         YGnPh9CVxlIRbawpGDzLKdqUi23IJXk9psAhftBDBxwUfm7LZeN7/4mUP2WuDNwW094x
         lPjVHmBp/j/bVXqjtiKRH9l6YS5B6XVkHKxfltIjKCsTJDhAxYj971NXDZaTwW1vAa5u
         z9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772050293; x=1772655093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l12W4BbMOvS46dH8NvG0bfSFtU9wMtIxMN8ZzhevNqI=;
        b=Ochb/Q13hOrxh7vxuXv/9d8hdvGpeWLPBKqNG8dwjMi9T/08v79jQujqgMAsE3YjiB
         m2MDZSU/CBHgCZjPOqX5ZF9x+bCiRdSo7XXWXIRC6cQ1QLkPvIdIgUl+m+c0G52w0Rvn
         ofIB3Hg7zipccq7oismq3OS9HOLl0N9GFp2AeRfB8ux+ADhWLgOzOtjpulgA5PuRSuZb
         sdSqEexedf1QFOEGy8GleZoWuEiJHADpusKJgoI2n19qNAv2uF1sG1QaT0AvK2pmm7LS
         9PSS7t+uVRyrcbiZzzXMQjwJDDeQa3qSYw42stF4JIr1NnGDiWnbacJAjs35ROjPS11U
         lxPw==
X-Forwarded-Encrypted: i=1; AJvYcCXJJDMstOBPU0wFjkRxl/4IwrqcQMCZ8s2R8pDgvOZwmeUJkk1Ov4x0Bco7prmcrI8nMTQvgTzKLJP2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzd5ef93eC8DpSAuIg//X4r+jDf2o4a/+sQewGer1Kao5u3S4C
	IwXU7rYcLVizPRS/2CujeDT3Yx1F3d6tBh/vXaGp2vw3ThKfJ4j0nHuQJICfhwcE+5GzVZgGTs0
	QoxRbmg==
X-Received: from pghq22.prod.google.com ([2002:a63:e216:0:b0:c6e:700a:2902])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a3:b0:371:53a7:a4aa
 with SMTP id adf61e73a8af0-39545ebb5a6mr14949603637.29.1772050292456; Wed, 25
 Feb 2026 12:11:32 -0800 (PST)
Date: Wed, 25 Feb 2026 12:11:30 -0800
In-Reply-To: <20260202074557.16544-4-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260202074557.16544-1-lance.yang@linux.dev> <20260202074557.16544-4-lance.yang@linux.dev>
Message-ID: <aZ9Xcgxa0_ouGr31@google.com>
Subject: Re: [PATCH v4 3/3] x86/tlb: add architecture-specific TLB IPI
 optimization support
From: Sean Christopherson <seanjc@google.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, dave.hansen@intel.com, 
	dave.hansen@linux.intel.com, ypodemsk@redhat.com, hughd@google.com, 
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, arnd@arndb.de, lorenzo.stoakes@oracle.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	shy828301@gmail.com, riel@surriel.com, jannh@google.com, jgross@suse.com, 
	pbonzini@redhat.com, boris.ostrovsky@oracle.com, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ioworker0@gmail.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 02, 2026, Lance Yang wrote:
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 37dc8465e0f5..6a5e47ee4eb6 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -856,6 +856,12 @@ static void __init kvm_guest_init(void)
>  #ifdef CONFIG_SMP
>  	if (pv_tlb_flush_supported()) {
>  		pv_ops.mmu.flush_tlb_multi = kvm_flush_tlb_multi;
> +		/*
> +		 * KVM's flush implementation calls native_flush_tlb_multi(),
> +		 * which sends real IPIs when INVLPGB is not available.

Not on all (virtual) CPUs.  The entire point of KVM's PV TLB flush is to elide
the IPIs.  If a vCPU was scheduled out by the host, the guest sets a flag and
relies on the host to flush the TLB on behalf of the guest prior to the next
VM-Enter.

	for_each_cpu(cpu, flushmask) {
		/*
		 * The local vCPU is never preempted, so we do not explicitly
		 * skip check for local vCPU - it will never be cleared from
		 * flushmask.
		 */
		src = &per_cpu(steal_time, cpu);
		state = READ_ONCE(src->preempted);
		if ((state & KVM_VCPU_PREEMPTED)) {
			if (try_cmpxchg(&src->preempted, &state,
					state | KVM_VCPU_FLUSH_TLB))
				__cpumask_clear_cpu(cpu, flushmask);  <=== removes CPU from the IPI set
		}
	}

	native_flush_tlb_multi(flushmask, info);

> +		if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
> +			pv_ops.mmu.flush_tlb_multi_implies_ipi_broadcast = true;
>  		pr_info("KVM setup pv remote TLB flush\n");
>  	}
