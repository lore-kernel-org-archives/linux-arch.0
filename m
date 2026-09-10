Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8773C062C
	for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032550; cv=none; b=GOSNR+D7aSGWFwerK9jGn/zUOJxW+bBxn27y5rfkGGYmZiobh+psh0VbwiRyZm4xeXYb77lGUgP9Kij8iVXeCBofXx1w4G5JF0HrZUpVaJ812VpL8IIx5bKw+mIG2yuKNRTdAdKC4QDFK6CDGU2BQjZdgHw9YANafnrBOve4zoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032550; c=relaxed/simple;
	bh=YmZhILYI1Ap/QhHEbws/tgVKUcLX7+iRsfdsJ1tAFSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbMmciJ+pEPUPjQGlbgq2ykHuJi8IhvmanFJGDzn5LclsXnrs/5BJ+XV88mFMt1R673ekuqUt1TVjI/yeosp0g3HK7UYIusAYlfU7I5v4DyKhXIV6dWbGA3Sn1wL0J4ME3Ek39OB7BKQ4RnL9/yfBIxNrBiMKU2At/jifdFRRiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fl7rpEKW; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fl7rpEKW"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48436216a98so4737903f8f.0
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2026 02:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789032546; x=1789637346; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xKhavT2ReA2W483I2xKkmSEJ1FM7bdVhooTyy/B0hnc=;
        b=fl7rpEKWOGJGTfMOVeV9QpCGl2mMK4Vehvs3dY8Rm+didzRH0gtOfiyzeoU8ALNMoM
         cT2BPMjJbXV5gQ6sliYvSB0QZIjgDx8/CdX1PBfpXHGSWrpCsIwYqoddBYs/UedP0HG3
         17GV1ku/mwl67dARTOxQ1Kpd06hZJ0r/c10p5zF0ehwV5FtS0mZnrdm99rFVd8Xtpjiz
         6VD6yvQSxr2ssCUsOX9CqQ8e534WuIcxyEfYFBisMF9gWWhB//9kRq84KgudvGXGGI2G
         7qfV7g8OkDajr/59MwtxDvgu3IQT3JAm7g/o50sPZ2s+6GE9ZKKNDlMGj5vUjZoPBa88
         3WPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789032546; x=1789637346;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKhavT2ReA2W483I2xKkmSEJ1FM7bdVhooTyy/B0hnc=;
        b=ACdcvI4iufNH5nFMoD5Wc74NUtDY/VCJS+pOsPdVCSZ7FJMCDmhnt6H+KWWkGcvMkl
         huo5YBSEErL0J4Y4h9z85x8qMeEWAqhHX1oUmJQYXkHkgbtZF/scGvT1TNVYA9E1DiWk
         NISavYroeQVYiKY02b1Ur1IBJg/Ej8Vk4aTJ1J8n2b+Sy4+svW8A+6lAeDz3vL2h58rO
         QSmt2IFCbU1mEZic7OX5bch2vb41tFBsi31ZVp/RkX5dUd+BSVg2uS+fVyS4vdd/Ge7m
         rM7N1EBdcHQx0vyfhREhnRbl+gfPMgeICO7ZRCYFRzhRIb6tPndYqdIzOZAPKqWCpFBk
         7vOA==
X-Forwarded-Encrypted: i=1; AKwUvBxDyrLuJYFwvbHfMGWZ2gDa19mKxQJD6jsCI4Lrh2ANNZX2Kz4ExDfv6CAdiTqWw2bqecCeKq/LO6Zm@vger.kernel.org
X-Gm-Message-State: AFuF++mT04k8mEsXdUN/ZhFyYqtY63OIvuRZVyb0TFogIyiLfVq1fVkM
	kNJFupi8Gt+W/kU2bSp/b/YX8rpirQgrkRwsHzhUJ/+luKEdwZGrbiIE
X-Gm-Gg: AYBFou1QNowF0bYd2i87h1JddBdlUUrNivgFv1PpVAZ/uRtgfAdlx6y88o1/3/l0JQG
	y5mQokMOYITjo1Szq0iutp8Y5QZMr1XS5q6Q7aFQFfK/U8JgLrXcb28yLQmZpW5g8L13UfV4gob
	piWouK8GVyo9enXjWi2v8vSWo/LgG8MLA7h2j+xvCh3zK+cwJpJ6UhGCn1vnbnhAURUU7IMIwWx
	qBTun4qlWEQEyRDMh5Ha+UXhY7F3GYIJzf8RGqzaDQjgfDhnhyda/KESCY0t7Dw9oRaAF8mpdw0
	6yMRh+AzXSVmTHIbVKNU6D0rKxdvpXDbQdHGHdhBCb6oJbJkt2r0J1rQ8PNLJM3MtIpbJT3KQxa
	s1H9/0fV27DxjmB5GxzL1gvJEOUwOQek1Rjhs8BwuZCsp+rh2IcJvqAhUfhb4vLH/TuPNmmdWdI
	UKYTnPdSA2IYHupJM66HV+zo1k6uyGWBDSOcsiHyS5aQYIvACxuSc5UFFup8XXQmEw9oN+3lB1e
	QfFW/MhSitFxAFD2C4Ha7LaTETfqCnhPfK0
