Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A97548B37E
	for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998612; cv=none; b=bwGB1dURMG29r88MipHRxuTwbRlF/h4k3CQnuTi8qOYLZAVHJdPORoXOlzjyjO8ZjbUMdwpZmci6yrVUIwdYShQqMHIfW91II4TMhbJDlosVcdNiyavEIrmxkOe+yVS1vG0Wa1aycbga/DwJtciZDfANui/M075LGqokLzuiTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998612; c=relaxed/simple;
	bh=5UQ+/b9voSw2XbVSVpGgsHCN+16v45r/eO2PjQuRZp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBkV3freJz4yg2PyqNsETsI5vqw3QPUUscgEEIv20UOmVG1y3zSR05aexnNvK5779J+1isY2X26R/F9P+UipScUXTnDi0MxHqa9IFYepBh0ibQfGCcZZm7mJYDe4WiJ4Hgc7luGeOF5JiLMMaI3ITCFnBg/OE9mvPI3PTOy/Hzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dA95zy47; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dA95zy47"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48586861639so1192571f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2026 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789998608; x=1790603408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J4xPQrVJdFgFl8luzeo5fY/IUnv52YMtHgLJT02PkgQ=;
        b=dA95zy47+9E+6Wj7pNYsrxpyB60MgweGLYJbZWECxloBtnCxSAfVgRTPb4n832bVN4
         ioIHKLkAkdYc7/JT7hGCtIW/h2DDR9L2+ZHYH1NwtM/zrWohbxtmzZMw6cpxK0JyfEtx
         AqkpxNrZ4pSf2uRNpuMoQAp9vqC6PLpWHJOOI82PimUrE8ewf1JfOpaqogd3nTsoLHUR
         8ZVxLQrp1IZp55/gmH4uCmtu+XrmMNXsUWSLSAA3NFPhfhJvcGZvneivOdCykpCzfQUe
         2ywIwODlr+jiLKyVnmujMraj7i+JFm9NAOspeLiIoPsIhZ3Aj9oHVhk+dIPIc5eINdGB
         UhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789998608; x=1790603408;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J4xPQrVJdFgFl8luzeo5fY/IUnv52YMtHgLJT02PkgQ=;
        b=rpsplYWDRSoBnTtzxRsuOWAVt2BzBdMQ5l+vP2iqcZuqOzdUDU+9OJ9GYdOwyhmqFV
         vUAkDl/DDVXHqtYuDbdcx5QWhPOBLnBTxlLR90KVlSUk/wugRi+OnhCCgdj4w1GMvLxf
         /eTZpreeikBR9rU2Vmc+NL34jz1n1+09hxdM4ETNnqV8POs7s6efCAi6Zr9RX/LbMXXK
         VfuCFveHBdlD73aKJJkTFtdiItST+PYUJMftbgc+gUAMGWJdQXhfjm+WISeRBioAVP28
         BU7VYecWlIT6JgIFZemJmn/vevqAZdvjo8L/D1WDsx0MKSyDoSjbIIj8TYqwd3cD9Nwz
         dcgA==
X-Forwarded-Encrypted: i=1; AKwUvBwSq2XllUbFF4qoNeB9sx6m3oAbF7Scuj++itUfuLz2ohv9fHk/iXoVQlU+4sOggE0BYQYh+h1GUAjS@vger.kernel.org
X-Gm-Message-State: AFuF++lcrrf0nqPCmMlZrUzqXpNeQuX1Kf31BSrlp1Ar2hqjMC+X/Vr+
	hr29qZSMA3jBypTvdIlye2raLJ1P721eUY4wG84E4gPcG2ItpKAuOONijQJbi1gqaX4=
X-Gm-Gg: AYBFou1a35gG+tkbJro79rINvM0MXma9BthtUOkjtGDcjbYU0xxMnUoJqsGfYR451Xi
	PPsZEaTNm+nTrlWQKHyF+S1mzJRFpnFY9VDF9F7BL6hKP1yu70dHy4WAYYKlREy/WtHxBhQO4Dh
	PjwHeXzMJsCCPAqUyLQ2m40JKZXqlG2YH5mvczbZN5clEABo2SSiio3mGplG9jn9DiscxG/5crc
	n7Vtw2MT3hc1IXpXBnqL5znktLvO/SRDc04U2CRFbfnhknyEPVFvQdsRZzjvjMvj22ZinRZI4oW
	LNSE00Sv9S3DIsW5/tR+OzziKjNNPCXoOf//sZR+AYTY7sis9Q/Zbn2+wwIE7uCt0vrXWmRqBd6
	64YGWTFsTYzIeXYaUZ9AcYVKJ8qUF2cocpDfpsRUfYc7EtrlHZr+TCUzMxxnGoQFkSqBcsJZISK
	wSDOi1qfkyuy3ggy7Ry2TuPYQZCx2GTvFyf1TVQcxfyTMzPHqEkWBG20ogsjvmEo2cOmGCaQ4fI
	s9EOvifZ7+3mCWP8K7lOZG2u2fj1WX24YA=
