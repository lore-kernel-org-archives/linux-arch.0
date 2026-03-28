Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D43939FCE
	for <linux-arch@vger.kernel.org>; Sat, 28 Mar 2026 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774716435; cv=none; b=HtTyBgivkEnkGthwf6c2qg4OIoypGXGXRINffXSh8YXxEnZi/Qgr6Ea+ftV9bs5bKoBav2Or/Fu5+oJ8cb0rMFeCrlhj+XgoDMctzEqTmqvm+YPKsB3j7ECUxJh/zQFua9v16YZviJUP+2iRVL0E9yc2Leamn0A+aJ7w0on3svA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774716435; c=relaxed/simple;
	bh=cySVpRVpoqgpj3Rv4lt8Q3EwaRu67POoOOiL6/gvItE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUqbnEZTbWQViO1wXBR1S41VenVwk4ZYex4Ub+XIQ12Kt8A5TiIguyNc191XaHf/ignXZc0al9Kivlo+fz//tlRfmhTbNetPmO/S/5JgQ4oWVNzaXwO309woqutesWCPvwT/mWjSLeh3YtYFmWagMsvSyVjYoCfeiwiKb71c5ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fh/soAR8; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fh/soAR8"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66b1019bb55so2869471a12.1
        for <linux-arch@vger.kernel.org>; Sat, 28 Mar 2026 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774716432; x=1775321232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wDIFOBZ2dvSZcfvYrWLXHj0gbJfPgQHdwiiJOGfve8k=;
        b=fh/soAR8f2oRDIDWo+rmKpoU42DAWr01dfA3nUtDpxR/TkJOIuhuZmVEbIp/lvkvjK
         DutJ8KF88bSkJeYXYbKL7+01oAwGq0hxYO4HXh4NN+2Q/JLR8ILQEQIciCgc2EesW907
         Su2+E+jDDDSctO/02H1VTi6SqLirZ9Glhv624=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774716432; x=1775321232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDIFOBZ2dvSZcfvYrWLXHj0gbJfPgQHdwiiJOGfve8k=;
        b=n33Rd/WNqfhzSG/uCqGA1jM7O3d/dfQB8ehhtINjdeQUE3HFjNbhPXKz+vNmoECtwR
         zh0cYy85eIjy7BRwTGWfz3Qt5aOFiczl/EPdIBWlVyCm1pNQeG7KVO/sgJ0Q30UcqGNf
         /+d7cXe5KX0cU4uWk1ckiH8CqOHl2GmCEhcA9Dpu4gHMPCac9Mk3HoHS2eDrAPP5/YXB
         EDTNSwZRGxJDeEkasKx4QqW81c3EHCxZu54CFzEhypVwBuHGLmw/0Uc34dKNQCrfW/hK
         PTnBk8lc9NyAN6T71qzStzLb0SjxQzzCDEaXNWKhFpuURcf8+mZ4x3V2YEor8/1kNooU
         mSeg==
X-Gm-Message-State: AOJu0Yyc5l+EwsCnO3bnHd6kaM7kbwoinT8Uuz176GHpcWpLmYF5p6Eq
	VPz772xtriqHvq7q8fqjCV9lADKOlttQkxTjqdHsbbtgG60PIvglXlgcvpudE2Gf/6nwtsW43RC
	NwTol0dg=
