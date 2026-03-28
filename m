Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704F631A07B
	for <linux-arch@vger.kernel.org>; Sat, 28 Mar 2026 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774723989; cv=none; b=j+4uxsoW6AI2ygR/Qwxa0gUuwzdqqxS+AtRfNvwuWTrt/iHUoIu1sHCY18h74ss9AH1ZrmmeJKDB//SvKOm/iRazlLVpefgasUKjl7GRCZWetzWcmRV3d016NKK7e0LkTtDhpas3TdXhXfhwmZb1bOz4Is0DzIEJKMJNqrZfRuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774723989; c=relaxed/simple;
	bh=PdF+IUwOUAItXih4lg94krJbAj+5MUazJ+AnaPluRlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVHXE8X02WxySuM0EBiaUbYGs6csXc/Q8pKDGGUHIkLGL5SBZHYU4PFMBme4TZJV8StZRdLu1JLnPlg1wTZGnipLBEcjrA6tjlXa9DopNe7ZfuDaab6pfMvS91zcvPRJ0vTzrilnTUK40e9HacC3ZNVVLLDuElYt18JJ3eFBXbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Vow1UXV5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vow1UXV5"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9795ca4e6dso502427266b.2
        for <linux-arch@vger.kernel.org>; Sat, 28 Mar 2026 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774723985; x=1775328785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fKw9yObvBk4iOKmVCaU4AcfANw+QwikrFDCRJ5rrSMU=;
        b=Vow1UXV5kui3L5Eg8k5Rlhe+4e6TENntzPr5hAkUGDOmxq7JXfSRx8e6QlffZXLnQT
         wWWwloPGr89ieqh1CzJwLu99ptpaSwnK3vr/drrC55mGcHNojJfBDyb0YWqRGNI1CFCn
         LtmF8+8bKbcJ8MDBNFPlPCcQGftsiQZ1uGX94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774723985; x=1775328785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKw9yObvBk4iOKmVCaU4AcfANw+QwikrFDCRJ5rrSMU=;
        b=jm+1I0xWOR5XmNV2EawJwPU9aApVC3suS+jA6nAkzDwuaiblGuyQ9E3HoT6VKwVDeP
         hjMqqH3qK1FxdLjUTYGz2A9Cfi9QinkghTZIos15mfl9iL7ckvNC0+N8KeKMcXD2EE3I
         OimjCq8O5ilScPWtccTZyNkIxC20PyTmw0xRkbKPFFv+sXrAFFfgdtvF2HL494ZO6tWI
         pazdBBTBh+hKT1MmMJclLfgcHQyxIpYvESg/YBhAIg595uycwxMaU2n07tOiOw0zHteW
         FXZNaBTZBYIA52tRr3Cxwwfc3LOC38/X4fQr65dprBdrBp3qVL2H/m0VZciiuYg5RYqK
         h20w==
X-Gm-Message-State: AOJu0YzZH4ZvvmOA4AwD8dA7giz2u33FiZW4rCDgCfhOaEJO49twf1zT
	zz1MEx2yPRTr0Mc4qrRUyJ/Dul1P2zkDr3j+tIf1LqBt8yYZETqVr2CYR+9K4JDx+4J9Nv6cgZ8
	t9A5JM0A=
X-Gm-Gg: ATEYQzxslKAuqHKhc32aVmLk9C1kkI86ZXRlxYjkixCypgApM61R5/9+/mj4FflEwa3
	qptalNqVDqW42OiCUq4IHUcy5sRnaB5U2gudV/L/FeWwWufGlYA6hl/dJWQ93SWb5cnC+ndLdKi
	GSO/3y7YHP/dTFphB1EJAG+l34Yfd0NqO5eAzdhhZ3hmBb5q08sPk/y6DrTnq6LlTsetOfYjxnw
	z93Sl9ZVcT/nMy4BAZPnA2GCe5vxKulSY7IKlNJqJ2wPjtpmIokFMvwIdk2nI2Si2qnTWVLIENP
	KWmw39mJQJETa0H0BiBPxj7e0koWs4dtZeOUGk+rXAkYJ1TRcOng+DP/IsXZp2WOqkLCeBSmb+7
	yEq311xb3Ng+8GuznETbXQHQTzf2720gUUisbbAvl6kZ8tkpFgDnvVfBTxgcBXNvlsGuOvAH+dE
	irS5AImnNWnZzkxxin6z04f+meHCYGykMcZALvsUsaNAP94yz6/Ur4d8YLBxCCoMCwJzymt68h
