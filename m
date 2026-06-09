Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526962EEE99;
	Tue,  9 Jun 2026 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781004200; cv=none; b=fvScJjXnTYAthj4OD5NkBqyYBcGAfNY7IttXY2gzEJjxsVSe7J4iz8NWs1CxeRUggiyPW6QNUIqyDma7BU+xrJ1Jjx5rL+vSK+CGAeJ4ThwwmGZOkynQJwUBMUPCLyvlkU4DSsszh//MMWw/iB34RZSbRHSlJL2+HZMbCELE4VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781004200; c=relaxed/simple;
	bh=npuz46d4QNvDA7287/pTEq2o529ZaLuUT9R8U7Jnb+g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fJB+HfxelyArxUgeGtoc0iHm1g+aCLA4+7Pfl50NnA5kaK0QQo+ynlFDQeJZ7IJa2G9CQwDU71PyS/I5EyddYr/wSGZA0vP8jiiFsc7qZ+25ergpLQDfSUjUPa4gLKFhtIw6DnSBWotwzT57GP8gsJn5P4gyeaW+FJrVXxN4Ahg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jjKXS9Qj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JYqoDNqO; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jjKXS9Qj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JYqoDNqO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 01C221D000E0;
	Tue,  9 Jun 2026 07:23:16 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Tue, 09 Jun 2026 07:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781004196;
	 x=1781090596; bh=1mQ7A3k2eL3dmBv1RGEa6g48o965CaMvRnltTJSLW/4=; b=
	jjKXS9QjWObACljUXx+p0sJWConxBHYd7f87JZAgG0rle6EfJ58n9Nn8Fk/ugr2/
	RSP3Gf4sgMLZbuVlW5xM7nwcfG9ozHSOn0NIjHX9MTVXcisQL0S0rF6FaDRBTc4O
	69RIPp15mwvMZvPCVO7r35DjFk3JUfDoncqOdDrmUDtfc64PstmuDUO3PF7X50D9
	Ya883xUyOWt8eJ6LMf7CRlMJtRH7zr37oRlZmGgMS4nWeHtrIio2WqhOV3o7eKHs
	qRzjcPzv9FvYrgpCrr7oqEBxRrlzABM3BVvCgfaEvCV5ZpubJvhwvMn0laVSnDMJ
	V54D+g6I5Vk5SvjVmQ30zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781004196; x=
	1781090596; bh=1mQ7A3k2eL3dmBv1RGEa6g48o965CaMvRnltTJSLW/4=; b=J
	YqoDNqO5w/zB9C6lbs5mW6LgRFW8OqCTp+nvoibim7XSi+z7FQhiBIIzxC0keczd
	22BXfmTqpr+nP2v5hS3sbpL4hHrCCGaq5Aw8h8RrWMEEn/44IYehCH86gsmIMcHM
	0+6rFcW2pIQlEG6awJH968SQk1gqRdtosqnpJYQbJJ1dn+8Wq4ZkHccmCIK8Xzgg
	9jAYCwpWceyDv0HoUwmcLjVR+je02lRRFjX1MQxFFm/Bjj0ii3Fg8c8aWCNuzSEn
	ohhTnRnAau5p1IH3EEgU2LB9OGn+Q9BzqSOPIvZurh1P/ezSVkUkHehQj5pGFPzS
	ww+JNr1LaGPpymwWYkWMQ==
X-ME-Sender: <xms:pPcnagozGa7isxBoFCmmNeID6YUFUE1WvG7LGxebcogj63xG9UPBTQ>
    <xme:pPcnaheLXFmeDA5WUk5oW9fG8OGbHdZB0o_aNVFgih3ZyFddA8AXpMA0jTeh18nLj
    jN4N2buKy0IC96EFlUI5pks73JzbF9ca9LK5sH2O_Vjg1ADAjx8JCU>
X-ME-Proxy-Cause: dmFkZTE1RtXEoLbmq5P7Kd6uocq9oWWVmqdvkT5Blg9hIP7htVA1vfmpIIsI0ojZEFC+1X
    hZqtBQLwwUvx5fUN0WAZxvFY8iHyWrlR6E68kk7Oh/e5KhsozDaW1uC12PbZbAhEftqm+r
    0HSYj9jINg2wkP7rhNOvo7Oh6aBjqU/2HPbQ1oUwIAsrQMLerq2aGgT8YfX/4ZlpNyxHWM
    hvYrkPHMjL02PhtNhE3qksZcNISogyiOakZl9Vn80eKl/DDQuyndeARWn8BM6YqurqVpPg
    KfC3jOqFayOCApHWazPAxwqF3gDhXBOZ4SoXLXHWCOjrfeQcEcOFmF1H1u04B7USAKH9Wf
    sBwJW5Qgnqnsawdw4YoCpGX95vaX8ZjMtdXiDFiW7sz8m0VovOXVPe13j8S2V0K3Sg2kE0
    rJpAwOYGcC50Vvpp3CAXPWFSnNttVCLKa3iP2lU2MnliXlK+ynrZ4+09RDnfb6dE13WRAh
    DZ1f//Hlg/C37CJUmrAfYdX1YVzENQuGu0sy37eSpRqfP1b4MEItabR60xPFOkSeime9US
    i2MfS0K7vtOy0QEQeBaWyXvRzprMLbV1PnFo0gJOMcMGJo2EbFTMrv2DG88zfm0MlGGMjd
    LvTEOSzKr6JbQ41czgKaCxenmrSk3HcC82N9yMj/jhNi3JA+psX/JrSULx3w
