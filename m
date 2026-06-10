Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB1326299
	for <linux-arch@vger.kernel.org>; Wed, 10 Jun 2026 00:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049984; cv=none; b=keHhK5VLr7hR7oZ7IHLrAbLpf2edTtl+qfN0jY+jF88V9X2SbCMrD2wGfp+wUvK4/v6aaR3B0jaBECnqbnqW0vMoP8nfxzaGLEcl3io36u1DXEOspYDz8CUn+cV7wIOdXfASd5cHgVqra316LDM1i3Me+XIVmYy1svTqRwGPjB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049984; c=relaxed/simple;
	bh=dM03eu628RE3wROC0+gCC2QtCyeGg2bw1zSpRZeZxVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abGstdH451xXgzkJMHTVWrMr8WOT3t2ir7HHhfOuln6D0xygsUqtZNMBabwc4w58ps97vNqYFx9iR9ENQsavTGcORfh6otVw9azL6nO3BBUiDo7Z9cTEd/O+fGrSapQ8gljiDZuKX0Z8rkZYz0Drfbz39Mj8T1mvX36bJ1YdKnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VwDCicfV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwDCicfV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781049981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+BdsIiubxTigLolxNCr0T6sAxrzBceT6zqzj07dt1M=;
	b=VwDCicfVP5wy0jNNOvQKAsAMb/yF22mbD3slXG17EzJxkW7d6vvOmrDIrMfD9INzJb0YZV
	JT6tjgN7yj5+vCx/bMxrBfFuGFmzsvdhRXhUO8Ry73EEgje96vuyIkDgDukrurebODpEL4
	Ee4nxlT+SWdxnXyjP2uAdYdWWcOHXrE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-21fD-jIrMvCit92WjLgOpg-1; Tue,
 09 Jun 2026 20:06:20 -0400
X-MC-Unique: 21fD-jIrMvCit92WjLgOpg-1
X-Mimecast-MFC-AGG-ID: 21fD-jIrMvCit92WjLgOpg_1781049978
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 422B71955EA9;
	Wed, 10 Jun 2026 00:06:17 +0000 (UTC)
Received: from [10.22.65.187] (unknown [10.22.65.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 32153180067E;
	Wed, 10 Jun 2026 00:06:12 +0000 (UTC)
Message-ID: <9a9f3716-8a93-44c6-a913-04e893d06645@redhat.com>
Date: Tue, 9 Jun 2026 20:06:12 -0400
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rqspinlock: Fix order in raw_res_spin_(un)lock_irq to
 allow schedule
To: Arnd Bergmann <arnd@arndb.de>, Gabriele Monaco <gmonaco@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>
References: <20260609094941.56122-1-gmonaco@redhat.com>
 <d40ba64d-78d9-45f5-99b9-4bfb1fc27f6c@app.fastmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <d40ba64d-78d9-45f5-99b9-4bfb1fc27f6c@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 6/9/26 7:22 AM, Arnd Bergmann wrote:
> On Tue, Jun 9, 2026, at 11:49, Gabriele Monaco wrote:
>> raw_res_spin_unlock_irqrestore() calls raw_res_spin_unlock() and then
>> restores interrupts, this means preemption is enabled when interrupts
>> are still disabled (as part of raw_res_spin_unlock()) so this cannot
>> trigger an actual preemption.
>> This is inconsistent with other spinlock implementations
>> (raw_spin_unlock_irqrestore() and bpf_res_spin_unlock_irqrestore()
>> itself).
>>
>> Adjust the macro to ensure interrupts are enabled before enabling
>> preemption, allowing to schedule at that point. Make the same
>> modification in the error path of raw_res_spin_lock_irqsave().
>>
>> Fixes: 101acd2e78b1 ("rqspinlock: Add macros for rqspinlock usage")
> Should this be Cc:stable@vger.kernel.org to get backported?
>
> Did you see this cause measurable performance problems,
> or did you find it through inspection?
>
>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic
>
> This should probably get merged through the BPF tree, but I've
> added the kernel/locking maintainers to Cc as well, since I
> feel it's more useful to have them look at it than me.
>
> Maybe it would be good to update (as a separate patch) the
> MAINTAINERS file so the locking subsystem also includes the
> headers currently missing:
>
> arch/*/include/asm/*spinlock*.h
> arch/*/include/asm/*rwlock*.h
> include/asm-generic/*spinlock*.h
> include/asm-generic/*rwlock*.h
>
>         Arnd
>
> (full patch quoted below)
>
>> ---
>>   include/asm-generic/rqspinlock.h | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/asm-generic/rqspinlock.h
>> b/include/asm-generic/rqspinlock.h
>> index 151d267a49..4d46643f46 100644
>> --- a/include/asm-generic/rqspinlock.h
>> +++ b/include/asm-generic/rqspinlock.h
>> @@ -243,12 +243,20 @@ static __always_inline void
>> res_spin_unlock(rqspinlock_t *lock)
>>   	({                                        \
>>   		int __ret;                        \
>>   		local_irq_save(flags);            \
>> -		__ret = raw_res_spin_lock(lock);  \
>> -		if (__ret)                        \
>> +		preempt_disable();                \
>> +		__ret = res_spin_lock(lock);      \
>> +		if (__ret) {                      \
>>   			local_irq_restore(flags); \
>> +			preempt_enable();         \
>> +		}                                 \
>>   		__ret;                            \
>>   	})
>>
>> -#define raw_res_spin_unlock_irqrestore(lock, flags) ({
>> raw_res_spin_unlock(lock); local_irq_restore(flags); })
>> +#define raw_res_spin_unlock_irqrestore(lock, flags) \
>> +	({                                          \
>> +		res_spin_unlock(lock);              \
>> +		local_irq_restore(flags);           \
>> +		preempt_enable();                   \
>> +	})
>>
>>   #endif /* __ASM_GENERIC_RQSPINLOCK_H */
>>
>> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
>> -- 
>> 2.54.0

Disabling interrupt will also disable preemption. However, the possible 
side effect of scheduler preemption when preemption is enabled will make 
these res_spin_lock APIs behave more like regular spinlock. So

Acked-by: Waiman Long <longman@redhat.com>