X-Received: by 2002:a17:906:f5aa:b0:b98:42e5:7e42 with SMTP id a640c23a62f3a-b9b50950745mr411428866b.51.1774723985487;
        Sat, 28 Mar 2026 11:53:05 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66b7607a653sm812197a12.24.2026.03.28.11.53.04
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 11:53:04 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66a5d76d9e2so5170522a12.1
        for <linux-arch@vger.kernel.org>; Sat, 28 Mar 2026 11:53:04 -0700 (PDT)
X-Received: by 2002:a17:907:80e:b0:b98:2c19:6c49 with SMTP id
 a640c23a62f3a-b9b502b2d5cmr444452866b.18.1774723984713; Sat, 28 Mar 2026
 11:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgg1QVWNWG-UCFo1hx0zqrPnB3qhPzUTrWNft+MtXQXig@mail.gmail.com>
 <ttcld3h@ub.hpns> <CAHk-=wiwjhtFFc1WKtLns4BTQFUpjso7859KAtqw2KM3fdHVWw@mail.gmail.com>
In-Reply-To: <CAHk-=wiwjhtFFc1WKtLns4BTQFUpjso7859KAtqw2KM3fdHVWw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 28 Mar 2026 11:52:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYvobZLPT68caEU76rpBGeggeOhsVxv=PrdUxnk6kq=Q@mail.gmail.com>
X-Gm-Features: AQROBzC9aZBglD_VE7bkRZRbCJ3FrqKxcV_LQtSaoThos99Cs_zDtp3hYMh6yLI
Message-ID: <CAHk-=whYvobZLPT68caEU76rpBGeggeOhsVxv=PrdUxnk6kq=Q@mail.gmail.com>
Subject: Re: Attempting to unify some user space copying APIs
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Russell King <rmk@armlinux.org.uk>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Helge Deller <deller@kernel.org>, 
	Huacai Chen <chenhuacai@loongson.cn>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 28 Mar 2026 at 09:46, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I suspect I should make the consistency be about naming too, and
> introduce "raw_copy_from_user_inatomic()" and
> "raw_copy_from_user_flushcache()"

There's another strange inconsistency here: the "nocache" iov_iter
case actually uses the name "inatomic_nocache", but the "inatomic"
part of it seems to be purely a historical implementation accident (ie
it started out as a helper function that could also be used in
inatomic context, but here the "inatomic" part seems not actually
relevant).

The only user of copy_from_user_iter_nocache() is
_copy_from_iter_nocache(), which has that underscore to avoid the
hardened-usercopy check_copy_size() overhead on user copy.

And nobody actually appears to use that "avoid hardned copy"
_copy_from_iter_nocache() function directly, it's only used as the
fallback for _copy_from_iter_flushcache() for all architectures that
don't implement it natively:

  #define _copy_from_iter_flushcache _copy_from_iter_nocache

with only x86 having an actual distinction between "flushcache" and "nocache".

So in reality we essentially have just two cases:
copy_from_iter_nocache() that *does* do the copy source hardening
check, and then we have _copy_from_iter_flushcache() that avoids it,
and on x86 does something subtly different than on all other
architectures.

And all of this completely crazy ad-hoc stuff for iovec appear to have
all of *seven* users in the whole kernel:

 - networking has two users of copy_from_iter_nocache(): skmsg and tls_device

 - networking also has two users of "copy_from_iter_full_nocache()"
which is another wrapper around copy_from_iter_nocache (which
basically walks back the source if it couldn't copy everything)

 - tracing has one copy_from_iter_nocache

 - dax_copy_from_iter() uses _copy_from_iter_flushcache()

 - dm-pcache also uses _copy_from_iter_flushcache(), but it doesn't
actually care about the user space case at all, having created the
iter from a bvec with iov_iter_bvec()

 - nvdimm uses _copy_from_iter_flushcache

but it's possible that I missed some other case that uses some other
indirection wrapper that I didn't notice.

I'm starting to seriously regret ever looking at this.

               Linus
