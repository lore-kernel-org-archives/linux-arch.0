Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F3D478E5E
	for <linux-arch@vger.kernel.org>; Thu, 13 Aug 2026 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630513; cv=none; b=cN+7KhTQN97TWCtg/PBsi32ubWV2GHN8Z578FyxM7VKpopcRxa3pYXCUGzr4co2N47A2v8z1AH7BaunpFdXu/hz13QXoJQYhkS+aa9jWWytMRyTHMP1u7fRritPDb3C58Wn/3pM2lRAGM8YrPylC87rN+tQHpp28yrmrR3jHhFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630513; c=relaxed/simple;
	bh=BJmgQ0xsWwLek3a34c+eZxt3ELWgWeEXeHtsjDuughU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXnWDWUsA5BHaMZ7LT6JmpOyqMA41qElUHIQV+rh95j7ndYqcBQ/UEwSPKfUl2a3AX0ZN4xfWqoDVXRAAdMduZ4FzSHnjRcGq5kadABkIfYyvO/d9Y6R86/N7XVT+VHloTJvgozMgvIBTVzzNIUOe/71BupM3bD5iq/Ax4K7g3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TNKwobiN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TNKwobiN"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954d29264cso10975865e9.2
        for <linux-arch@vger.kernel.org>; Thu, 13 Aug 2026 07:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786630509; x=1787235309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=in6woJYFkc39bFtfodNqD0fkpoWFu5/eR61xqqy33mA=;
        b=TNKwobiNDry3Jg29pIVwqvbGOSLRwhjctHlglRVHgFA+h1A4RzTLVpgDAXfIKopaHP
         tubDpQuDDPFpTBWHmhwje9fX+uDhhch+AUD1KSzQ25xIwxTrXD8sr30mpaTGvnNVRIYm
         dBvHdInLOtGbZY2t3UUaDftXbV5VjABV9/79tSmw1kWbcT3ngOR10XMtQmi0MowPGITA
         TuEb+IeLRTv2nhdAuEUV9Uap9h7GJqQUu1/YxYWzo6IcuojhYKzYExWow6lPi/ccNK4v
         4d+oI3VqBdKxJF9/6AyRp6jyUeMgOKpQKrQwsvJbt/YJgEevsxWKyRrJcYCds6sUBT8c
         TZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786630509; x=1787235309;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=in6woJYFkc39bFtfodNqD0fkpoWFu5/eR61xqqy33mA=;
        b=bhFeBF0AZeMF0zSmmO/onbKlFG1drhABnR5eqJSLp8wecglKIhYIy0ymbXQoKgbJax
         BqM0T153C6e6zTi8X1AQ16v6cIqCfFQ0yD4JUhBGQlfIUJWtukD5W6y0cxrJhrKgIBuH
         Cfp1jx3/M3VVYN8+imI292eYtJd8/5ETGShjw1B30zMPLglUxZas/CiZeZgmwnvN2ZkY
         kMjiLtD0bYhC53OrMk07WqPuBPSwIKwGeARpXazfAfnr7ip4ccobebR+ZH20vtcAvxFO
         vX3NV48cSXvgfE33jNOG07Qb2ohHxxQVSDrJ5mSJ9pMCG9GSda3x1bTF8+tVDgmFL55Z
         Xorg==
X-Forwarded-Encrypted: i=1; AHgh+Rpi08RUGiZUmj41bCd2icduScydOJP1D7NQ5NlV1iQYlZv5tOWKryPIFPbYC+hkPPTM/lnWuuFnFHsc@vger.kernel.org
X-Gm-Message-State: AOJu0YyWNdEnWxOprVJN1gl3FZdKuWklxSrz6nLFVbd0rnlLMEBqiR8Q
	wkdxNIUcV871pGDdw0o8/Pagf2hqbh6I5yshFlg8SUcwhogcQMQuAiib4mr1l68wC+4=
