Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9CC3E8C64;
	Wed,  6 May 2026 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060541; cv=none; b=FleXKABvfrlT46vc0BxnUd+F8KJuDD4GX9cd/b13FK3B2szR9c80E/bD7RmgSKRpiz+aRavJQ24WPmtVJS/GlYwal7SGCOB+3H9M6HP2txpV+RsojX9AiKU5+jK9HGb6AKNmUv/BDGez5V20hrG/h1CepPd/84sen9pSnYFwtIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060541; c=relaxed/simple;
	bh=wxwOGGBU7axLHOdFPa8Se5eHpE8XygiR/3cms0LswXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=On9umHrHDIObUPpfQFdJg49mbR6I2BSxwGeYomhEr97TJDsfKGwmCWZeoj0uGsLThfRqk2deJCXuf0Di7VnN0KEHCdyR07MufcDrdExAheH+L0soba1UdGO9bfAebkqC3EvshuxkTJ/6Jeu4FdjaqxD2mQNx3RmtrEBqFGU0XaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=bo5kZWma; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=SdlOkqYg; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="bo5kZWma";
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="SdlOkqYg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1778060537;
	bh=wxwOGGBU7axLHOdFPa8Se5eHpE8XygiR/3cms0LswXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bo5kZWma7wLJmiAEj7YWIFalhBEAAbQB9XwAWSctF6OgN2ejjsVl/il7OiEdhd3fk
	 tAamZRs1JxEB+wCzLxEwuOMMMsF+BtM0B7zyhTx5w5ybKxKxFiMDad3dLrpNBmyrAZ
	 yfcOtWdOvySeyu4cIYQS5cG+GmkU9kiaZVpT2nNjxtbw3U9LuvZQYMLi1QT+IR5gwJ
	 lzWIph0iQVVJjmuCHOyhALc7i2Z5sqJMtN1pt5XRvI+ibEOELf7cTw7WkmiScN/xx/
	 vfLInn1NyhGyupXTgBOJmVMpuv/lKCSmX4eFHXhu3STqEqJC85F7pdC6W7IJXR1Ga4
	 GRvHdyRxv3W6XL0wzMYCH9g+rpJLnpYnKJ/purqQZB9OYgFFT64+B/HTprT0Jx+KjT
	 A9sWJzBjk3jIcRe8RkXDXq+0cGT8g0XZeCxrWn2UnAWEOPrNAX537klAYO644i8zLi
	 D133+TwC+1XG5DsuoLN/i0pdDDo7apX7JlC4w6BYiiqXAaUNPLi9RUCigOSbJTk9nS
	 IIz+8OYPxpDAJ1uwU64EyoyvV24NybUR6xwAzDqmXt0ecFfWuF/byCdwOs9JNQ4ezM
	 5igrQy6H+pLlaqatNoMkq6kdQIWmZcuUuJhuNCEH+Lt4s11Zt/PhYOviu0PJdBf5t1
	 GR0PpWENHL+mj5gGMAX00iUw=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 607AD1E9360; Wed,  6 May 2026 17:42:17 +0800 (AWST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1778060330;
	bh=wxwOGGBU7axLHOdFPa8Se5eHpE8XygiR/3cms0LswXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SdlOkqYgmpbMQ90PDsf4vRNjySF2VWn2s6xItWSlRvy0nYeO3PGdxzlfpOW5vgtu5
	 if5hGy6bGoNdipM5VQuimgFIHIKNGdaOf4YHLD/yKZ9zJcTUB64QAGizb/oRwx+Ye7
	 EBESj8bLMqCfGXWYHAoHJBNvORT2jw0kIPdJbdcd0HF4AGRpM/kXrcn5sXP00+JKH5
	 I7gFjm7bxv07o23A4fCkIEWTkv4Cr3cV2pagCYU2FsvYSULSRKja7otRbXAjzHwllJ
	 LhRpWRfUVdVyqd59KqHhJSlBa7IFXkeH9EUvF0d+P1fE2HK77hNjDwY5Jb4e28YaNx
	 nRXi8j1lnAqoSYv5Hzln6sUO4HF1eRcT1YcgDK0EF2OXQhNxeO9qojKh37CVNzsDgU
	 JlHxWPo+kyarDMyhaRCycdqITYW24zyT89S14QlGZsZQo9+PkOvxx8Bl6byrLQwfpz
	 HA/GAysD6LLH5D3Dlp+ShA2aby8d6OQJpemmQvsJ4GmPqpCpw1p27I8U132VYpxfKF
	 2OeuXk29pGwkognpCJCRBoWdZyGkznpQy/dZepv+oAGB4dmHUpwLFIoLM/CFv2lYcT
	 bbCvdHx+egEMZyZmE+jALf8iR+mIDj8U75t/sVcSY6WWMfgwCcrDXNg8zVUEgi334P
	 yVORKeqjzNqR+fBkv/oKVcMo=
Received: from [IPV6:2001:8003:8810:ea00:ed87:ca88:5326:e11d] (unknown [IPv6:2001:8003:8810:ea00:ed87:ca88:5326:e11d])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 279381E934B;
	Wed,  6 May 2026 17:38:50 +0800 (AWST)
Message-ID: <47d78cad-0839-4602-9cb3-d1f672739e7e@davidgow.net>
Date: Wed, 6 May 2026 17:38:50 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] drm: Suppress intentional warning backtraces in
 scaling unit tests
