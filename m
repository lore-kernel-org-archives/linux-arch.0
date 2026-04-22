Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726423A2559;
	Wed, 22 Apr 2026 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860613; cv=none; b=F3fQZLpuiLSQJRAWwN4jpoVHJKhqhB9v82TCqUFqDjmb4NtCZSyu4XEu/y7pXxGDrd8nD2GjG/oRufZBLtrBWHeSGW6sONVH41H6e95UC75GGkExcKA4qH1nHcPzVX6xXLVc114wzwJ6ERGtLrP0DINJj/e5dWvu8Pz8Fy5Wfg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860613; c=relaxed/simple;
	bh=b+jdMLz/f1OCxDME3vP0n+Ytlo9Zm1RnVo7KNc+DlTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFg1Zh0dVJqZ9kWVttraHR7tGrGiOPfx4hwT7Lz53sywjX12AQeuZfJPPCP2Eu4hWz9hIgkTVx+OeHsgYKdG2b+n5whTrzSTY2y21xHE0OuCUEXPjT05wxthvifxtL2cPlywfn0XYGYhigZkWK12rHFTPr1oZQr2uianBjnKtBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=iddACaic; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=UTgnOpLg; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="iddACaic";
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="UTgnOpLg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1776860609;
	bh=b+jdMLz/f1OCxDME3vP0n+Ytlo9Zm1RnVo7KNc+DlTI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iddACaic5LMU0yf7iarpcuEgpyaXzXjNM1WA35gTg0uOtPsleP0IFel1YTbF5ePj2
	 +4nT+FsxJ8cgGSEkdYxATk69FfhmSo1xaOfZO4GC+9rVvmjsCI9BB/Z5lOvZdZkRaL
	 p6dEpcm4vpSuxsvbC4ALZcv6n7/YNHw19Gt6oqiwTFkEBD8LyHXu440XnSl/z/lia1
	 rgGgTzLQO14Ljz00IGAGjIQvdBEhjci9E9kPVIZguZhZyEW6eeGNvuLQydkE9NJ07F
	 NLdK+N3WqW8zim5QsGXAS/DYG1qDrapD/JSTrtK0ew/j8raQIRJXa85EJow7D5bgII
	 7ruSRLbr9C6q7WUfo1I2NQXvN8+31CEFJNFVyx/JKRIXaTq8nXAoyhH6M53QEP9u2t
	 Y/m561loc6xqyWMPhGCSiINVanplpMBtiyd7QdwBLBumJBqwxAJa9oV9cZqt4j6a+N
	 +YROfqxKUsobFE3793Uwh1dzepNa+gxJfpH3h1HW0INh7bq6WsA/6FC2/BlqjqlShK
	 tU74sWbxyEUiMOjbq0C2LbfcchUOVnxvMive21KdrPCBqQJw35H3RldOcYohBYXPDO
	 xz3/BgDqsThaogj/NqQhi6KSiXXnZkLWbqzXohRgX9VKX0Sj9lzkHn4dgPtKZZN4tS
	 Th4KO/owGoVeHwt+lYrDFxvo=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 8B0881E8D8B; Wed, 22 Apr 2026 20:23:29 +0800 (AWST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1776860421;
	bh=b+jdMLz/f1OCxDME3vP0n+Ytlo9Zm1RnVo7KNc+DlTI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UTgnOpLgovcFqQ4HM6TnCdPdCX4lU52Z2jkOjv2W7HETijIRyCzB6BoC8r/EK6bfY
	 mJ7NfuHEcDqnLvFSgMs1pdeyzJVGQV5kov6J/MgNsiI7b1HpHqg234/oQfO0uTf0Lb
	 /5PFNtMklX/+fLZY5tne1c3TXUamwifgR2KWnbjjCCu118RVlVNvgbzxm5UgqNAfpo
	 SGpxDNeABfxvwxRtbXRCnOxyv6YbuM8VZBGRA060eFIC/9/DNeem7O8ze1zbqd0ibS
	 ywIBWABlVZWnWNc0b066lw1pqQfP04Vxp+8pfFT4xriUNtceMFG86XYgRMt7A1bpHy
	 sn9Fe6pyQGSE+NNeNDdhuuy2byf78MzCytxyJVx0Sp+XYJjFpFxDSsIdKDyUD5Kia1
	 c/n6FUXM6bwFsbCErfBKJTwSgtf3nIWy49hxNBxSlizXu5MtVUTvWigirXW3L6UQd3
	 gKkBEwcwpSNXJYlHbohyKjyWOUr+YxncJ7jtbMd2KbopLO4orXUkgESGzN/pD7fTPE
	 IatgVyeX+bFglXxao/qgsVhPOcDxXXqehEeSKAtwyOBhLSDTWVsDxX5ztsYBYts+pm
	 Xj0toXWDqLkZSnP0ydze+uSbkHUT7EnaJZWOSp1loEPLaJ8oM5m36lUYvoAX1ihEqo
	 u+E/jcn1K1CjEYqfkGYSGKJo=
Received: from [IPV6:2001:8003:8810:ea00:ed87:ca88:5326:e11d] (unknown [IPv6:2001:8003:8810:ea00:ed87:ca88:5326:e11d])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 9DF711E8D8B;
	Wed, 22 Apr 2026 20:20:21 +0800 (AWST)
Message-ID: <3922addf-32d8-4548-9a43-0e9bd861a5c8@davidgow.net>
Date: Wed, 22 Apr 2026 20:20:19 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] drm: Suppress intentional warning backtraces in
 scaling unit tests