X-Gm-Gg: AR+sD12fv1pbuoNmAymWW73GRf0evauTWO9XiI1ItwAoCR1JJp9CrmJGm02hDvacOOS
	2d/1tb5cFm+f9ytg7DWbEZsepn93D9cjkyNBy0yDu8SSDPogbpNmBbdlHYWRt6ywouH1ujmJ6pM
	1m6xte0XEXJVZ3n3QC0h7wh42vOPcGWzTjOLqUGO8Ccvl00h742t4WuoiOjLVN59h2MsEiksiS5
	OfENfnm0kiT2vHqQfGVJGRXkQxd7zAo+SXnlAXWQrq0/NnuQfb4U+ZBy8Icvgpk6uExp/37H9HS
	UWe6ZNFWxI/jLkleuTFZbBe5olCkzlvQfFKFCWHDkAzZmg96ls3SB1io9Yj6C99OesoGO1OYDp3
	Xpo5jg0Ln1ah2ZKv5fwm266vA9DrwxxzHgC7bXIEqqRor1yJtngFYfeXod9kaahaTYaezCnzhMR
	ZgSyDkvPZ4tRCwOkrhPNb8jsWe0e6c/AzWsPqYmevUnicIPOR42ZRgZHCwyPnI9sJkhu1SPkXPt
	5X2Yl5OtMidERdkr4UiFhpJZw==
X-Received: by 2002:a05:600c:6995:b0:494:596e:e8c4 with SMTP id 5b1f17b1804b1-499821bdcadmr82447915e9.17.1786630508708;
        Thu, 13 Aug 2026 07:15:08 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4998212a011sm62452805e9.5.2026.08.13.07.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 07:15:08 -0700 (PDT)
Message-ID: <af6aaa0a-03de-4175-84a5-7c253198d184@suse.com>
Date: Thu, 13 Aug 2026 16:15:05 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/2] module: Extend module_blacklist parameter to
 built-in modules
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: arnd@arndb.de, mcgrof@kernel.org, da.gomez@kernel.org,
 samitolvanen@google.com, peterz@infradead.org, ojeda@kernel.org,
 akpm@linux-foundation.org, mhiramat@kernel.org, boqun@kernel.org,
 neelx@suse.com, da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com,
 steve@abita.co, mproche@mail.com, nick.lane@mail.com,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260807012601.360452-1-atomlin@atomlin.com>
 <20260807012601.360452-2-atomlin@atomlin.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260807012601.360452-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/26 3:26 AM, Aaron Tomlin wrote:
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 5659f4b5a125..799d912dcbc0 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -734,7 +734,9 @@
>  	EARLYCON_TABLE()						\
>  	LSM_TABLE()							\
>  	EARLY_LSM_TABLE()						\
> -	KUNIT_INIT_TABLE()
> +	KUNIT_INIT_TABLE()						\
> +	STRUCT_ALIGN();							\
> +	BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)
>  
>  #define INIT_TEXT							\
>  	*(.init.text .init.text.*)					\

I realized that instead of using STRUCT_ALIGN(), a cleaner and less
wasteful approach is to prevent any potential over-alignment of
individual .initcall.modnames sections by having
____define_initcall_modname() define each `struct initcall_modname` with
`__aligned(__alignof__(struct initcall_modname))`.

> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 06c18e207508..13353b43b38d 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -479,6 +479,7 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
>      let ident_init = format_ident!("__{ident}_init");
>      let ident_exit = format_ident!("__{ident}_exit");
>      let ident_initcall = format_ident!("__{ident}_initcall");
> +    let ident_modname = format_ident!("__{ident}_modname");
>      let initcall_section = ".initcall6.init";
>  
>      let global_asm = format!(
> @@ -590,6 +591,21 @@ pub extern "C" fn cleanup_module() {
>                  #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
>                  ::core::arch::global_asm!(#global_asm);
>  
> +                #[cfg(not(MODULE))]
> +                #[repr(C)]
> +                struct InitcallModname {
> +                    initcall_fn: extern "C" fn() -> ::kernel::ffi::c_int,
> +                    modname: *const ::kernel::ffi::c_char,
> +                }
> +
> +                #[cfg(not(MODULE))]
> +                #[used(compiler)]
> +                #[link_section = ".initcall.modnames"]
> +                static #ident_modname: InitcallModname = InitcallModname {

Can Rust directly use the C definition of initcall_modname via
::kernel::bindings::initcall_modname?

> +                    initcall_fn: #ident_init,
> +                    modname: #name_cstr.as_ptr().cast(),

Can the modname string be placed in .init.rodata to match the behavior
on the C side?

> +                };
> +
>                  #[cfg(not(MODULE))]
>                  #[no_mangle]
>                  pub extern "C" fn #ident_init() -> ::kernel::ffi::c_int {

-- 
Thanks,
Petr