X-Received: by 2002:a05:6000:64a:b0:487:c3e:d6cc with SMTP id ffacd0b85a97d-48713c7f005mr24266022f8f.31.1789998608134;
        Mon, 21 Sep 2026 06:50:08 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724596604sm23426141f8f.30.2026.09.21.06.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 06:50:07 -0700 (PDT)
Message-ID: <58605613-8a43-40e7-a00a-b0d09f089ec8@suse.com>
Date: Mon, 21 Sep 2026 15:50:06 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/21] modpost: emit module descriptors as assembly
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
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-efi@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-hardening@vger.kernel.org
References: <20260914-build-speedup-v2-0-39817ec5db23@kernel.org>
 <20260914-build-speedup-v2-13-39817ec5db23@kernel.org>
 <95baacfb-d8d9-4d2f-bc89-592df6f6f8e3@suse.com> <arEZrFmXeCO4hZpP@gremlin>
 <2b27bb4b-47e3-45ed-a26a-4b9de2b20542@suse.com> <arEnCzzQa9XDd4LT@gremlin>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <arEnCzzQa9XDd4LT@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/26 2:48 PM, Lorenzo Stoakes (ARM) wrote:
> On Mon, Sep 21, 2026 at 02:36:30PM +0200, Petr Pavlu wrote:
>> On 9/21/26 1:57 PM, Lorenzo Stoakes (ARM) wrote:
>>> (note there's a v3 see [0])
>>>
>>> [0]: https://lore.kernel.org/linux-kbuild/20260917-build-speedup-v3-0-9ecf4163ff36@kernel.org/
>>
>> Thanks, I missed it.
>>
>>> On Mon, Sep 21, 2026 at 01:25:09PM +0200, Petr Pavlu wrote:
>>>> On 9/14/26 11:22 AM, Lorenzo Stoakes (ARM) wrote:
>>>>> The sections were confirmed to be byte-for-byte identical to the C version
>>>>> produced - each of .modinfo, .gnu.linkonce.this_module, __ksymtab*,
>>>>> __ksymtab_strings, __kcrctab*, __kflagstab*, __versions,
>>>>> __version_ext_crcs, __version_ext_names and their relocations - for all
>>>>> 8,135 modules of a clang allmodconfig build with CONFIG_COMPILE_TEST off
>>>>> and CONFIG_MODVERSIONS, CONFIG_EXTENDED_MODVERSIONS and
>>>>> CONFIG_MODULE_SRCVERSION_ALL on, and for a sample built with gcc.
>>>>
>>>> Lowering the data to assembly loses debug information for __this_module,
>>>> specifically that it has type `struct module`. It might be worth
>>>
>>> No, it keeps it - every module includes linux/module.h, and the extern
>>> declaration of __this_module carries the type, so all of the stuff gdb
>>> needs (e.g. ptype, p & field access), DWARF etc. is all there in the same
>>> way as with .mod.c.
>>>
>>> Have confirmed locally.
>>
>> An extern declaration alone shouldn't cause its name and type to be
>> included in debug information. They should appear only when the variable
>> is referenced by some code.
> 
> Ack yeah sorry my mistake, I had the LLM check that and should have known
> better than to trust it without reviewing what it said (as I have done for
> the most part for everything in this series).
> 
>>
>> Testing with a simple module that previously referenced __this_module
>> only in .mod.c and in no other file, such as lib/test_module.c, shows
>> that the .ko no longer contains debug information for this variable.
>>
>> I've verified this behavior with GCC 16 and Clang 19.
> 
> Ack confirmed locally.
> 
> Can put a fix in module-common.c.
> 
> The LLM came up with a reference as an alternative:
> 
> static struct module *const __this_module_dbg __used __section(".discard.this_module") = &__this_module;
> 
> Would that work? Or should we go with your original suggestion? -
> 
> __weak __section(".discard.this_module") struct module __this_module;

With GCC, the LLM's suggestion produces debug information for both
__this_module_dbg and __this_module. However, Clang only generates debug
information for __this_module_dbg, so it is not quite what is needed.

-- 
Thanks,
Petr