X-ME-Proxy: <xmx:pPcnas6Ma7Am7VBO6gGG6GAaevTRaao5SeDMszNxDrf92rMJ7NGYMw>
    <xmx:pPcnaqSHFHGwrCAAzZGnepHg01NmFoyHWV-Mh2ylDp1ChfaNdQl5DQ>
    <xmx:pPcnav6phh3gqRQ0OcCQgHgAhEMttgrpTsYSS6tUs-fI0xuUoCa63w>
    <xmx:pPcnavSpbRAcTXYSa2FhA69BxeqxzNyyVfOcf8DangjyBkAtB7Xphg>
    <xmx:pPcnakf8AqOXu0VJGGVO3T-V4R_eooMEqPFpVmjeeHPc3zu7dDly2lIM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 66B24182007E; Tue,  9 Jun 2026 07:23:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANX22ru2X65k
Date: Tue, 09 Jun 2026 13:22:35 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Gabriele Monaco" <gmonaco@redhat.com>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Will Deacon" <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Waiman Long" <longman@redhat.com>
Message-Id: <d40ba64d-78d9-45f5-99b9-4bfb1fc27f6c@app.fastmail.com>
In-Reply-To: <20260609094941.56122-1-gmonaco@redhat.com>
References: <20260609094941.56122-1-gmonaco@redhat.com>
Subject: Re: [PATCH] rqspinlock: Fix order in raw_res_spin_(un)lock_irq to allow
 schedule
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 9, 2026, at 11:49, Gabriele Monaco wrote:
> raw_res_spin_unlock_irqrestore() calls raw_res_spin_unlock() and then
> restores interrupts, this means preemption is enabled when interrupts
> are still disabled (as part of raw_res_spin_unlock()) so this cannot
> trigger an actual preemption.
> This is inconsistent with other spinlock implementations
> (raw_spin_unlock_irqrestore() and bpf_res_spin_unlock_irqrestore()
> itself).
>
> Adjust the macro to ensure interrupts are enabled before enabling
> preemption, allowing to schedule at that point. Make the same
> modification in the error path of raw_res_spin_lock_irqsave().
>
> Fixes: 101acd2e78b1 ("rqspinlock: Add macros for rqspinlock usage")

Should this be Cc:stable@vger.kernel.org to get backported?

Did you see this cause measurable performance problems,
or did you find it through inspection?

> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic

This should probably get merged through the BPF tree, but I've
added the kernel/locking maintainers to Cc as well, since I
feel it's more useful to have them look at it than me.

Maybe it would be good to update (as a separate patch) the
MAINTAINERS file so the locking subsystem also includes the
headers currently missing:

arch/*/include/asm/*spinlock*.h
arch/*/include/asm/*rwlock*.h
include/asm-generic/*spinlock*.h
include/asm-generic/*rwlock*.h

       Arnd

(full patch quoted below)

> ---
>  include/asm-generic/rqspinlock.h | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/include/asm-generic/rqspinlock.h 
> b/include/asm-generic/rqspinlock.h
> index 151d267a49..4d46643f46 100644
> --- a/include/asm-generic/rqspinlock.h
> +++ b/include/asm-generic/rqspinlock.h
> @@ -243,12 +243,20 @@ static __always_inline void 
> res_spin_unlock(rqspinlock_t *lock)
>  	({                                        \
>  		int __ret;                        \
>  		local_irq_save(flags);            \
> -		__ret = raw_res_spin_lock(lock);  \
> -		if (__ret)                        \
> +		preempt_disable();                \
> +		__ret = res_spin_lock(lock);      \
> +		if (__ret) {                      \
>  			local_irq_restore(flags); \
> +			preempt_enable();         \
> +		}                                 \
>  		__ret;                            \
>  	})
> 
> -#define raw_res_spin_unlock_irqrestore(lock, flags) ({ 
> raw_res_spin_unlock(lock); local_irq_restore(flags); })
> +#define raw_res_spin_unlock_irqrestore(lock, flags) \
> +	({                                          \
> +		res_spin_unlock(lock);              \
> +		local_irq_restore(flags);           \
> +		preempt_enable();                   \
> +	})
> 
>  #endif /* __ASM_GENERIC_RQSPINLOCK_H */
>
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
> -- 
> 2.54.0
