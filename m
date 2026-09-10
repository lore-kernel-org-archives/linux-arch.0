Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1446B489FDE
	for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2026 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044777; cv=none; b=DgMKTGAabLXORJbguTsPS8YdbL8JpY9cBhOrvXIta56YA6VNMswUDgrNH6BMgklLEzu8YUqERu8ri50hZpkXpVQxu4pqsozrT+OSc7Mp/K9FvGaqPsieFy/KWqkzv1qDRUBnl7F8Net/YzV4N7GjdnOEFA/FTS+eCspMP7OWkro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044777; c=relaxed/simple;
	bh=aV14/F8DsF3P9FHVwJuzeIJuUW3zK2f3SCDMKZGJuA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGAWKKV13/PqEr+Q3lrrgjvlfuwO2BAWvEOSX+4b6d3/etDBqcYBZEMN+dFkxjtS0TOMpXLK3EVczO7lClG10nELmt0pHZcIJ9aA7TNfQ+V2tUInlHEf3Q0DDjiaE4j86ITg2Pf/U8/IhyG9/9wW5i69yhhhAtnRNulhRxletoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SmOKr973; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SmOKr973"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so55292595e9.3
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2026 05:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789044773; x=1789649573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ei/562soKHFJqkSdXuQm6X1dYNc/yFpT8LphVTPsPBs=;
        b=SmOKr973K1dGCdZNSvV0lZ/+KT9BbRIbD3GOIAibUNJ0qhDjKzaJljF4LSPNkW8bB2
         HuTx1PLTDPwTxnXLhGLdkAB+yvGjx19FpTMhto8pdD8XeVAybuZ6v45GmuegsUQbFv0A
         r5tsiGJMyJ+CTV4L29p8/OHBuCB/Jv4TyJDThI2FdXmhKsIpiLaS2/EUJrwO93TPodLM
         CS3eFxLcUy270ZtNSYfcBV/5plhB6VvhVqoXJOjiOa42xr9jJXMrxMP9H279UkBdc0Z/
         dKrfOKBdlY7oe1AphxeGiXttM62BubLUX+lzyjnDKsH9lJcugdc7BQzMz+jFCDx1qj7d
         IryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789044773; x=1789649573;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ei/562soKHFJqkSdXuQm6X1dYNc/yFpT8LphVTPsPBs=;
        b=iG3061wwDQvpRO4KTY857Ndx3DW++Tq9pBLZ3TRFxl8W0ugxyV9n/U65dqOnL3w6VD
         nK2E4r1IQLyXHltV6GFLkDrcMY0L7vHwcrZ2QwsZPqMqLmG5sueyFeUEtaDJL9rRO30c
         qYiStrn+TcHgMTmQvpjIiEl1PhisnSbO28luYptxMLKmrTMOCBuFB8mbNgKUQ4/ecBPS
         h9LiaBB391wnT7IdXvAfZqOZoiaX04EXPwe4+GVmOyXZ0F/r3vOj28ezfVv5icPcnEJ+
         32WftOwHgxqbV/wnPiBTgBcDxJljAbciR1bXwecNfvqbyTPNX7HOT9+3BzBrj/DwLJpd
         LqGA==
X-Forwarded-Encrypted: i=1; AKwUvByP2a65ApZBuAZqvrJJ86Czd9nZMSfzBNQuAR2A+RpAhyO5WLMuZVEVoYwwaclEcX3pfl9u3nB6VwGw@vger.kernel.org
X-Gm-Message-State: AFuF++mtqRMB/MiGSgGAPtxe3h7YHNSEV0zF+aGh/KfjuFV2gc7vkmc9
	fr3K5J8opswRRMuyFNnFcLXDRCXbzAj2cp7nSrPPsLMFWzWexOQIobuBgCU+5EHhp+8=
X-Gm-Gg: AYBFou2W2Bw1mtzK9ubfuOLziiV7kHJbSal/aSrHlllSlABEjklQMWJ2fkwUA39c6lL
	M+6196ky3ejGtOvPzl2c62T1k80a4dt0DPko8nMYmo5mo/wXtR+zZqbGTtrNtjDqigT2rsme18k
	VXnehpzbr1GQjdL1i9Qf/xNiTmntAlTbNcJAfsBFC5dXK9CpxdHxHkJIdmP1YZTBX4oorQH6YzF
	yL6e+VZEBMd8Wvl7Iwc+t8FBOVDbnRmDvvxcGW1bgpz7K7dyzOuRKqY4j/IVxWLjuEpkz/JlxOU
	rHqd39D2gfPACXC5oZvPAsbFUatjAk3yziHaJ64Oq49s/7IZjfYGqfikxddqQTPuqQFYVabAFki
	DVnJtP1gMIAvmEkBMge2nMoF122dXAEkGGU5UpQt+kKytND0Rrp9lTWdS8lDjFqkk17imDPlbk3
	rj1+mCXXJ3wTj3mgovB8yWvu6x1UWt8Yih8+dIC0UJ62Hk5VIPNihf1di8IwXZGmtDJh+U5pyhm
	93wKTa9D+snYlB1keGk3VUuo8e2GMTjmzc=
X-Received: by 2002:a05:600c:620d:b0:49c:fc6e:a3d6 with SMTP id 5b1f17b1804b1-49cfc6ea731mr404244015e9.21.1789044772934;
        Thu, 10 Sep 2026 05:52:52 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fce7a7sm286173185e9.4.2026.09.10.05.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 05:52:52 -0700 (PDT)
Message-ID: <434a7a10-d83e-4402-be91-816bbbc15bb7@suse.com>
Date: Thu, 10 Sep 2026 14:52:50 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/23] modpost: hash module source per-file, not per-byte
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Alexey Gladkov <legion@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-efi@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20260908-build-speedup-v1-0-5dc1ac01672d@kernel.org>
 <20260908-build-speedup-v1-13-5dc1ac01672d@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260908-build-speedup-v1-13-5dc1ac01672d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 10:55 PM, Lorenzo Stoakes (ARM) wrote:
> modpost spends a long time md4 hashing module source at a per-byte
> granularity.
> 
> Fix this by doing this hashing per-file instead by accumulating a per-file
> buffer in parse_file().
> 
> All 11,189 .mod.c files and Module.symvers were confirmed to be identical
> with this change applied.
> 
> This is especially impactful for allmodconfig incremental builds (where
> CONFIG_MODULE_SRCVERSION_ALL is set).
> 
> Whole build, 128-thread Threadripper 9980X, best of N runs:
> 
>                                          before   after     delta
>                                          -------------------------------
>   x86 allmodconfig, touch mm/vma.c, gcc    40.6s    38.2s     -2.4s (-6%)
>   x86 allmodconfig, touch mm/vma.c, clang  36.2s    35.0s     -1.2s (-3%)
> 
> Assisted-by: LLM
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  scripts/mod/sumversion.c | 56 +++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 44 insertions(+), 12 deletions(-)

Support for the module srcversion is being removed in "module: remove
MODULE_VERSION() and srcversion" [1] and scripts/mod/sumversion.c should
be gone completely.

[1] https://lore.kernel.org/linux-modules/20260731-module_ver_remove-v2-0-c9163858f382@linuxfoundation.org/

-- 
Thanks,
Petr
