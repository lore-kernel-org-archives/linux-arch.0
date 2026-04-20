Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68753280CD2;
	Mon, 20 Apr 2026 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696433; cv=none; b=s0AXp4YWxtWlfOZeRfd1+BE76B2pq0OLs+bEsRPWuwDLt3YazZWtRGAfWx/6UtjMOJ/gpM4TAk6g3rTF17PymF3dhQBoy6ocuK/RKq+XFusrQzsrSB7HU44rBO2A0EAe0J/FVwwR0/6flOvJhPAhqVXwqGJJaI5upu0GU7v8088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696433; c=relaxed/simple;
	bh=iYCRdH0ykmFr+A+ryrfohY97+3q6i5vstZiBO4OfpXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnyhY0tyMLCVGUuUE99WSlRAnCt9CstIMD7WvcB0cotNWVJ2SJSn6w84gUR8zEEi1qPOe4q+xFNKpOgnZ2PIaL6lB735c7S9rIwDLAdLchsPPnNWfvuAJmZ6Vp810n2qjcukL9s67aWIysU0cIpy/DsW8Xp+uassOgrxtAxc7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y8RUxH+d; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y8RUxH+d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=eCyjhK/Q5fvtzDJtYR2G5sGLVBYO/Uljn2Rnbl90Gu0=; b=Y8RUxH+dN4uV3ck9NPBEDW9CGM
	fgtqPHdQaI5QFweHYVIYYEEuBsHHRv6yywnyvpCwRBGLzYy/o7bvAcPVG1Ymao+JTWrvwvVZnTwVm
	IN21XtGPpXtODoG9r4/dBnrjnRWgSij6UTDsxuArM4siJySJi1QR11AhSta/rwWUzR00ipJ8xCNf5
	9NXwEoh98VnqRKI7YdyJ0qYcFFjr7ctuQ5/prJtTJ6muED0U+YWgDgXkgXhJbkFc7OVRZmVrYGQYz
	GRd63Qs3K7/OG8khcL8MmtGYcH9hTyO6FhamVrohS+Miz4IsxuND1CLL6wiXVaLeaNMKl5hLkOZOx
	WOzwBaBA==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEptv-00000008Dyi-18py;
	Mon, 20 Apr 2026 14:47:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C9CC2301BDE; Mon, 20 Apr 2026 16:47:02 +0200 (CEST)
Date: Mon, 20 Apr 2026 16:47:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v7 4/5] drm: Suppress intentional warning backtraces in
 scaling unit tests
Message-ID: <20260420144702.GM3102624@noisy.programming.kicks-ass.net>
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-4-e8bc6e0f70de@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260420-kunit_add_support-v7-4-e8bc6e0f70de@redhat.com>

On Mon, Apr 20, 2026 at 02:28:06PM +0200, Albert Esteve wrote:
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
>  drivers/gpu/drm/tests/drm_rect_test.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
> index 17e1f34b76101..1dd7d819165e7 100644
> --- a/drivers/gpu/drm/tests/drm_rect_test.c
> +++ b/drivers/gpu/drm/tests/drm_rect_test.c
> @@ -409,8 +409,15 @@ static void drm_test_rect_calc_hscale(struct kunit *test)
>  	const struct drm_rect_scale_case *params = test->param_value;
>  	int scaling_factor;
>  
> +	/*
> +	 * drm_rect_calc_hscale() generates a warning backtrace whenever bad
> +	 * parameters are passed to it. This affects all unit tests with an
> +	 * error code in expected_scaling_factor.
> +	 */
> +	KUNIT_START_SUPPRESSED_WARNING(test);
>  	scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
>  					      params->min_range, params->max_range);
> +	KUNIT_END_SUPPRESSED_WARNING(test);

Would not something like:

	scoped_kunit_suppress() {
		scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
						      params->min_range, params->max_range);
	}

be better?

Also, how can you stand all this screaming in the code?
