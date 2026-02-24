Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A802248A0
	for <linux-arch@vger.kernel.org>; Tue, 24 Feb 2026 02:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771901880; cv=none; b=pEek48l2L2poRgwid8Kxi6dWgh56hAQT8/G2rKmrLUpVvrx9jHYYnRvisEO2TTPcieFP5fZMMxyy/cuUiMtQby1QzvAP8MRjJeet86qm0TGPC+fpvGx7VLrRmCngtTFB70pgAUVM1nlD+Z8hYdXqM2Ke+kPMvheCNQNCyFMveNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771901880; c=relaxed/simple;
	bh=ZOp7LoaqVLhFZlwsbVNcryx4xvkOF+HR4q8756LrODk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmdDyDkDSHqeMbAmBW9bETdNUNvZhSI9aQ72YGHDTAC1q6V/syhWz90LDtfnDBkPa+nt4fr5JDJbNlVOODdc3Sy0HMvOeBvDnTdk3ls2b2J/M7p4RfYPp6ywgyfUWnWao4b4npQLhITkBNWJNkjDam8HW+TfH4WqQRkFbx81GFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CleIKeVQ; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CleIKeVQ"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-65807298140so7484441a12.2
        for <linux-arch@vger.kernel.org>; Mon, 23 Feb 2026 18:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771901877; x=1772506677; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLzgA1VpSKBM/CA/w+qS/GgqnqDkMavIXnIRIWRQ7uA=;
        b=CleIKeVQ9JdTfxZk4TXBTov9OGveqWYnsmD3+4owuO7YWwRdSnv/VyHjtzER7ujmNQ
         RX7I8jRKxQ9YikIrWS02ZIQjZKorkwnJVlG+2pGAecdvbaqbxmNRjVVHjxCq/VIQWLrQ
         HZJIOfg2dL++nNx8hAUDgB/tmNLJ6m3stHkKoiX0FsnhUynVzCwC0r+aK6i0FXWijBze
         n5UhHSt/xCb/Z98BOtRVOeg1KwNy1X1oycYTKQN6br52b3Fhsm3pBCEi3rzNGwc/gZ5t
         EoncyqVd8xLnCg1dHy5HaRAUQDQVboI+80ZJjuHVLQW/j4kjowQGkAhHnpp26rRp42F9
         k+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771901877; x=1772506677;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLzgA1VpSKBM/CA/w+qS/GgqnqDkMavIXnIRIWRQ7uA=;
        b=AXAKry0iUm5e9p4rPxn//0jIggeOkNNsqcpQ/L7IbaFRaOnGfMJaeQe9ZrbL4yMrsB
         pH+AQ6j3ZVrtCktCh+EnydZke/wy0SzkF5r0iPTvhcNMudU190gCSVq2qVwW+h4C1nnB
         lJ9OXztb3NCmfJy8Yg6orhJrMxQuQWTYkXcvqwCl00O1nIyowf1GbvV1MVQFhx1AuFo6
         phDIOGWcp74+GANTbICVWi4MaCVO4N2FSDECG+sov9LdCRZkMzPosEJnwRJwC8OPdB0f
         WbiYAXzOSYu7e+jouhV9LmWQ/rqGUWxYfjFuhRmifGVlIVAJxIXNbKqkeyWvvodrNxCy
         IBYw==
X-Forwarded-Encrypted: i=1; AJvYcCWNZ1NZobMOS+kkd8FCUEmRWbA/6Z3HPk5aRR2Jqhlhu3U4013qDnvQvTHMZMLmeMF3LgEAiJs2abPS@vger.kernel.org
X-Gm-Message-State: AOJu0YzcNUmlx7suapolFII0yKb6PIEVtECTNH5zxCYsWW2NzAF6u+2l
	JG6FxoMmWgInvHMImeU/VY0Jr9IwqWFFSn0F95mkbcoC6hzS5iCq7FMs
X-Gm-Gg: ATEYQzwTuY4aobhz7MfSXVdZX76uQbrDR26ruJv5arrYKNLqUL2zWq3+OVMvv3TXxf8
	B2jKAQyABNjtDLmXtGYv2Ojs7vZ8OCbNqLHCTucSaCR/LU1nDL4H3DGCuckRW3Bw1g+SXfnv7vN
	mimkKVCF9gmxgCc+D2mJdZ3PsEgJTH34WMgnLFmypDPc0lutzhIoZYpTSLaAe8fO/kvxemZPqMq
	6bcCP59NGSPIuJPQGdq/khRsFQp+nDW1huXqjpXt2K8R8bcDl8sEOKstwkSJQ03DKjqOEJEuhHv
	n17imi3R0tmCsTaUTELNUdp0oi28LFRh7DgsJCtoDvkcuTHZhHe/qHa3Wo9R0tQkHv8EB/HkQcR
	8yjQYyBcEgSUSIfKdjW2k3/GILZpk7HPfZ8Em711AeCtN37hSqw9cDAK5j2Mm0xzTd1tNIsOkS3
	frmmnlHRwe+DiW/KIY0gsCMg==
X-Received: by 2002:a05:6402:40d1:b0:658:e665:766c with SMTP id 4fb4d7f45d1cf-65ea4ed18e0mr5724958a12.8.1771901876946;
        Mon, 23 Feb 2026 18:57:56 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eaba13871sm3195624a12.22.2026.02.23.18.57.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Feb 2026 18:57:55 -0800 (PST)
Date: Tue, 24 Feb 2026 02:57:54 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	"David Hildenbrand (Arm)" <david@kernel.org>, will@kernel.org,
	aneesh.kumar@kernel.org, peterz@infradead.org, npiggin@gmail.com
Subject: Re: [PATCH] mm/mmu_gather: define RCU version tlb_remove_table_one()
 in CONFIG_MMU_GATHER_RCU_TABLE_FREE
Message-ID: <20260224025754.z3g6sbq2huuk6fwo@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260222004512.839-1-richard.weiyang@gmail.com>
 <f44fac08-771f-4619-b8a4-6ea740df424f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f44fac08-771f-4619-b8a4-6ea740df424f@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Feb 24, 2026 at 10:09:18AM +0800, Qi Zheng wrote:
>Hi Wei,
>
>On 2/22/26 8:45 AM, Wei Yang wrote:
>> Before commit 718b13861d22 ("x86: mm: free page table pages by RCU
>> instead of semi RCU"), the page table pages will be freed by semi RCU,
>> that is:
>> 
>>    - batch table freeing: asynchronous free by RCU
>>    - single table freeing: IPI + synchronous free
>> 
>> This commit introduce a RCU version for single table freeing to support
>> PT_RECLAIM. While it is not necessary to limit the RCU version only in
>> CONFIG_PT_RECLAIM. It is reasonable to asynchronous free single table by
>> RCU if CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>> 
>> This patch moves the definition of single table freeing in
>> CONFIG_MMU_GATHER_RCU_TABLE_FREE, so we have both RCU version
>> batch/single table freeing if CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>
>Thank you for doing this, but we can't do it right now.
>
>See the latest version: https://github.com/torvalds/linux/commit/9c8c02df3f8742f6db927e787ab971fd0b5ac08a,
>when the
>HAVE_ARCH_TLB_REMOVE_TABLE is selected, the pt_rcu_head member
>cannot be used.
>

Thanks for point out. Don't notice the latest change.

Andrew,

Sorry for the bothering. Please drop this one.

-- 
Wei Yang
Help you, Help me
