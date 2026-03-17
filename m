Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B63F3E9F86
	for <linux-arch@vger.kernel.org>; Tue, 17 Mar 2026 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759762; cv=none; b=bFialeyW4tZyOEJ7mja7nVobGzElkWMVrlPxOGuiop558j18Nz7bMnLA5lwgEfFlpz6YBGEuS2/PeY61I5/SyAnLrybV/IvwEOAEuV1j2kaVO2QC4Yis1/rSewYrs9iJGsEzGBAHluLppub22sAl9qIFV0el4oqao9k450xDKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759762; c=relaxed/simple;
	bh=BzReSlLvo4KvF8uHbrb5ShuLMsGHQVOqlQzQP18eBzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePH7VDaON401axuva6y1sTV02Rtd7n594Xjbz1Q1kYj2nDTI1x8APZ6///dcFAGzoFS2Kkld1G+oiTRvqIPbmEUdZBhAqARrHGc2JvHyEAax8oxXVo/u++u3HPTI4v8NMgVXrPI/qp/V0UTKlfPv9UrdTv8/R1NLMTkdiBnWOos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOPEMhDg; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOPEMhDg"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82a07738118so3398378b3a.0
        for <linux-arch@vger.kernel.org>; Tue, 17 Mar 2026 08:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773759761; x=1774364561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8j8MmhnWMM0yJqxgTZztIrkl7u2FL2UIzyJZ82awCT4=;
        b=QOPEMhDghL72Y9srHW15zBsG8Trwk4iRPUWqHYu0fOjUrcQqhyhyGI8qUHeDtUUjoM
         oQTFidZkujcVD3g9GNf4GwYCy0DVrswXjL/KCyIxvwwjruJ6rgGhuPfeK8vx/Nyt5xU7
         eyVmYaLTodoYCCC7AX+FZrywvRmSGIZ6I8tl3gW6LbPG1pWutf/64vz3kHZVlG+AbT5M
         ZzmNXqpm2E95JU0UtwpwSkj/YXcTbPsxz6Zoyc2vfcL/rbNQpaltpNB2nO0QXm4Lq8Db
         d9/6e2gSKnrkq6kmR11W72nSaFpMuum2XCncExcgURlM6ubXpCjcRLjgP5QgfP/vHdlw
         J+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773759761; x=1774364561;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8j8MmhnWMM0yJqxgTZztIrkl7u2FL2UIzyJZ82awCT4=;
        b=TLCptNJDrv3Sy6AzKEHj8LVeYTwNyt/J2qWwGV0DnlOGt9qQuKlmUjYyGnIZzac36o
         dqyGw00ZhGZ54828+i/rMCd1om86rdw9sldXN36kCfoU6/1czrghYSVqVgK2CMWXEGqt
         8Lu99bxPwGK4/Qy51m+kLtiZWelEQfbUuTW9uLY4gBVZCQyzalMpCtaIlAzd6CYfZnj7
         BltNZ+dRicpFRJa7eFgANXtQSZ+KXQAcU4LjedLYJn6kMtUBeTWX7vuKTuTZlz+3DQd0
         3lmw1LRCsH9ZmlvuO23VQyEnpdzgJxw5blkUocApp6dVu6YzmaKcslbZiQFBzBbVo3ZZ
         5hlw==
X-Forwarded-Encrypted: i=1; AJvYcCWhWvfGvpWTBlEtksTnsJb7+Qp7UM92h8xwL8vA8XJdpHhvGejmAfdF2cYKjI/hrFYCXy0jFUcGLrbf@vger.kernel.org
X-Gm-Message-State: AOJu0YxlDw4g9MVg1o+u3aYZIDyrs8iALLC4mFBG3bFKGDBC1Akb01b3
	f9kql6ZS1k3AMqtmfx4Ipk0sY4j1RNAl98KPSoZ4jjnbUBXK8abFY64N