To: Albert Esteve <aesteve@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, peterz@infradead.org,
 Guenter Roeck <linux@roeck-us.net>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Alessandro Carminati <acarmina@redhat.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-4-e8bc6e0f70de@redhat.com>
Content-Language: fr
From: David Gow <david@davidgow.net>
In-Reply-To: <20260420-kunit_add_support-v7-4-e8bc6e0f70de@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/04/2026 à 8:28 PM, Albert Esteve a écrit :
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
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---

Acked-by: David Gow <david@davidgow.net>

Some of the suggestions in the thread around __cleanup() et al. sound 
good to me, too. I suspect that it should work given the 
kunit_add_action() / resource system use anyway, so even if an assertion 
fires, things should be cleaned up properly.

Cheers,
-- David

>   drivers/gpu/drm/tests/drm_rect_test.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
> index 17e1f34b76101..1dd7d819165e7 100644
> --- a/drivers/gpu/drm/tests/drm_rect_test.c
> +++ b/drivers/gpu/drm/tests/drm_rect_test.c
> @@ -409,8 +409,15 @@ static void drm_test_rect_calc_hscale(struct kunit *test)
>   	const struct drm_rect_scale_case *params = test->param_value;
>   	int scaling_factor;
>   
> +	/*
> +	 * drm_rect_calc_hscale() generates a warning backtrace whenever bad
> +	 * parameters are passed to it. This affects all unit tests with an
> +	 * error code in expected_scaling_factor.
> +	 */
> +	KUNIT_START_SUPPRESSED_WARNING(test);
>   	scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
>   					      params->min_range, params->max_range);
> +	KUNIT_END_SUPPRESSED_WARNING(test);
>   
>   	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
>   }
> @@ -420,8 +427,15 @@ static void drm_test_rect_calc_vscale(struct kunit *test)
>   	const struct drm_rect_scale_case *params = test->param_value;
>   	int scaling_factor;
>   
> +	/*
> +	 * drm_rect_calc_vscale() generates a warning backtrace whenever bad
> +	 * parameters are passed to it. This affects all unit tests with an
> +	 * error code in expected_scaling_factor.
> +	 */
> +	KUNIT_START_SUPPRESSED_WARNING(test);
>   	scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
>   					      params->min_range, params->max_range);
> +	KUNIT_END_SUPPRESSED_WARNING(test);
>   
>   	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
>   }
> 