X-Received: by 2002:a05:600c:138b:b0:49e:2a61:a17b with SMTP id 5b1f17b1804b1-49e2a61a41emr9166915e9.5.1789032546119;
        Thu, 10 Sep 2026 02:29:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fc23fcsm106027125e9.3.2026.09.10.02.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 02:29:05 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:29:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Alexey
 Gladkov <legion@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Jonathan Corbet
 <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-efi@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 04/23] kallsyms: output binary data to speed output and
 kallsyms assembly
Message-ID: <20260910102903.1b211f6b@pumpkin>
In-Reply-To: <20260908-build-speedup-v1-4-5dc1ac01672d@kernel.org>
References: <20260908-build-speedup-v1-0-5dc1ac01672d@kernel.org>
	<20260908-build-speedup-v1-4-5dc1ac01672d@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Sep 2026 21:55:04 +0100
"Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> kallsyms generates an assembly file that consists mostly of .byte entries
> containing compressed names, token strings and name-sorted sequence
> numbers.
> 
> For an x86-64 build with 158k symbols that is a 37 MiB .S file which takes
> 0.57s to assemble each of the two to three times it is built over a kernel
> build.
> 
> Each time it is generated it also takes kallsyms a similar amount of time
> to output it.
> 
> Avoid this overhead by instead outputting this data as binary and importing
> it into the assembly using the .incbin directive.
> 
> Tables that are wider than a byte remain part of the assembly to ensure
> endianness and relative relocations are performed correctly.
> 
> With this change, the output assembly file shrinks from 37 MiB to 9.8 MiB,
> with a 2.6 MiB binary data file alongside it, and the object remains
> identical.
> 
> The generated binary file is deleted correctly on build clean along with
> all other ephemeral data.
> 
> On an x86-64 system with CONFIG_KALLSYMS_ALL set:
> 
>                        before   after    delta
>   scripts/kallsyms     0.24s    0.18s    0.06s
>   assemble             0.57s    0.16s    0.41s
> 
> Per kallsyms invocation/assembly, for a total of 0.47s time saving upon
> invocation.
> 
> An incremental build on the same system was reduced from 11.15s to 9.65s,
> indicating a total of 1.5 seconds saved over the build.
> 
> The kallsyms runs and their assembly are on the serial tail of every build
> that links vmlinux, no-op builds are unchanged.
> 
> Whole build, 128-thread Threadripper 9980X, best of N runs:
> 
>                                          before   after     delta
>                                          -------------------------------
>   x86 defconfig, touch mm/vma.c, gcc       10.8s     9.9s    -0.92s (-8%)
>   x86 defconfig, touch mm/vma.c, clang     10.7s     9.5s     -1.2s (-11%)
>   x86 defconfig, clean, gcc                29.5s    28.7s    -0.81s (-3%)
>   x86 defconfig, clean, clang              29.7s    28.6s     -1.1s (-4%)
>   x86 allmodconfig, touch mm/vma.c, gcc    45.3s    44.0s     -1.3s (-3%)
>   x86 allmodconfig, touch mm/vma.c, clang  42.9s    40.2s     -2.7s (-6%)
> 
> Assisted-by: LLM
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  scripts/kallsyms.c      | 97 ++++++++++++++++++++++++++++++++++++++-----------
>  scripts/link-vmlinux.sh |  2 +-
>  2 files changed, 77 insertions(+), 22 deletions(-)
> 
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 350d118c3b9e..61c5eb537ed4 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -5,7 +5,10 @@
>   * This software may be used and distributed according to the terms
>   * of the GNU General Public License, incorporated herein by reference.
>   *
> - * Usage: kallsyms [--all-symbols] in.map > out.S
> + * Usage: kallsyms [--all-symbols] [--pc-relative] in.map out.bin > out.S
> + *
> + *      The byte tables go to out.bin and are pulled into out.S with .incbin;
> + *  wider tables stay assembler source for endianness and relocations.
>   *
>   *      Table compression uses all the unused char codes on the symbols and
>   *  maps these to the most used substrings (tokens). For instance, it might
> @@ -102,7 +105,7 @@ static void sym_arr_free(struct sym_arr *arr)
>  
>  static void usage(void)
>  {
> -	fprintf(stderr, "Usage: kallsyms [--all-symbols] in.map > out.S\n");
> +	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--pc-relative] in.map out.bin > out.S\n");
>  	exit(1);
>  }
>  
> @@ -319,6 +322,40 @@ static void output_label(const char *label)
>  	printf("%s:\n", label);
>  }
>  
> +static void write_bin(FILE *file, const void *data, size_t len)
> +{
> +	if (fwrite(data, 1, len, file) == len)
> +		return;
> +
> +	perror("kallsyms: write");
> +	exit(EXIT_FAILURE);
> +}

It is pretty pointless checking the return value from fwrite().
Most of the time it is just doing a memcpy().
Instead call fflush() and the ferror() prior to the fclose().
(Or just rely on fclose() giving you that error status.)

David