X-Gm-Gg: ATEYQzz9ri20TTZSTO6hN3dN5yHkZNZe6CgZvO/A9bVp6ixfiZSF0omPd1pwT8vI6KS
	WpRGU5L4nCTDAb/FyMr1ijmJFLA7SPYE6vEoLd/N59a2zJRLHivRTMrbMbtY8kwCwdNxyXQe4HA
	tLFyZUhet7xXM2wpDSdAJ0/dpvDzTj1z+/49qi3uvFX2iGMe3koWL882Wr2miS66iKKdVA2p9K4
	bubxwv9u6kZZtBQOXQ/b483uX7KrUGn4eEcTGnrwboanGt/xFC7eGCE1p6UiI0drFK2FVqGfK0N
	oTt0QpKDs+AuEoj6zEnCDxNphtYA3y+qpwN2fYoGrLf21+tHhLq4LFErnEvxYhJHlD8W27OBUeI
	5uV+9khnGOGG4F3zAb39McX8spN8s8DEa65/Lopzl93wMel7HmWrTBG6OZyD/HWZcfgb1Nr0tvY
	Jnbri9dWRm9e3K1bLSQRLD2FJxkokk/l07oF1A0yV2WDaLEC+N5RMe7efNloloN/m0DVqp04sP
X-Received: by 2002:a17:907:7b94:b0:b98:7f7:50f8 with SMTP id a640c23a62f3a-b9b507c4640mr398921266b.29.1774716431633;
        Sat, 28 Mar 2026 09:47:11 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b227393sm89394866b.63.2026.03.28.09.47.10
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 09:47:11 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b97c44417ffso313305666b.2
        for <linux-arch@vger.kernel.org>; Sat, 28 Mar 2026 09:47:10 -0700 (PDT)
X-Received: by 2002:a17:907:94cc:b0:b9b:5164:9059 with SMTP id
 a640c23a62f3a-b9b5164930dmr381644266b.8.1774716430659; Sat, 28 Mar 2026
 09:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgg1QVWNWG-UCFo1hx0zqrPnB3qhPzUTrWNft+MtXQXig@mail.gmail.com>
 <ttcld3h@ub.hpns>
In-Reply-To: <ttcld3h@ub.hpns>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 28 Mar 2026 09:46:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwjhtFFc1WKtLns4BTQFUpjso7859KAtqw2KM3fdHVWw@mail.gmail.com>
X-Gm-Features: AQROBzA6w1N7OZ2_YIErAAdgLNelQtmKBzFFXadq1aEk8PF0_mPWv9yW8ahT0c8
Message-ID: <CAHk-=wiwjhtFFc1WKtLns4BTQFUpjso7859KAtqw2KM3fdHVWw@mail.gmail.com>
Subject: Re: Attempting to unify some user space copying APIs
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Russell King <rmk@armlinux.org.uk>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Helge Deller <deller@kernel.org>, 
	Huacai Chen <chenhuacai@loongson.cn>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 21:14, Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> One thing I noticed: copy_from_user_iter is clean - the boilerplate just
> wraps raw_copy_from_user which has no instrumentation of its own.
>
> copy_from_user_iter_nocache is a bit different: the boilerplate wraps
> the actor with instrument_copy_from_user_before/after, but the nocache
> actors already instrument internally.

Good catch. I only looked at the iov_iter side and reacted to the
"that's not doing all the required steps", without noticing that we
had added that instrumentation separately to the nocache actor (well,
the __copy_from_user_inatomic() wrapper), but not to the
__copy_from_user_flushcache() one.

And as you say, it's all also very inconsistent wrt kasan/kmsan/kcsan.

So the whole inconsistency goes even deeper.

Gaah. What a pain. Following all the randomly named wrapper functions
that do slightly different things on different architectures is a
nightmare. Thanks for noticing.

This only makes me more convinced we need to make this all more
consistent, but clearly I need to think about this some more.

I suspect I should make the consistency be about naming too, and
introduce "raw_copy_from_user_inatomic()" and
"raw_copy_from_user_flushcache()", which do just that part - matching
our raw_copy_from_user() model (which in turn evolved from many years
of crazy inconsistency in the *basic* user access code, with varying
amounts of underscores etc).

The good news being that the inatomic and flushcache cases aren't
actually implemented by most architectures, so that cleanup should be
minor.

Again, thanks for noticing, and I have to go back and improve on that
patch. But it looks like it's _almost_ good.

                 Linus
