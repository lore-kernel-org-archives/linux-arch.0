Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AD93242CA
	for <linux-arch@vger.kernel.org>; Fri,  3 Jul 2026 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102579; cv=none; b=JNQNOnCXNxu5qJKfmAcL+L6flpro1+9jQDQrpMj/arfQ+hXWlJrFQRW0KZxelWxIpjwIeil/T9jSQ9RO6eC9/YqkHHl7mod4aI1t8aAq/9WqR5yuYyb6HGIJJZCE/Fcd4WUjTqGdxZxTv0JLuZOsSmJIGXMz+NpfFxakzsgEqbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102579; c=relaxed/simple;
	bh=tHaRnBkHGDwxe27vTn4OgEjwyrOSNdq/sa3ntNRDUrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QraDh+Jj2oiOnggE/L4neEPPyIvK/zTqfqVG9n+ygAaJwYtICYI/LCzMPmHE72tkK+Ow7dxwxOND520nGW9XQLFwytNOidXWDYwo+O3y9CAuq5wi8HM5+91o95JIBS07KI3qWAVIUvWB6M8A5tAwmbUZaOvErrvSdicnIHxdLBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHwECOXa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHwECOXa"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4728c12ba97so517021f8f.0
        for <linux-arch@vger.kernel.org>; Fri, 03 Jul 2026 11:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783102574; x=1783707374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vsSwgqydI0TUTd1LdM/qdllikjjCJsaJszfdOZPreSE=;
        b=WHwECOXacfOlaFdVXkN4YzhO4D6o4cjLpP9QdnIb10K0/XQqjQRQrcAOmrou58QHlj
         rFYMA+KOGIiJunbI3hoJTotQ2gu4haGYpfWRqvSXprOYB97UBOSZj/S5eJLNgooT8ze1
         8h4r9G7Op/XhAjuoeaxOog8U2MPjcnzkzyaUaVjsF1w4/eCyaOAhNh7C2k6XtY+i7vB0
         txYIe1r4KDL6POc+hVQKh54v/F6L7c6RMaPCLV2ZeKjRW6JbgIaQbUlBAzB+PxQVF3lP
         YrVMQbCm8rYFnh+CYYc2UFWSVpqpNOGeLHSaIlBdw8YM4ovnxp93oBkfXtcgXvFM/Q21
         YvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783102574; x=1783707374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsSwgqydI0TUTd1LdM/qdllikjjCJsaJszfdOZPreSE=;
        b=cEFHgZ3M1XdpWEG60bRkTYxuXJ54bu40AOViJ8c89AIy0xpcccU/eUe123S2vAuc/k
         RyW4YX2M4fBwOWqns0DB2YA5/ZXGGMZgz1TSb5YQdo6S4aH61Tr3lmHzApMOqC47z7CK
         +Qn7yF3j+2xfzs3JBaOMxufCA0ivU6YL6lasAI8ysG8fo+cr9BkvA3rSJKh7rnRWQuU8
         x8OXidn6Atwo2Gj+4L/ZXjHE0O5zJkKSShFi8SbjVYc/26o1UKheHJJZ6byILYPxul4B
         ZXw8UkjIJrswIlvtiwaImHgE9A3PYZpxXLmkywkQqss4STxxwdgybx3gFmc+SRx27kjY
         WEFQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJRnU8AEEcRv+Zpuvei0axaFihdl5K14qLTN7h4e2Eaa3zQPgw1fJceddT0MXIPwDCMmoGrJvo9aOq@vger.kernel.org
X-Gm-Message-State: AOJu0YxEtURI+skToSpVCpOELM+oqjy4Ph26vyHEI93NinA6inzMi1t/
	HGEovT11bl1cwo6vgPfaTVGJAuasJRBm/SIjTT/9CrqyAPuQDa9UK1nE
X-Gm-Gg: AfdE7cn3z+Gqn00HdE//+WH3IRLuI/vGRrrS2OTYO+odSN3KHWD7KTqniJ7EP6gPBTx
	AN4oPzsILpC/QLVqybMKBrW7wF/PRCCJAcBNFi2jFZE2rwtdW/pFxUBfaOTpPonunUyAgAtpoFs
	tlGG7JO5m60CM3navsF7QREIE4JO2SjXKqSs0ZBvzjQWoat2cOIzWouHoO+wXlFMCHOD3URJMR8
	IbepiZ5CppgzfYt5s0uwxVMytTQo92X3/wN18ArOLYcgDyNVqjWPhntTZljYyzy8zWkG9KrJl4I
	LgjC/xpOrPuclVb6803AdKJV43gIFgvMGgiDEAkad4iHzZzlDDZW30bcmKXyfo/ehm14ZRGQH41
	sSVVGRiTtKIEO9wi74ARdYL3bWkmIZtKjnREKBo253w7BLoBZO3aYQVSoNSA2WPkA/nUQQhGTTZ
	8xgjkAqCH6VmyEtXkFhaaLv13qYVspytDqdbx4F2bbradZcRxD5O+nzXSgPdPE9i2g8SPxwrWGA
	nmGQCG2
X-Received: by 2002:adf:f3c8:0:b0:470:a7d8:75f5 with SMTP id ffacd0b85a97d-47aab77041emr390229f8f.42.1783102574577;
        Fri, 03 Jul 2026 11:16:14 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8f1sm1195806f8f.3.2026.07.03.11.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 11:16:13 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <92264294-afe8-4752-9f22-2b633373b288@gmail.com>
Date: Fri, 3 Jul 2026 19:16:12 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 14/15] barrier: add tests for
 smp_cond_load_*_timeout()
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
 harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
 xueshuai@linux.alibaba.com, rdunlap@infradead.org,
 david.laight.linux@gmail.com, broonie@kernel.org, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
 <20260702013334.140905-15-ankur.a.arora@oracle.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260702013334.140905-15-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ankur,

On 7/2/26 02:33, Ankur Arora wrote:
> +config BARRIER_TIMEOUT_TEST
> +	tristate "KUnit tests for smp_cond_load_relaxed_timeout()"
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Builds KUnit tests that validate wake-up and timeout handling paths
> +	  in smp_cond_load_relaxed_timeout().
> +
> +	  Say N if you are unsure.

Could you follow the kunit documentation for the kconfig entry:
Documentation/dev-tools/kunit/style.rst

Specifically, these two guidelines:
1. "be named CONFIG_<name>_KUNIT_TEST: where <name> is the name of the
test suite."
2. be visible only if CONFIG_KUNIT_ALL_TESTS is not enabled.

- Julian Braha
