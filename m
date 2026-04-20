Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF6534A79E;
	Mon, 20 Apr 2026 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776723180; cv=none; b=MdOjMhZNOAKvfS+w22kv81Dkg4FVsLYy5OF0ZQ+ImysVfWMdoTB2ZIyfqM49nUJtg3A7qcw9/9Aqcx9HC+TJm9V3Tk779KgjH0sqIhR875tnlkuLMsxvBqAkddo+/Y8SSx6EHR0u2l5i5bG7x4wyHklho35q34UDMVAMdlV3GTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776723180; c=relaxed/simple;
	bh=ePnXR9oVgHfNaZl1q2pbWUGaIpQt6S7zzmVozt9afiE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U5qP5AaBKviqArhzn5cahezqCrz8MqpUXH4kTadBtdMN1nq3lvk/OL3Dvj31xSgRGltRbP1gzkauyK7y1Tm0ZFpYLqFUaWsdNLJyFlpY4Vu0q2AVv7cTA9hDYz8bAkmv5YqA/BKu+4EF4SSIa+TKq6G9o6/Z03gDbEXIZV4LFWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=HiX3ActY; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="HiX3ActY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1776723173;
	bh=ePnXR9oVgHfNaZl1q2pbWUGaIpQt6S7zzmVozt9afiE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=HiX3ActYmkJwOFo8O7Eswn5o9sPaOUzzLwpQHP3mEAOdooKWeldoE/th7uradOUzW
	 YsjhgyZFTiCxnyIHKkglDMlhQi6pwwYkCUHcaAFWVr+kpR8uA7BFvFzwr81RJ9K0d9
	 kWMBbhyfOaPvWJjXKNvuUF8Wrcrl6GczygLH0Q8w=
Received: by gentwo.org (Postfix, from userid 1003)
	id AC558402B1; Mon, 20 Apr 2026 15:12:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id AB0D74010E;
	Mon, 20 Apr 2026 15:12:53 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:12:53 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: "Okanovic, Haris" <harisokn@amazon.com>
cc: "ankur.a.arora@oracle.com" <ankur.a.arora@oracle.com>, 
    "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, 
    "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>, 
    "david.laight.linux@gmail.com" <david.laight.linux@gmail.com>, 
    "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, 
    "memxor@gmail.com" <memxor@gmail.com>, 
    "ashok.bhat@arm.com" <ashok.bhat@arm.com>, 
    "zhenglifeng1@huawei.com" <zhenglifeng1@huawei.com>, 
    "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, 
    "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
    "ast@kernel.org" <ast@kernel.org>, 
    "rdunlap@infradead.org" <rdunlap@infradead.org>, 
    "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, 
    "arnd@arndb.de" <arnd@arndb.de>, 
    "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
    "will@kernel.org" <will@kernel.org>, 
    "mark.rutland@arm.com" <mark.rutland@arm.com>, 
    "peterz@infradead.org" <peterz@infradead.org>, 
    "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
    "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
    "rafael@kernel.org" <rafael@kernel.org>, 
    "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v11 12/14] cpuidle/poll_state: Wait for need-resched via
 tif_need_resched_relaxed_wait()
In-Reply-To: <a374b23f8b03f850a874d46bc78411fb99483ca2.camel@amazon.com>
Message-ID: <02b88c74-4e7c-4f70-c49a-3e429b0e4abb@gentwo.org>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>  <20260408122538.3610871-13-ankur.a.arora@oracle.com> <a374b23f8b03f850a874d46bc78411fb99483ca2.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 Apr 2026, Okanovic, Haris wrote:

> I hope this series can merge soon. It's been stuck in review for more
> than 2 years.

3 years I believe

Lets move this forward.

