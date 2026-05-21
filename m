Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DD629B79B;
	Thu, 21 May 2026 21:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779400638; cv=none; b=g3ri1K2syi493HRXGabF/p0S3gcGPNeButlJaNXwoHQyMoBcuSUv9WrN272+s2rRSbREXkcI6rynEuzXXh9kX4UCXb5/ghk0qzjH1Sg96K6hWNeTOnEAsW+Y9LMGlaHjZ3X5TcgSp26ii/WCVTxHJM0N+wcd0ZwWmI0ndiOp54U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779400638; c=relaxed/simple;
	bh=RKZaDLBpqrBx49aoCtLI+MLcTjOXaAaGMqfE5CYnRj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEe3WjfnvMFf9p2zkAjWf5DXjf4gL2JaxLW0sA+smZfSS7ps0cCYQ+/ZCoRQsauJyrqj2YGfIQFSXurUqjv3nbvxIDpOzcZwsYt+J0xjJy11boTlBQBjCqJMmlUKJqi1NXXI1ZWrOVFiC7Wx/UH9fw/AsnD9JXoV+J19NEmd/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4Sm8W4X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4Sm8W4X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0201C1F000E9;
	Thu, 21 May 2026 21:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779400636;
	bh=uQbQcM+2LFhGGCQDe0XZ51z9pdAsNMcpd6iW+ZY+bYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m4Sm8W4XsTe7axywiz1sP4asRFABCkdxRrgHOQEvE4uLdMIZTWhsxwDe+Qnon4pxz
	 6vQUSsH5TKerM0Za1lrlru6wAE/9mibrGrvdOUPQBpFRlv9GgxY6b4K7+CG8ZfUOHj
	 jsR+Dz7PYi7uM/35p8NwiI4yBBLlKaYcoy/lfVn2w8LVPSi8Ql/NBsjR+Z4hgMdxmh
	 lJn+XXPfzvr1OLGB8uMECc8WGQ9ozLAT3aScQP8Z1QSu1L/PB3PRjEXejKxQkQivx+
	 EKsFxS0VMMhLfdBD5J+z7uRPtLu0OyRmvQ+txqxoIrBPx8CS3hXETEG4sR0MHmVW4D
	 H+/z/Pv9KKX8g==
Date: Thu, 21 May 2026 22:57:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-next@vger.kernel.org,
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
	will@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
	rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com,
	zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
	rdunlap@infradead.org, david.laight.linux@gmail.com,
	joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, ashok.bhat@arm.com,
	Boqun Feng <boqun.feng@gmail.com>, Boqun Feng <boqun@kernel.org>,
	Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v11 1/2] kunit: add tests for smp_cond_load_*_timeout()
Message-ID: <47cfb505-5d96-43d5-bc2c-961f61fa7fea@sirena.org.uk>
References: <20260408122538.3610871-15-ankur.a.arora@oracle.com>
 <20260521083038.134260-1-ankur.a.arora@oracle.com>
 <20260521144629.11ee1e2ff88c5387a589f54a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iR8o3p4d1Gu3Q0D/"
Content-Disposition: inline
In-Reply-To: <20260521144629.11ee1e2ff88c5387a589f54a@linux-foundation.org>
X-Cookie: No shirt, no shoes, no service.


--iR8o3p4d1Gu3Q0D/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2026 at 02:46:29PM -0700, Andrew Morton wrote:

> Anyway, I removed the series "barrier: Add
> smp_cond_load_{relaxed,acquire}_timeout()" from mm.git on May 19 for
> forgotten reasons.  So I suggest that the series be respun and resent,
> with these two test patches included.

The tests were failing on arm64 when run on hardware (rather than qemu).

--iR8o3p4d1Gu3Q0D/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoPf7MACgkQJNaLcl1U
h9ArKgf/WBzu7kRDlWjCMxxM9PE8zNgetiSk55MAn0i/cLo7V5upiJIuWjWAQ/5V
HXFCzW8WqDm/C/fgLgagDfAeXryA8mQHNzj+/GfwyEMoi7U4axGE0JAbRApQG6tR
pdoCuQvFQny3cRv8fUhuur9cUuk1bAqSyU1DJK3Cd3GsHu+WOZLAsAJ5ybxGhO+L
2S58wosHLfeML83EnX2ksuxisglbtbLAolTETorArAclmbGRmeeUWDu7FEgbxJeV
t3xPOoO0SEvmyi0l5pF0aS1qlhWanVmbPZeAojeRABt3u1fLn4RrBCD3QMmmovTA
R2tbzJ5cLsnrfq45zTTFtfM1xAenLw==
=i6eZ
-----END PGP SIGNATURE-----

--iR8o3p4d1Gu3Q0D/--
