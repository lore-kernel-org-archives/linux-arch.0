Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6689E3B52F6
	for <linux-arch@vger.kernel.org>; Thu, 26 Feb 2026 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130299; cv=none; b=Rp96crghYUGmJKktysGxmKKy7fLlQ7l283rewT+VMLbluxDhtTn6DVn9AZ3V19ngleBQ4SfeTnbmlbXcqxkcBiS/IDgSbhdt4UjuYrIHk64yLV+DA94Qa8VIwsHwRhC6FVjcJvFMrsfJ3gpoZX+6KQmcb1EtgMCYBNPP9NgtBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130299; c=relaxed/simple;
	bh=k3soXQkk7YLuqSivAHD1V0eG6RUMSXYigk1r/BeTy8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=efTO9KyPoc1Ptveszq4QaF4Io8X97thPIAMkHBS7KUeT6gTH+L3gfeJmSqy6RiJYY6Y5403Jtdt7SZRkfF5ao/sZMT7AK8vAK9odHkvJlkRMJOR9f1HQxFwq3a6CtXda2o6Zg0nNpsm9SRpwhkD7UVXHlJHO3gZ57RPKkshzQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGri9AOn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGri9AOn"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2adc527eaf5so7558745ad.0
        for <linux-arch@vger.kernel.org>; Thu, 26 Feb 2026 10:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772130298; x=1772735098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X3CnbC2LzEBnADf0H4jNpgSa/BKh2OZoa8tvpC3rGZ8=;
        b=NGri9AOnE3kuWDz43IjdMITNlyT/meOGX8wlNGKGPqTtFR+MxFkanXJoTwzBnpBsvC
         A9rHG1yPa8ZOn3oGZbLw0oL7zAhn+OBYXzM+ccRHNTVVTI2R0NXT+xmRpWUMlneyCEGA
         X+a5fevVuuTAdQtSZy+k+HWIqr1pZ/eoGyOStjThIbzgmFtOuHBnwUVkh3wfoNI8EWpJ
         bMy2GcRsF/qUN6ZOwyh1Rd3V+S+7uOJqRudqvT+J3/Rnz97XYsgyBqAF3UXF+yYCiQ5D
         Rxe3mVlMpUXFqfQxR/7GFTTGu5+nqerA0LbSLBwaclNyrpgTv5fYfVDGfrpU/6i03Bxf
         P+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772130298; x=1772735098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3CnbC2LzEBnADf0H4jNpgSa/BKh2OZoa8tvpC3rGZ8=;
        b=UU4Iu1l1b73rm+2lMBBKfqaUsOEqzXVmXaoc38f1wMBcPxEq1tKWNVY80INCE4t11U
         7j7vXiUqls1txJGVd+gwr/I6qpdKM6ayKpKoroFgQCXFv0vttbo7v2Igh8ZM1ySqITCl
         TETgv6z1vhljpsk/CBv+q4VuzS5UbkI9agyN0HeE3uYq8uRdcaJsk1CAHCR50OVnbE83
         KpTW52c1uokPP0DvZxouI8K8jl1Kq8LjOoGaIqrtGotkPc9z/yobZbIPlpOD9LgXoBso
         n7HOcx7Jp3ZL24lwqHezEMggFaIBAIYAmzVnxE6kg8LEsLMcM0F8J0QBWE15P9d8Ce5/
         dxqA==
X-Forwarded-Encrypted: i=1; AJvYcCVXHrT3omO/t2bukRKyLcWvW+bFB3C9ojRYm6ZtEkIW7h/3jKrUZF845+007X7yz6Q1g6Ub979xPvNr@vger.kernel.org
X-Gm-Message-State: AOJu0YwcQl7HqK4QVawAdLlWF8UyTtOBfQK5tS4zDN9I44iRJJ9e8IUn
	EH4RlpExkEkuoTLEjGAsZzQCM9KGX/1JLSkAbJJI9rMrmoyDtJyMw/cjhTb8x6IJaGuxltcfXnj
	PJrRVXA==
X-Received: from plau11.prod.google.com ([2002:a17:903:304b:b0:2aa:e682:e951])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e849:b0:2a7:d5c0:c659
 with SMTP id d9443c01a7336-2ae0305efc8mr36873085ad.5.1772130297522; Thu, 26
 Feb 2026 10:24:57 -0800 (PST)
Date: Thu, 26 Feb 2026 10:24:55 -0800
In-Reply-To: <e3cdcbfa-525d-4e0d-885a-8f7d69a7ee3d@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260202074557.16544-1-lance.yang@linux.dev> <20260202074557.16544-4-lance.yang@linux.dev>
 <aZ9Xcgxa0_ouGr31@google.com> <e3cdcbfa-525d-4e0d-885a-8f7d69a7ee3d@linux.dev>
Message-ID: <aaCP95l-m8ISXF78@google.com>
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

On Thu, Feb 26, 2026, Lance Yang wrote:
> On 2026/2/26 04:11, Sean Christopherson wrote:
> > On Mon, Feb 02, 2026, Lance Yang wrote:
> > > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > > index 37dc8465e0f5..6a5e47ee4eb6 100644
> > > --- a/arch/x86/kernel/kvm.c
> > > +++ b/arch/x86/kernel/kvm.c
> > > @@ -856,6 +856,12 @@ static void __init kvm_guest_init(void)
> > >   #ifdef CONFIG_SMP
> > >   	if (pv_tlb_flush_supported()) {
> > >   		pv_ops.mmu.flush_tlb_multi = kvm_flush_tlb_multi;
> > > +		/*
> > > +		 * KVM's flush implementation calls native_flush_tlb_multi(),
> > > +		 * which sends real IPIs when INVLPGB is not available.
> > 
> > Not on all (virtual) CPUs.  The entire point of KVM's PV TLB flush is to elide
> > the IPIs.  If a vCPU was scheduled out by the host, the guest sets a flag and
> > relies on the host to flush the TLB on behalf of the guest prior to the next
> > VM-Enter.
> 
> Ah, I see. Thanks for the correction!
> 
> KVM only sends IPIs to running vCPUs; preempted ones are left out of the mask
> and flushed on VM-Enter. So the old comment was wrong ...
> 
> IIUC, we still set the flag to true because only running vCPUs can be in a
> software/lockless walk, and they all get the IPI, so the flush is enough.
> 
> Does that match what you had in mind?

No, because from the guest kernel's perspective, the vCPU is running.  The kernel
can't make any assumptions about what code the vCPU was executing when the vCPU
was preempted by the host scheduler, i.e. it's entirely possible the vCPU is in
a software/lockless walk.
