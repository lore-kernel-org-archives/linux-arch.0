Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B736918859B
	for <linux-arch@vger.kernel.org>; Sun,  8 Feb 2026 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770550359; cv=none; b=WqBDPqxZKMsoB0q/Gi5D9xy0rDbNrzPZ7PZxHWYmAAVNwDWBJpRMWBOgZ4WYRKz3Gl8dRpTCbpnhiPKi3FbnQF4SsquvF09iu6Oxv9UjpQYOGKlA8JPxATuR38t08ou4kHeul3EB0OOH222HLcQ1PZojZn3qyqUJG51hjVzw028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770550359; c=relaxed/simple;
	bh=/lRpomPSwh8YxlQxg5VB4rgkpzxVl5v8qa4yNb7sdF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdCz+VYw5IxBVLAr3lAa95DGLN8uxrDUvf29AT2uCRJNuanWzVDbMVwaOmQk1ecO1om1p2P3F3IW66t7YXbSRsg/IPGYS+QrV3toy3PTyELXneH8puGoCT5Zih+jRZPOR0OSpU73HGVBynp/jhuTOU89Q8vKovjsh01s6LbWQ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXfpbOK7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXfpbOK7"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so28573135e9.2
        for <linux-arch@vger.kernel.org>; Sun, 08 Feb 2026 03:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770550357; x=1771155157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNSWUWRUxkD71xgcxVZgiH0mCL63/Y6ozxWMmtJ8kiQ=;
        b=FXfpbOK7OWtBoiAuTmSV44qqe14lKocGzw6BvYNcSViF2fEdK+xf5h5dvLlN+hnKDE
         OWVz1AnVFxn654nNGX1wu+5AyfQhqyIVQdq2ceGLj9mCmIlAcc4BTE6I+KIqAFxzhHd3
         1UGlm3aEXfiH3wcV6fM41TTp5wVbzi0OvD5ijS1x5PtkgD7AVZksNcz57qDbPSVdX/pL
         k5XmP2SlXcQmBHdZrHr+6Wh9p9VMnfbihzXgtsa2qnZDtHD42AzSecIH5Ik8aAhC9Vuw
         qSiUhoEYXjorT7AKrVF/USco3ujsLjgr+M8Qe0mv/UE+OiNt+bjXMpvzuRmB1cOA8fdl
         cAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770550357; x=1771155157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vNSWUWRUxkD71xgcxVZgiH0mCL63/Y6ozxWMmtJ8kiQ=;
        b=OboCTChaaGL2jvXs8qpVLlGVQcPzNvj1WcRcipsgEUvnLnkWHvDSA4O01ZgfQbzdiM
         ANJEtvxSR1qOQkUcfoLflXPwd7QHa8z4U5HhCAe5/fiT+YLTMbByzrgcFxK+vjs3CoPf
         8HthPU5J2BLdDSBLl2imH7DW4QSz8A4NyBXQn0JwkTMxoO5lP+at6lwWcgjbFK7lsYPA
         hN9A5xMOwhGAHuOCyswttOt3BsViO7fu5pBIWMQTYaYz5JQ1+N0/CiTv18O/duUELDHM
         2usnRqnHh+CUtZ7JIDwKpbQWg/Bjy2ELjWpU2YZLflhomjtOZus/FFj8N5IrqvXS/7ew
         Y+sA==
X-Forwarded-Encrypted: i=1; AJvYcCUvS7BzEb+LYat+Cp/IOhQKCRytP1rgQ90cFdWasDV6zSgthecqCNbwW3rIxjgGpudGeizm+pEAn+/n@vger.kernel.org
X-Gm-Message-State: AOJu0YyQovPlKET4ykpZcFJMhw7YPTlRs0ckImkXQOyrfIlo2yygRjkk
	oPDX2ZonBf8sVt7nU/d8YdpBXWhA1UxzJ0YC4s48Xbq/73nqx7CwqChS
