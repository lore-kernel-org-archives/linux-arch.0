Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F79853D0DC
	for <linux-arch@vger.kernel.org>; Wed,  9 Sep 2026 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967976; cv=none; b=NfL4Nm28JZyQpK5Rn3kjM4f7JcaElgH3F+S4yUW3Ov5DXSvyVrgWKz8q58xnglpsRPKMz4jT1oL3sXtxJD1YNg0WU8LGF/qvCtQE9yGMO84Ez6DyS87dS+IBER5InKIGFKlX65Q5riZ3MEdWamnl81Khm4RqHj2Fn7BcA3t+r+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967976; c=relaxed/simple;
	bh=t3yqbvSqtFoLUHow+WwPXXOfeaEh7bClm80fMM9rQTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJEAaL60ulgIj5OwtZACUuwT26FDNMBZyH+PpSPxWuu+x8wRgn1bVTWkaw10BZnIAdZFYoUY8BKasv2bjCvAimH06Udf/4C/9dPrCt5GjcuTmwLQBjcbkSAWZY/wXZblcoozuGYtZWQ2ez/BLn9q5RKEkfpBju7zVoUuakmJsOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eaorY0dt; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eaorY0dt"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b89986bcecso248957e87.0
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2026 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1788967971; x=1789572771; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/FowYqhA2IUhImtOTNUOvZbuU0tnu+Lv5LcROnzCHgI=;
        b=eaorY0dt6FdoMo3JnTdMY9roBq3FJe1wpICLut52/9QQ7wPk7/qlSNGPxT57eFhmz2
         twwNk9QFTaintFk5PCTWTXumwXVmikVfjt3zv3XRgJUbEyUGoBiNHGPmOR2dllxXHg4T
         iaNRbVSv1ZpqlN2tkwzv2wdRpWsW0NTrfiIJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788967971; x=1789572771;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/FowYqhA2IUhImtOTNUOvZbuU0tnu+Lv5LcROnzCHgI=;
        b=su1YQwtO5KKctfgV/nsEzfbeOFgHKxv8mP2P8lReCFgpt79WBwbEvEPTG78I2hNs3v
         VyqP/XjBSBvCsCjfsYvFPMpfNM5xJuhXuFlJZ5lz6us4kHnY+tuQAoEa1FCHDTV5Qftf
         qM3X9W7RGNZJ4N1KD4pFxj1cTurS/9GwfWCO9/8RFqPVKylEjV7hUVsDzMpiuqw1aTLo
         CT8BGZDLm7rtNJzjsmNsqcTc9t9de+zdpzwHx3bPxhAriMEzmUex+sWFWvlqqTVpOP41
         L1zddowj+KRX5TxPS7naEbLZkLh8f1PqBBvmj47Qlk7bPCjjaBffaGDhfQu63g1isKYx
         u4Rw==
X-Forwarded-Encrypted: i=1; AKwUvBznWc2nxObCvY5fAZbMJ/z9jI3efySuDUKmMAkRsZhd28R22V6xpv1XENR1Nj6ma1pv6Ck+xzm4qOlc@vger.kernel.org
X-Gm-Message-State: AFuF++m6Ud7TBYA/Hn/fKEHs81oDA/6m+leQPaex5R+tEYof5M2uZ1Ga
	33iib2TGt+5dgowVfRlHwpFFSp+FDHUFQq6/4xrpsP2VB1Kss6LjkFXXLWAda8cwAmzG+wUzyuN
	+GoaBxHDtsQ==
