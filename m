Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9882C2360;
	Sat,  1 Aug 2026 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785614760; cv=none; b=cXxAcCkztgxSGN4TRACYF+YdYcgCj6gt2xe1154n90V+n2M3/exyWFCAsAxNL7xPkpwT+00HU7Q7kwn6cwM5y3EdwmsGkpqP3kUe9kGW+w8clJeiV+678rju4YIETTUjG5l+YBvP0zByfOmXcZeyawtcaejR6O29ImouE97l7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785614760; c=relaxed/simple;
	bh=hyvnLIsEr6YFMopwXWzXNGytrS5QqrEiawI+BeNL0+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSwN8RqoLXVc6YlQ98xjnrCVaSyiUDTKNGFbUYbYaO+O36DK3jBt8orNoAOONpoBSiJAItPdQr9G2PkPmodIRNnKSqBAHC/9k7amMlYN41PIrxIhUtuJItpCZXGXwOw/cOQVrmRlrjb8Q5vYSQXqRiH5m1e1puib7TQoNSEwiqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6dNkhwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6dNkhwM"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 96D7D1F00AC4;
	Sat,  1 Aug 2026 20:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785614759;
	bh=o45YvK+S7OLeve9Yx/dzHWbAcWKWifTwkY56jWeeVrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c6dNkhwM5uKM18Qer5XP+tW/4CrLiuLTGCy9FyARO7A6UjJ04jlRC4Qmzl2oCSh/K
	 7cC9x7476wW6hLiYqkai7A2GftMybhQYzVPv9zlZiKy99ypB7E32TEf/eG++UlALEE
	 Ifi7AeGaaZDa4fT1rEA0ePzz2tw9jnx6Xz6w22UHxTBlZLSVMvhDjdJ+0D8DJclM0m
	 fdDFWswAV4KpvS5YhCjwMeX/W4gyflkz4R+YdLn5AjmHD73af5JVRXG8ZWtcmYe1ml
	 z6Tc+WvYbABNifglg9On52MZDCkQ6ogEhTKXR1eBP4ZZYUTYOA9lW1aUdLZ3cyy1Cd
	 BwQ7cjuQsaReQ==
Date: Sat, 1 Aug 2026 21:30:27 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev
Subject: Re: [PATCH v4 1/7] kbuild: support generated asm-headers in
 subdirectories
Message-ID: <am5JU9IBVzXABmsK@levanger>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev
References: <20260724-vdso-arch-clockmodes-v4-0-ddbe447be860@linutronix.de>
 <20260724-vdso-arch-clockmodes-v4-1-ddbe447be860@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724-vdso-arch-clockmodes-v4-1-ddbe447be860@linutronix.de>

On Fri, Jul 24, 2026 at 03:36:18PM +0200, Thomas Weiﬂschuh wrote:
> Extend the asm-header stub generation to also handle subdirectories.
> An upcoming vdso/ header refactoring requires this.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  scripts/Makefile.asm-headers | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

For kbuild:

Reviewed-by: Nicolas Schier <nsc@kernel.org>