X-Gm-Gg: ATEYQzzgd8ASnwEhCKitkuv2PKWA3dL6bZnBkCWa7d33lKizqfXuDsmmFi5U5FLIduk
	MPocRpBBmxaUGJG6GFq1BqmXJhpDszYyoGkZ8AZeKOrfOfP9ZVR0KvPr3rA/YvC1Be+qvnecmQn
	y2KUs0eLzdrohtEX9YTxu/mwfvz1vxsztBUthHSQld/FvHCpU1s6+kEnlPMjpYnfNORInr9NeGi
	Paej4i7aPx58KyG0afhyXxCGQ5yvq/nwFTYhhFg3ywhzoObwtyt42YZnUZB9JwjHTaosgVqjN+O
	UP85jYH3ppd8AKpkpgA/CZpi8VCoXP3k43GR+u5j/mQQxEAWFrlkJllQ6jkeD0IH94efrrTZAeZ
	QpUHHqoNTrnGz2ahMbSNM+H/R6dMHGMJnr1AYkWPjjQ8QdHl8Vf/e3hu3frh88wzj4Cz324bvhZ
	p8zAKSWamh79eo1yW00LUuQt5Z1Bwnqlr2gOV4Y1G7vJAZwY5nilHRfwVk6ZUTS/+EMNqqQvPq
X-Received: by 2002:a05:6a00:1988:b0:81e:d18a:489d with SMTP id d2e1a72fcca58-82a198b9f64mr13669770b3a.42.1773759760467;
        Tue, 17 Mar 2026 08:02:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0734039asm20098450b3a.41.2026.03.17.08.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 08:02:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9cdb6e1b-3f9e-4a5f-b1ce-a88f7c6742b3@roeck-us.net>
Date: Tue, 17 Mar 2026 08:02:35 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] kunit: Add support for suppressing warning
 backtraces
To: Peter Zijlstra <peterz@infradead.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Albert Esteve <aesteve@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>,
 Rae Moar <raemoar63@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, Alessandro Carminati <acarmina@redhat.com>,
 Kees Cook <kees@kernel.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Simona Vetter <simona.vetter@ffwll.ch>
References: <20260317-kunit_add_support-v6-0-dd22aeb3fe5d@redhat.com>
 <69f4eb09-efbd-4bd1-81b8-963b78e1a3a3@kernel.org>
 <20260317113025.GG2872@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260317113025.GG2872@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/26 04:30, Peter Zijlstra wrote:
> On Tue, Mar 17, 2026 at 12:20:26PM +0100, Vlastimil Babka (SUSE) wrote:
>>> For this iteration, the `__report_bug()` centralized approach was
>>> revisited after the discussion in the previous version [1].
>>
>> Discussion with PeterZ, who is not CC'd here? (did it now for my reply).
>>
>>> However, again this approach did not work because:
>>> - Some warning output is generated directly in the macros before calling
>>>    the centralized functions (e.g., `__warn_printk()` in `__WARN_printf()`)
>>> - Functions in the warning path like `warn_slowpath_fmt()` are marked
>>>    `__always_inline`, making it difficult to intercept early enough
>>> - So, by the time `__report_bug()` is called, output has already been written
>>>    to the console, making suppression ineffective
>>>
>>> Current Proposal: Check Directly in the `WARN()` Macros.
>>> This avoids the need for function symbol resolution or ELF section
>>> modification.
>>> Suppression is implemented directly in the `WARN*()` macros.
>>
>> So does that bloat every warn/bug site (as Peter objected to) or not?
>> And is it compatible with x86? I see you modify include/asm-generic/bug.h
>> but x86 has its own version of e.g. __WARN_printf ?
> 
> Yeah, they done it all wrong again :-(
> 
> This should be pushed inside __report_bug() through __WARN_printf with a
> new BUGFLAG thing.
> 

That would require another set of WARN macros, and after (or if) accepted
negotiations with each of the owners of the WARNing code to use the new
macros. Trying to do this would just trigger another set of objections.

Given that, but for other reasons,

> So NAK from me on this -- again!

I agree.

Guenter

