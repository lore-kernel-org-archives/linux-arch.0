Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9EA411F95;
	Wed, 22 Jul 2026 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740908; cv=none; b=DJq/BILDHgaUbw2cF0qnjXJcQ9o9WJZlqjNjtG7QUFSxy822VDhH6/sEAWI53DGTY3vgiii202NPnw9b9JKbY5gZBAcAtV5/IxUFCxRhpM6yicD55Ier/XwFc6kY/rlJD1sa7JjDLbhvzyVsS1xZdh5w8BOQ3tmUKhtIACNi6pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740908; c=relaxed/simple;
	bh=AlcHC/s/YIEVyt0pCF8jhgsZAftRoNvQ7vNQm6sfZMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNYMqRI/HcpmO/Rr2I8NTmCYsm+A6iEGfIebrJaG0AahJ2IaHB+MTnrxONYs+TEhnc9+t9StSqRPyKgLECromww41LdQXIxYI3PRmTrh87NQ6sDOdYDOdKv+OE6rhrJt2X65vg/9zwaCyzoTIFvsuxJN4+IteKi96ucZxgSb2rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHXpKMkO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHXpKMkO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30691F000E9;
	Wed, 22 Jul 2026 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784740907;
	bh=n4+qE4ZoohVYF/j3isYgupSr93BAAzyHcaf7DgfjxBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AHXpKMkO2HaiOLjQtij21gEqEeLylpNpBFJ5KyxuzWUbJsESp3qJ+AGg5XBVCzzcS
	 CiLE8BAwjLbx4FNVDfE8IM1EQDFTS6VUv9AZSAlBoYae6xUcLLpZX0oUGpSmSpW/BN
	 kxLInKY8s8iYTEqmEWlZDMBiWUMgbU6TawTUpKkEHJsJ8lSR0w4uo4yD7J9N9T7O8r
	 nqg7isqUOL3kWu8OgnEN7EW1X42MVptnquDBqHtLfa+J+zXv/8Hn+EJjIIqfw0DGE/
	 bMzHj40KOtPobKR5ISocxtNdU6XGTwGpvQzJnFyiXit1GzhhJkjMcrrRiluIqzfyUe
	 4+Yn7UsdVn5nw==
Date: Wed, 22 Jul 2026 10:21:40 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Nicolas Schier <nsc@kernel.org>,
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
Subject: Re: [PATCH v3 1/7] kbuild: support generated asm-headers in
 subdirectories
Message-ID: <20260722172140.GA2947455@ax162>
References: <20260722-vdso-arch-clockmodes-v3-0-4c5753191cc4@linutronix.de>
 <20260722-vdso-arch-clockmodes-v3-1-4c5753191cc4@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722-vdso-arch-clockmodes-v3-1-4c5753191cc4@linutronix.de>

On Wed, Jul 22, 2026 at 09:53:27AM +0200, Thomas Weiﬂschuh wrote:
> Extend the asm-header stub generation to also handle subdirectories.
> An upcoming vdso/ header refactoring requires this.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  scripts/Makefile.asm-headers | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/Makefile.asm-headers b/scripts/Makefile.asm-headers
> index 8a4856e74180..772b53ffdeb4 100644
> --- a/scripts/Makefile.asm-headers
> +++ b/scripts/Makefile.asm-headers
> @@ -48,14 +48,13 @@ syscall-y   := $(addprefix $(obj)/, $(syscall-y))
>  generated-y := $(addprefix $(obj)/, $(generated-y))
>  
>  # Remove stale wrappers when the corresponding files are removed from generic-y
> -old-headers := $(wildcard $(obj)/*.h)
> +old-headers := $(shell test -d $(obj) && find $(obj) -name *.h)
>  unwanted    := $(filter-out $(generic-y) $(generated-y) $(syscall-y),$(old-headers))
>  
> -quiet_cmd_wrap = WRAP    $@
> -      cmd_wrap = echo "\#include <asm-generic/$*.h>" > $@
> +filechk_wrap = echo "\#include <asm-generic/$*.h>"
>  
>  quiet_cmd_remove = REMOVE  $(unwanted)
> -      cmd_remove = rm -f $(unwanted)
> +      cmd_remove = rm -f $(unwanted); find $(obj) -type -d -empty -delete

There appears to be a stray '-' in the find command ('-type -d' instead
of '-type d').

>  
>  quiet_cmd_syshdr = SYSHDR  $@
>        cmd_syshdr = $(CONFIG_SHELL) $(syshdr) \
> @@ -74,8 +73,8 @@ all: $(generic-y) $(syscall-y)
>  	$(if $(unwanted),$(call cmd,remove))
>  	@:
>  
> -$(obj)/%.h: $(srctree)/$(generic)/%.h
> -	$(call cmd,wrap)
> +$(obj)/%.h: $(srctree)/$(generic)/%.h FORCE
> +	$(call filechk,wrap)
>  
>  $(obj)/unistd_%.h: $(syscalltbl) $(syshdr) FORCE
>  	$(call if_changed,syshdr)
> 
> -- 
> 2.55.0

-- 
Cheers,
Nathan
