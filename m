Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F18627A45C;
	Wed, 25 Feb 2026 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040299; cv=none; b=bbcSLaQdZCtWSKOFE3QgMBmR1Pczdnsf5TrNu/4bCvyVZ4RNH+jhlSyc1Nd0RUQ6sQXpvN8GI2JPzi5SmPtSZtWGyjO/iOWYRkLGdiC5656VuPAMIcRYwGJNwIGEqze0m9tWWvoBDrHHsfKFeUtyN3YafWgKFCRbC4ix1rx15nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040299; c=relaxed/simple;
	bh=0e9SqD/+hsqTFerGrgoY6o2/NOjfpeueLYEdBPSeVd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miMTAn9wkxFOUJHsoAuzuSiwCW1wqL5Vz324jiv5TiWCiTA7qcWRJ48/Tnz66CbH5/Sr7eRxS+jrSZ4wAgXLRXywHyMMS5mN6tsH11/1E30XjKO1xCXfyF4EnL9bNpcitKN8F6By5PB2SFCWkyW25S+Iuqe49YDZ97xzNoVs5tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8KCP8v6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8KCP8v6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A62C116D0;
	Wed, 25 Feb 2026 17:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772040298;
	bh=0e9SqD/+hsqTFerGrgoY6o2/NOjfpeueLYEdBPSeVd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8KCP8v6TEvoD4b7UR2NbIKZtY7/aATfjB9fLWp+hTa1yD1GCa2wR3uamUDLFnp6b
	 kDTbNJOo2MW6F07WGx0jIn7SHchNDIjhST9sAxGkzBiGjVWJo4bQuOLOc5ki4ESp1w
	 dRncP9MtgjNt6sPdMI+AHo+oIOjnXl8zfQvDq/5RNDYWLO6LoXsh+8raIQpcU0CA3m
	 rfJGb3Km64g/F/ZKDrScLwC12P77UCAHYXF5lfA//yAfl55IRy+89t3X5oo7pEI41k
	 T36F4bX28KIRRg3bl0BB7doDbrT1RUuDjGp57P0cRI8LzLGnlagLKLipxstIEk5Z7i
	 XoehDrvcOfyog==
Date: Wed, 25 Feb 2026 09:24:58 -0800
From: Kees Cook <kees@kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Jingwei Wang <wangjingwei@iscas.ac.cn>,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] vdso/datapage: Define vdso data pointers as arrays
Message-ID: <202602250924.B0A6F658ED@keescook>
References: <20260225024716.work.043-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225024716.work.043-kees@kernel.org>

On Tue, Feb 24, 2026 at 06:47:20PM -0800, Kees Cook wrote:
> The vdso_u_time_data, vdso_u_rng_data, and vdso_u_arch_data arrays
> are seen by GCC as single instances (due to their declarations in
> include/vdso/datapage.h). When the vdso data pointers are dereferenced
> with an offset, GCC thinks there is an access beyond the returned single
> instance. These are actually arrays constructed at link time, so declare
> them as such.

I found 2 more places I needed to make "&var" to "var" changes. I'll
send a v2...

-- 
Kees Cook
