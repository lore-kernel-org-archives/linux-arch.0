Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD26434E35;
	Mon, 28 Sep 2026 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594154; cv=none; b=mVuFE/AGJ0flGjc/A7/wJcAhZhRi4SsCFK6QkWym6c5atuo8xpAV3dd9p6Xrq7Zy5EwX5YHguSLrtzg5qWhdFjtbb2btrd2eZtcTbi7SVfIh777NBu3s1efBSRla0LngSY9/SvfgvmvuzjdYkrtXV9WUOFlCyWlKmimkyMSeqng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594154; c=relaxed/simple;
	bh=/rEQ5tR0s7tCO9TBNoWnBlkcTDT0Tbc/AZQQ+6eJ3YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOE59PU7uoe1aRzqFL/1dqjA2zS21thWkYHXSisgkcmOCWxKMSiRrQ2r6PUfo/21dXQ+eMgBefu3MumC5R5g8+4QEioothJtFxyenGxfsRufu2dGACbaA36eTlg00eRn3LDmDPTsnW0ygb/S7bBTOzqYKmr7r8/FRAGRZRKMxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIOuwvHj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIOuwvHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4B01F000FF;
	Mon, 28 Sep 2026 11:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790594152;
	bh=qKgEuv9CkeatwMaEoVWwIZzAsZrjAYsxRirMIYaZdag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QIOuwvHjPRav9eT8nF7YfNLLqJ8z0AQt1yewPmRegf+oH5eRgNJIhbn1v1/Q+2o0X
	 nPUarDfalGrAaN9D1k51LHg6iQRCc0U2OaF7tkOiq7GrZXB87kSf/U3dIi5r8P3+rn
	 K4uoZoDZlBzDBtSl8TkWII13sSk5xAuw4ybHFFNxjLwfjnZOW8l3gk3uavcQ03fYzt
	 A4jwuaoPWpccsxO+V5Jbp/p027RhnKRzkXX9yS9xIvLtvDf0Q3eMqXghDMs3mwv4Ro
	 IGj0LRAD7WdzX30gEYUznsFq9Xa01QdmuiuaDgt/y1aEojl6qc2wscTH1JvBMYmBkD
	 N9uS42sU1xGSA==
Date: Mon, 28 Sep 2026 12:15:46 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH] kbuild: keep .modinfo when vmlinux is linked with
 --gc-sections
Message-ID: <arpLoeLVATRCXm5E@gremlin>
References: <20260927161227.1179863-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927161227.1179863-1-sashal@kernel.org>

On Sun, Sep 27, 2026 at 12:12:27PM -0400, Sasha Levin wrote:
> Builds with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y, such as arm
> allmodconfig, now fail while extracting modules.builtin.modinfo:
>
>   arm-linux-gnueabihf-objcopy: vmlinux.unstripped: can't dump section
>   '.modinfo' - it does not exist: file format not recognized
>   /bin/sh: 1: cannot open modules.builtin.modinfo: No such file
>
> or, with LLVM:
>
>   llvm-objcopy: error: 'vmlinux.unstripped': section '.modinfo' not
>   found
>
> Nothing references the MODULE_INFO() strings, so --gc-sections
> discards every .modinfo input section and vmlinux.unstripped ends up
> with no .modinfo data. This is not new: ever since
> modules.builtin.modinfo started being extracted from
> vmlinux.unstripped, these builds have silently produced an empty
> file, losing the modinfo of every built-in module. An arm
> multi_v7_defconfig build with LD_DEAD_CODE_DATA_ELIMINATION on current
> mainline yields a 0 byte modules.builtin.modinfo. The switch to
> --dump-section only turned that into a build error.

Yikes, so an existing bug but now exposed by my series.

>
> Wrap the input section in KEEP() so that the linker retains it. The
> output section is still (INFO), so nothing is allocated for it. With
> the same arm config, modules.builtin.modinfo now has 14119 entries,
> and on x86_64 defconfig, where nothing is garbage collected, it is
> byte-identical before and after this change.

Sounds reasonable.

>
> Found by KernelCI builds of the linus-next tree.
>
> Fixes: 39cfd5b12160 ("kbuild: extract modules.builtin.modinfo from vmlinux.unstripped")
> Fixes: 5fe4dd596641 ("kbuild: do not allocate .modinfo in vmlinux")
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Nathan - do you want me to fold this into the 1st patch of my series on respin
or fine to treat separately?

> ---
>  include/asm-generic/vmlinux.lds.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index a6730d34e8c67..7a3e9f00d6283 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -855,7 +855,7 @@
>  		KLP_SYMID
>
>  #define MODINFO								\
> -		.modinfo (INFO) : { *(.modinfo) }
> +		.modinfo (INFO) : { KEEP(*(.modinfo)) }
>
>  #ifdef CONFIG_GENERIC_BUG
>  #define BUG_TABLE							\
> --
> 2.53.0
>

--
Cheers, Lorenzo
