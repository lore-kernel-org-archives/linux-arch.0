Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00B430AACA;
	Thu, 29 Jan 2026 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769725443; cv=none; b=bBYsAxEs/ewlFsINF0oJzYzLhuVjB9W6+ti9de06t+v1MdKdmDsWqEXhpiZXNq7/4Xl8D+gGnn2qufa2u+DQAdUjIqV/2frRH/QefE+Taod2unx7UWFW0WrIr4wPd78Fkx7km+FXW0Xwmy4HD1oqVYOOhhoUrYTX86nFCQzucAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769725443; c=relaxed/simple;
	bh=iMaPWtPod9ByMOOuAt/MtzZz3+FMq8hou2bTY53gXr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoKoX5145NuotWTXblwNyic690IjKLD3L2AHlQHnNPX35zxszIi/MbZ53NPMAsmLQc2+BriWASUOWwuydSYMeYLRNpmY0pArmw+LriMG8o6vLA01GjH7Cn9yeVtCPJWxfQ8HvhIHh2SGuB+IWI7nzJKTCRiaKqv/Ex91ayxkAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDlJA7dj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDlJA7dj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB956C4CEF7;
	Thu, 29 Jan 2026 22:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769725442;
	bh=iMaPWtPod9ByMOOuAt/MtzZz3+FMq8hou2bTY53gXr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pDlJA7djqNmJbm5bDlrQAxdVRN+igq/D4oC7oXiMn2eyv+TNFLUIC8Wgxlu1JECXa
	 QYasyv+SXuzLzqWudYbi1iXRS9BxGc77qI7jtfKmkbrygxks4fXtRjTvTYbmlJg+IM
	 l+uLhPFVQjLh8DaoiTV9U8jTpBTdMmbXXcvWKyNdYlYKej8xzoEKuKEcejhmjFDhgH
	 jBLVuJoQcguF1dWtjJTPIQuf64jk4Gs4hpM9duoSobRKTyuIlqTf9Rg0gPuxm4eEEs
	 sBPJUatco+zy+Tj8A4DsfE6umkYf6vWgxQxnn1v+yVljxEvvaO/dEqu/TsnDInctsB
	 k99Z4/SUJ7hoA==
Date: Thu, 29 Jan 2026 15:23:57 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Matthias Klose <doko@debian.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Binutils <binutils@sourceware.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Indu Bhagat <indu.bhagat@oracle.com>
Subject: Re: [RFC] Don't create sframes during build
Message-ID: <20260129222357.GA493990@ax162>
References: <20250904131835.sfcG19NV@linutronix.de>
 <b3db475e-e84d-4056-9420-bc0acc8b9fe5@debian.org>
 <7b45d196-063e-4e76-b08b-ec2bcc111328@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b45d196-063e-4e76-b08b-ec2bcc111328@linux.ibm.com>

On Thu, Jan 29, 2026 at 10:13:03AM +0100, Jens Remus wrote:
> Instead of dropping .sframe for kernel during final link it would be
> better not to generate it to save some CPU cycles and disk space.
...
> What about:
> 
> diff --git a/Makefile b/Makefile
> --- a/Makefile
> +++ b/Makefile
> @@ -906,6 +906,11 @@ KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
>  KBUILD_CFLAGS	+= $(call cc-option,-fno-allow-store-data-races)
>  endif
> 
> +# No .sframe generation for kernel if enabled in assembler by default
> +CC_FLAGS_SFRAME	:= $(call as-option,-Wa$(comma)--gsframe=no)
> +KBUILD_CFLAGS	+= $(CC_FLAGS_SFRAME)
> +KBUILD_AFLAGS	+= $(CC_FLAGS_SFRAME)
> +
>  ifdef CONFIG_READABLE_ASM
>  # Disable optimizations that make assembler listings hard to read.
>  # reorder blocks reorders the control in the function

This seems like a good start for the main kernel build. I still have an
issue with bleeding edge binutils with mismatched .sframe input
sections, which does not appear to disappear with -Wa,--gsframe=no.

  $ cat test.c
  void atexit();
  void main() { atexit(); }

  $ gcc --version | head -1
  gcc (GCC) 15.2.1 20260103

  $ ld --version | head -1
  GNU ld (GNU Binutils) 2.45.50.20260128

  $ gcc -o /dev/null test.c
  .../binutils/2.45.50-2026-01-27_18-02-52-e8108cc5e6fe1748dc6033a297dd2c1c6234de78/bin/ld: input SFrame sections with different format versions prevent .sframe generation
  .../binutils/2.45.50-2026-01-27_18-02-52-e8108cc5e6fe1748dc6033a297dd2c1c6234de78/bin/ld: final link failed
  collect2: error: ld returned 1 exit status

  $ gcc -o /dev/null -Wa,--gsframe=no test.c
  .../binutils/2.45.50-2026-01-27_18-02-52-e8108cc5e6fe1748dc6033a297dd2c1c6234de78/bin/ld: input SFrame sections with different format versions prevent .sframe generation
  .../binutils/2.45.50-2026-01-27_18-02-52-e8108cc5e6fe1748dc6033a297dd2c1c6234de78/bin/ld: final link failed
  collect2: error: ld returned 1 exit status

  $ gcc -o /dev/null -Wl,--discard-sframe test.c

This was extracted from an error I see while building libiberty in
binutils due to the atexit() configure test failing then the fallback to
on_exit() resulting in an error but I also notice it when building
tools/objtool, which is a host tool:

  $ make -skj"$(nproc)" ARCH=x86_64 mrproper defconfig prepare
  .../binutils/2.45.50-2026-01-27_18-02-52-e8108cc5e6fe1748dc6033a297dd2c1c6234de78/bin/ld: input SFrame sections with different format versions prevent .sframe generation
  .../binutils/2.45.50-2026-01-27_18-02-52-e8108cc5e6fe1748dc6033a297dd2c1c6234de78/bin/ld: final link failed
  collect2: error: ld returned 1 exit status
  make[5]: *** [Makefile:127: tools/objtool/objtool] Error 1
  ...

It looks like several distribution ELF objects and libraries on my
system (Arch Linux) have .sframe sections in them, so maybe we still
need -Wl,--discard-sframe? They all appear to be SFrame v2 objects so if
no objects in the build have SFrame v3 sections from -Wa,--gsframe=no,
it seems odd that there is an error but maybe there is something else
going on?

Cheers,
Nathan
