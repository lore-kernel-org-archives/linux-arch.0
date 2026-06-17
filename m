Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37521E32D6
	for <linux-arch@vger.kernel.org>; Wed, 17 Jun 2026 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699998; cv=none; b=TcsiHM3+kd81G12dlOmdb/indQlukvBi/XWCJA7rPo3mYdUtWw5Rt7dGMTi96mDRs8YO7tmrBn6+2SjlRV98sVQL3gQX4UdqbZXoLhqXZjL/7V1SJeUlXOo+HjZbaU4bFc56mHrgz+s+knEjADQGgmpr3mff9dou7jAjiV/JWng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699998; c=relaxed/simple;
	bh=LQqeWLUXpCQ3xWzoSnndmXhM2WFPmN77ePTrKVSZm2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1NpGN0FTLr/xUgPb66bu8rSmdxDV0AhESLTx+4fF5JmlnYEFezI/g0Gsn5SkGfige8b06Wj2sMNCBcRXiZyx4T8Jxi/FPgjq2iGmxPLPnW4TxoX/G96uU2gvMhpImLQxZXJ4stdizkTGXD39QFbp8EmoKOYbTZCtz0XYmNWh90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gLnWJc3T; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gLnWJc3T"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b3637b90so45248555e9.3
        for <linux-arch@vger.kernel.org>; Wed, 17 Jun 2026 05:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781699995; x=1782304795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZi5bo8Cugwshp04KdhwM9Mfr4BTkMqYISdeW8xQXaI=;
        b=gLnWJc3T8g5mPH0ygz7/MKXwNq0sHTNISHAeXBM3sux0+KzF/+5k2Xip4oIBTnsx3y
         f/HbwTeE6dSxnCgdfRmx9u1XTNWc7GJx6kh/zQVMRbeYsYJO20cTpu+UBP7w2eypER5Q
         odDwRzIuwBFKbYaOBFtEZSHF3BtSEpm3UipvxXOvZNEieSx+ha5SXIfUaoMrGD/A7N+3
         BsStJODsCHhRGW9axRFQbrRv4o61l77DTHVYKtIXUqQANatvYejwz9iVHQLONtIblt3F
         Br/Bo9wXwhm4hv3Q+B7liAEZomGRP1vf+Iy1pO20aar5Q0a/cbLeJTXnRb68lD8h6ASJ
         G/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781699995; x=1782304795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZi5bo8Cugwshp04KdhwM9Mfr4BTkMqYISdeW8xQXaI=;
        b=A2zP200n3iN4FMSR0pyrV5lnQBMAmYtSmoHDEP6GQVVhDOL9a0MK/JLgBfrMjp6blJ
         9CeTGgqTRle1qNWEMAnId76rubTR1g+rg9PyNKNzlJ681bUKKtHRfdYUs8tVRB8ezXA+
         aXw8ZjRJ27RKBWyiAS3KiEYkoeT2q3YGp9Pua2ZimeAevkz5ZiJ55CabiZRi32SsUM89
         F6SOdbk7a1hqe9wlffrkA0mprICrwlki9JT+Uum3PhstORDq72OScwPvErcA3S/Hy7nq
         dPiGVQew15maHm0jopjeYQx7shkB/y9E6j8xaPUpvu7akx8kG0qV8Q8WhrUJ+NGCdo7f
         XNbA==
X-Forwarded-Encrypted: i=1; AFNElJ+j/n3EG5l7YQllw3GZQQvzEw9qi1NdqGbsdLNGxEpy9shUHKAH++lpCX6shHWi3+yKdmOP/k19TN/A@vger.kernel.org
X-Gm-Message-State: AOJu0YxClVwnUiT7empHQohzPqKcue1byoATyE8v71yhRVt35dG9/vLZ
	j4CeEk3TACbx5i2IjLqP9ep4tLkD1V8u//LO68qZF8nEvuBkyNHgPaMbKYov+oeHKBM=
X-Gm-Gg: Acq92OEnnEWvf4/NuhLsFPk8gPdsc9F3K0FrBpLpIV3I3N/vvgVfVUQVgAv2vcvTsB3
	Y73RzfKkxCQPpv13RlLQr4AiAVDpdspIzaYLyESwqj+qCNhSQGYTNvJxFnVFwd/2qqxKDU1WqTD
	pBcMxc/zx0iN2q6FUeZUsbHi4MbeFi2+/H1BSdBySmB83nd+dbzuA3qRKB6P40Wul7RoOTCxZtC
	4Orzt59O9eOrD2Hcya09RfwsMZS8SycHbgiUpt4EnGSx/0VC200OB81eXc1FrS/H1CKu/qljm5i
	Lrtd445kpfJDLNOVjPYQZSOKS91kwcrPThz8EA/7WsnEyhTgcARwXYqunkNNXTzH4HCPvAVfFSH
	KV4dfx5b/drV/GqTCf/QnOt4WMAlZ1OKHNe6M822WsOtJ1Wk4DD3rzjxpCDPadvFDiW8/T3B7pK
	p6N/ICxX/NTYqNeRnixigYBP0eQOJvuA==
X-Received: by 2002:a05:600c:e557:20b0:492:1e36:85dc with SMTP id 5b1f17b1804b1-492333e2b9dmr46704045e9.36.1781699995234;
        Wed, 17 Jun 2026 05:39:55 -0700 (PDT)
Received: from [10.0.2.3] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa891acsm161753865e9.9.2026.06.17.05.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 05:39:54 -0700 (PDT)
Message-ID: <79ace94f-31d3-4a5e-9a47-3fad69304fe5@suse.com>
Date: Wed, 17 Jun 2026 14:39:53 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] init/main: Expose built-in initcalls and blacklist status
 via debugfs
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: arnd@arndb.de, mcgrof@kernel.org, da.gomez@kernel.org,
 samitolvanen@google.com, neelx@suse.com, sean@ashe.io, chjohnst@mail.com,
 steve@abita.co, mproche@mail.com, nick.lane@mail.com,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260510061301.41341-1-atomlin@atomlin.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260510061301.41341-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/26 8:13 AM, Aaron Tomlin wrote:
> At present, identifying the correct function name to supply to the
> "initcall_blacklist=" kernel command-line parameter requires manual
> inspection of the source code or kernel symbol tables. Furthermore,
> administrators lack a reliable runtime mechanism to verify whether a
> specified built-in module has been successfully blacklisted.

My understanding is that initcall_blacklist is primarily a debugging
facility. This is documented in
Documentation/admin-guide/kernel-parameters.txt [1] and also outlined in
the initial commit 7b0b73d76651 ("init/main.c: add initcall_blacklist
kernel parameter") [2]. It is expected that to use it, one must inspect
the kernel source code.

If the goal is to allow specific built-in modules to be blacklisted,
I wonder whether extending module_blacklist to also cover built-in
modules might be a better option. Module names are more appropriate for
administrators to use, while initcall names should remain internal to
the kernel. Additionally, initcalls are typically "static" and therefore
are not guaranteed to have unique names + using module names avoids
a dependency on CONFIG_KALLSYMS=y.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt?h=v7.1#n2408
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7b0b73d76651e5f88c88b76efa18d719f832bf6f

-- 
Thanks,
Petr