X-Gm-Gg: AZuq6aI4+Lx2gnZMKVReaV6Epgrd5f8JH+vupmueOH0ej0BXMdtgLQcEc8Lcq3C9Obv
	V34ZRvoRqDTeLQd48fYbfmLsDDTGSQb+J0qSCUqlL3gbPv4mIyc/KeBTUbSm8ZUFpyg++hoUP7z
	KE37vY8e77YrvbwIuqcN1eGzKrdz80WFuQVkMAzDH9y8Q0Qa7nMdOAVfGCMAWvglYe/6RNWlnFl
	ZMl2HuHgl5RQIKOoyz1YptvMY1kM7nDSsh6conWZ1c2xooiGp545gjowgev+zSFfP2fdfOe1X3z
	NK9ceo7FlFaTBGEucUWiQiEwruH0eCrcRtduRUFjlaaMhW7XTPWbIMfZBsxMgL1J3briMia5Jwo
	IgyY3NYyqDJ+UoJJDo+MRPphATiSg2azCX5xERJ03439BI4hMDsIayBWe6guaqLFOQgH4K8rDAx
	GMVbMr3d+69kOx8waLSmcXOeWmR+deR79s/Rjzcuh3LLX6fUuYZzkwlTK8Z51GS2E=
X-Received: by 2002:a05:600d:640f:10b0:477:a1a2:d829 with SMTP id 5b1f17b1804b1-483201dd24dmr91646175e9.13.1770550357007;
        Sun, 08 Feb 2026 03:32:37 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d299bfsm237379875e9.2.2026.02.08.03.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 03:32:36 -0800 (PST)
Date: Sun, 8 Feb 2026 11:32:35 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Yury Norov
 <yury.norov@gmail.com>, Lucas De Marchi <lucas.demarchi@intel.com>, Jani
 Nikula <jani.nikula@intel.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next 13/14] test_bits: Change all the tests to be
 compile-time tests
Message-ID: <20260208113235.6897e631@pumpkin>
In-Reply-To: <aYgTHfhxDws-D6yl@yury>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
	<20260121145731.3623-14-david.laight.linux@gmail.com>
	<aYgTHfhxDws-D6yl@yury>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Feb 2026 23:37:49 -0500
Yury Norov <ynorov@nvidia.com> wrote:

> On Wed, Jan 21, 2026 at 02:57:30PM +0000, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > Since all the GENMASK() values are compile-time constants they can
> > be tested with BUILD_BUG_ON() rather than KUNIT_EXPECT_EQ().
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>  
> 
> I thought, KUNIT invented this EXPECT_EQ macro for a nice printing
> and some accounting. If you want to make sure that __GENMASK() is a
> compile-time expression, it's OK. But I'd rather keep the existing
> KUNIT_EXPECT_EQ() and add
> 
>         BUILD_BUG_ON(!__builtin_constant_p(GENMASK()))
> 
> next to that. This is actually how test_bitmap_const_eval() works.

That just tests that the value is a compile time constant.
You want an error if the compile time constant is the wrong value.

The point is there is no reason to do a run-time check if the compile
test fails.
Making them compile-time means they get tested by the compiler,
so you don't need to run the tests at all.

The original tests in one of these files were all _Static_assert()
at file scope, but that requires 'integer constant expressions'.
They need moving into a function to use BUILD_BUG_ON().

Perhaps the test framework(s) should have a standard scheme for
compile-time tests.

	David

> 
> Thanks,
> Yury
> 
> > ---
> >  lib/tests/test_bits.c | 90 +++++++++++++++++++++----------------------
> >  1 file changed, 45 insertions(+), 45 deletions(-)
> > 
> > diff --git a/lib/tests/test_bits.c b/lib/tests/test_bits.c
> > index 36eb4661e78b..4d3a895f490c 100644
> > --- a/lib/tests/test_bits.c
> > +++ b/lib/tests/test_bits.c
> > @@ -32,30 +32,30 @@ static_assert(assert_type(u64, GENMASK_U64(63, 0)) == U64_MAX);
> >  
> >  static void __genmask_test(struct kunit *test)
> >  {
> > -	KUNIT_EXPECT_EQ(test, 1ul, __GENMASK(0, 0));
> > -	KUNIT_EXPECT_EQ(test, 3ul, __GENMASK(1, 0));
> > -	KUNIT_EXPECT_EQ(test, 6ul, __GENMASK(2, 1));
> > -	KUNIT_EXPECT_EQ(test, 0xFFFFFFFFul, __GENMASK(31, 0));
> > +	BUILD_BUG_ON(__GENMASK(0, 0) != 1ul);
> > +	BUILD_BUG_ON(__GENMASK(1, 0) != 3ul);
> > +	BUILD_BUG_ON(__GENMASK(2, 1) != 6ul);
> > +	BUILD_BUG_ON(__GENMASK(31, 0) != 0xFFFFFFFFul);
> >  }
...
