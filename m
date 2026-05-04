Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6FF30C601;
	Mon,  4 May 2026 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889042; cv=none; b=bdJj0NdbDgHzoIle6Ia78yiuwRxX/5mXyp98Y2EGuYSgruhrIETPV515Ae7iYZeXXdKzrKcAyPkNW9kZU6v8Ih8IrbJD/HPlIhtHEnZnj4v3TIeaIL976aBzkHAFFHph0hMFvtR7ljObobakghzrnoO95KFzwie/fpIgfSgvIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889042; c=relaxed/simple;
	bh=nuDbG8GlnJh+Hy802qd/7OVIem8MvSn13WgorSUCV9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ta+rEwCxtzMp+ZkgiDoHv53SdQjPBV98YniVi+0ejUYTE/pEZMy+2Ql7i1zZ85bJKg2bGjV8mi26AkhwMcfYcAltQw9sTARqmYYQNeC7ImnCRS8DryS6lP+3jP3+QhCu8BaMXEkwuy3VHXuOvexjqsRku/x0A2u23jOWBx2Uq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/Xx9CbG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/Xx9CbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D73C2BCB8;
	Mon,  4 May 2026 10:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777889042;
	bh=nuDbG8GlnJh+Hy802qd/7OVIem8MvSn13WgorSUCV9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/Xx9CbG8R1a+pO1Uv1sGTs/BBrGbjew/2kuzfuHpGp61YQkRXzbFAN8/gl7CvZxB
	 P2lIWZezpUbdr7VzrImntVmUH0Zm5kYQL1xg6r087F4fNluReD8dAFASnJ3dwJOEE/
	 GeRUx6G/V53QZzavGAhqziL7v2XdZB5buP3T5g/+qrIjhYGdAc+FtIvrb8VbFlgMXW
	 O0shTol9EYATc2GIV3ebKl6GHNfbGr8M2B3s6LK5QCvBc+a8ckQRoNaDjWwZWqahOb
	 eAsZ6lZoZnfDe67CEtkK/gnN+knScpaxl8Q+1tVFCtQq6WA6wT0tbU95YVPCn+dj+V
	 N/JdLBwBrNyNA==
Date: Mon, 4 May 2026 12:03:59 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, 
	workflows@vger.kernel.org, linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
	peterz@infradead.org, Guenter Roeck <linux@roeck-us.net>, 
	Linux Kernel Functional Testing <lkft@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Alessandro Carminati <acarmina@redhat.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v8 3/4] drm: Suppress intentional warning backtraces in
 scaling unit tests
Message-ID: <20260504-tentacled-free-lobster-38d8d9@houat>
References: <20260504-kunit_add_support-v8-0-3e5957cdd235@redhat.com>
 <20260504-kunit_add_support-v8-3-3e5957cdd235@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="l72gnrb7cm3zxy4o"
Content-Disposition: inline
In-Reply-To: <20260504-kunit_add_support-v8-3-3e5957cdd235@redhat.com>


--l72gnrb7cm3zxy4o
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 3/4] drm: Suppress intentional warning backtraces in
 scaling unit tests
MIME-Version: 1.0

Hi,

On Mon, May 04, 2026 at 09:41:27AM +0200, Albert Esteve wrote:
> From: Guenter Roeck <linux@roeck-us.net>
>=20
> The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
> intentionally trigger warning backtraces by providing bad parameters to
> the tested functions. What is tested is the return value, not the existen=
ce
> of a warning backtrace. Suppress the backtraces to avoid clogging the
> kernel log and distraction from real problems.
>=20
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> Acked-by: Ma=EDra Canal <mcanal@igalia.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> Acked-by: David Gow <david@davidgow.net>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  drivers/gpu/drm/tests/drm_rect_test.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/test=
s/drm_rect_test.c
> index 17e1f34b76101..818e16e80c8f9 100644
> --- a/drivers/gpu/drm/tests/drm_rect_test.c
> +++ b/drivers/gpu/drm/tests/drm_rect_test.c
> @@ -409,8 +409,16 @@ static void drm_test_rect_calc_hscale(struct kunit *=
test)
>  	const struct drm_rect_scale_case *params =3D test->param_value;
>  	int scaling_factor;
> =20
> -	scaling_factor =3D drm_rect_calc_hscale(&params->src, &params->dst,
> -					      params->min_range, params->max_range);
> +	/*
> +	 * drm_rect_calc_hscale() generates a warning backtrace whenever bad
> +	 * parameters are passed to it. This affects all unit tests with an
> +	 * error code in expected_scaling_factor.
> +	 */
> +	kunit_warning_suppress(test) {
> +		scaling_factor =3D drm_rect_calc_hscale(&params->src, &params->dst,
> +						      params->min_range,
> +						      params->max_range);
> +	}
> =20
>  	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
>  }
> @@ -420,8 +428,15 @@ static void drm_test_rect_calc_vscale(struct kunit *=
test)
>  	const struct drm_rect_scale_case *params =3D test->param_value;
>  	int scaling_factor;
> =20
> -	scaling_factor =3D drm_rect_calc_vscale(&params->src, &params->dst,
> -					      params->min_range, params->max_range);
> +	/*
> +	 * drm_rect_calc_vscale() generates a warning backtrace whenever bad
> +	 * parameters are passed to it. This affects all unit tests with an
> +	 * error code in expected_scaling_factor.
> +	 */
> +	kunit_warning_suppress(test) {
> +		scaling_factor =3D drm_rect_calc_vscale(&params->src, &params->dst,
> +						      params->min_range, params->max_range);
> +	}
> =20
>  	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
>  }

For both I think we should add KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT calls,=
 no?

Maxime

--l72gnrb7cm3zxy4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCafhvCgAKCRAnX84Zoj2+
dntHAYDS1y58bfYV6HBC/xGmy3ScNb3JXQaPk5lj+sGTSfkg+TOU32fyuZTWHM4Q
EHySwfABfjO0e9VfrYX1GC6pOKjJuf+UHNoIMlbjFKSia25t5hZS0ZmG+kAkG3OI
3vkSD8iAXA==
=kzTF
-----END PGP SIGNATURE-----

--l72gnrb7cm3zxy4o--