X-Gm-Gg: AYBFou3GO08hOuukTWvhOy5onxgju3dyskp3IptronuGzrNuYEzzte1Vd3QzO2O0mdy
	Hmb276uXmLMHw2kU+hvwfUcSX03e/RS1Mn8QE1O53qRy5yibWzG988b+m7d8r+7D4b6y+uufaJ1
	ZHwYDSBewAXq73uJ4ijaL+9P3oEiHVbj9I6SDGCRTuYq1cMrFq5eF+aiTi0OvIiy4BoKCFKljWz
	Nhzcs/O4z35VrQ6THFfsYdR/78EHeimZQTpQmOsPuUUYz1gBAsJhTERTNY5FzZTeOhwj5FNPsIV
	67dgVKd3SWJSJBsVKw/FBqoP8brRoXDxGyssIftrTQ+VlABy+XG771ka55hop2FlWmq3DnDnpVx
	BlMNqfMIXYJcPQKC9KBnCqMbz8g6Bju85JsEFmYb61A0YXTUxE/JF9aWTdLIkRvSRl7HccdHOJe
	Od6y31NYAbQjhTSABnp+MHe1zatKbUBG8HHFIPgWnx38Ib60KwdxMFj5AbxagU+ikvvVoNbRGoC
	bXeJpU60kJTjY7EV+XlD4FjwlOpMN1TB3Ji2QJVH3wZHxWr
X-Received: by 2002:a05:6512:3c8e:b0:5b7:6767:2005 with SMTP id 2adb3069b0e04-5b7676720e5mr922044e87.49.1788967971238;
        Wed, 09 Sep 2026 08:32:51 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8995ffb0dsm207010e87.28.2026.09.09.08.32.50
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 08:32:50 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48589798dbbso4953223f8f.3
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2026 08:32:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzYFnxTP8uXS2mdAFTVxOqDxeJ4mSmWKp3QPJyxVXvlE4JgfWnkOIP5lFxnWgx+389jCjWvShIjl62o@vger.kernel.org
X-Received: by 2002:a17:907:da4:b0:c26:1649:47af with SMTP id
 a640c23a62f3a-c26164955fcmr1368813666b.37.1788967618809; Wed, 09 Sep 2026
 08:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-build-speedup-v1-0-5dc1ac01672d@kernel.org> <20260908-build-speedup-v1-11-5dc1ac01672d@kernel.org>
In-Reply-To: <20260908-build-speedup-v1-11-5dc1ac01672d@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Sep 2026 08:26:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiA_UJbKiu8fOezKV=MfEcaFuzZiuk8Fto-Bc1KrA=43Q@mail.gmail.com>
X-Gm-Features: AcwNN1UWYYtk4z7iDc5cI-l9BNT1_XTZBZ1EzZVT-QGEk4RrzSdK76DVFXE4iKE
Message-ID: <CAHk-=wiA_UJbKiu8fOezKV=MfEcaFuzZiuk8Fto-Bc1KrA=43Q@mail.gmail.com>
Subject: Re: [PATCH 11/23] kbuild: implement and use depcheck to check
 dependency timestamps
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Alexey Gladkov <legion@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Sept 2026 at 13:57, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>
> Each object's .cmd file lists its header dependencies, which often
> consists of over a thousand dependencies.
>
> When little has changed in the tree, this is what make spends most of its
> time doing, spending over a second, single-threaded when parsing larger
> directory trees.

Side note: from some kernel build profiles I did long ago, I have this
memory of it being made much worse by the fact that we use

    "$(wildcard xyzzy)"

for all our config header files in those .cmd.o files. That then
causes extra work for 'make' for all of this.

And we do that 'wildcard' thing not because we want to actually match
a pattern, but because that was the only way to have 'make' not
complain about missing config headers.

I'm not even sure the original reason for it is relevant any more -
this is all a very dim memory from years and years ago when I actually
tried to look at profiles of 'make' itself (normally when I do kernel
build profiles I only look at the what the kernel part of the build
is, not user mode).

I just tried removing the 'wildcard' generation from
scripts/basic/fixdep.c and the kernel build didn't care about it at
all. The whole 'wildcard' trick goes all the way back to the original
commit that added that whole 'fixdep.c' phase.

Maybe the whole thing is entirely stale now and should be removed. I
probably just didn't trigger the situation where those extra
'wildcard' things matter. That whole thing is from a quarter century
ago, and nobody has dared look at that code since..

Or maybe 'make' is better at those wildcards these days - or other
things have shifted.

From those dim memories, make spent a lot of time doing filesystem
lookups (directory reading  and 'stat()' calls - the wildcard thing
triggered more getdents calls), but even more time just in string
handling.

               Linus