To: Albert Esteve <aesteve@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
 peterz@infradead.org, Guenter Roeck <linux@roeck-us.net>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Alessandro Carminati <acarmina@redhat.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
References: <20260504-kunit_add_support-v8-0-3e5957cdd235@redhat.com>
 <20260504-kunit_add_support-v8-3-3e5957cdd235@redhat.com>
Content-Language: fr
From: David Gow <david@davidgow.net>
In-Reply-To: <20260504-kunit_add_support-v8-3-3e5957cdd235@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/05/2026 à 3:41 PM, Albert Esteve a écrit :
> From: Guenter Roeck <linux@roeck-us.net>
> 
> The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
> intentionally trigger warning backtraces by providing bad parameters to
> the tested functions. What is tested is the return value, not the existence
> of a warning backtrace. Suppress the backtraces to avoid clogging the
> kernel log and distraction from real problems.
> 
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> Acked-by: Maíra Canal <mcanal@igalia.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> Acked-by: David Gow <david@davidgow.net>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---

I'm happy with this either with or without the extra check for the 
warning count.

Acked-by: David Gow <david@davidgow.net>

We'll take this patch in the kunit tree along with the rest of the 
series once everyone's happy.

Cheers,
-- David

>   drivers/gpu/drm/tests/drm_rect_test.c | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
> index 17e1f34b76101..818e16e80c8f9 100644
> --- a/drivers/gpu/drm/tests/drm_rect_test.c
> +++ b/drivers/gpu/drm/tests/drm_rect_test.c
> @@ -409,8 +409,16 @@ static void drm_test_rect_calc_hscale(struct kunit *test)
>   	const struct drm_rect_scale_case *params = test->param_value;
>   	int scaling_factor;
>   
> -	scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
> -					      params->min_range, params->max_range);
> +	/*
> +	 * drm_rect_calc_hscale() generates a warning backtrace whenever bad
> +	 * parameters are passed to it. This affects all unit tests with an
> +	 * error code in expected_scaling_factor.
> +	 */
> +	kunit_warning_suppress(test) {
> +		scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
> +						      params->min_range,
> +						      params->max_range);
> +	}
>   
>   	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
>   }
> @@ -420,8 +428,15 @@ static void drm_test_rect_calc_vscale(struct kunit *test)
>   	const struct drm_rect_scale_case *params = test->param_value;
>   	int scaling_factor;
>   
> -	scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
> -					      params->min_range, params->max_range);
> +	/*
> +	 * drm_rect_calc_vscale() generates a warning backtrace whenever bad
> +	 * parameters are passed to it. This affects all unit tests with an
> +	 * error code in expected_scaling_factor.
> +	 */
> +	kunit_warning_suppress(test) {
> +		scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
> +						      params->min_range, params->max_range);
> +	}
>   
>   	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
>   }
> 

