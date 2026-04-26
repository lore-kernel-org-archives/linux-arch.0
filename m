Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4A353EDF
	for <linux-arch@vger.kernel.org>; Sun, 26 Apr 2026 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777200583; cv=none; b=qutXSJBHrLR9jB+580le6yZFOY1Dvf01P4U7/ftDNAX3wirh7G3D46WQuI5tlJuTm+dQqCqLrr5OOhpb3rfTY2NdDEIiiRfaqeEoYc/Ke82HkO0b2RtDvXQ2b+iri1/XF4dKEmWaLABISaQYnu3j2waCtzx1gwDQvXe0zl548zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777200583; c=relaxed/simple;
	bh=OHfzunV5PLXI0kIdwgVzMfC9eyzvktWHvlJSNRRWRWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8WB0xW76gNDvMFCkEbAU1qBJhQcdkbyNH4Mo1NrhQ3BhKTPaKOQflVvKFbEDoSEwB/rATwo14GUrzpbJ435+ewMgt5htGFz546Pf2WBJmLD+YsXF6b2VVhvf34NZSAH8gFudLQlMIVtWvuCf8s71kcoX4rmN+s7YW6k9pm1Lno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNblob9d; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNblob9d"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so114024215e9.2
        for <linux-arch@vger.kernel.org>; Sun, 26 Apr 2026 03:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777200580; x=1777805380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep7scWKVDqquDfjlRMHGlmqZl4NIrLMdEyZJu2mgSNY=;
        b=nNblob9dOhZzJemaGmZSGlOCvmbaaWH6clA+tn70ov/Jki9qFu/jVHqLIOLdF+Lh3O
         Fci7DqQ4AEcLqykBEJMQz2kKOIiwU82DlIedvidyGNNjk2MjCfrVHb9XKnZqvOtgUjau
         +fcrQ75sXsOvBmtZO8s8S5qQby0wpUmV4ViNatg1tkboXu/UZcYHhH8KHO0sa1z+/ZjO
         rfQKwS+LBGdKC8cOZGD4w8e0fBO7oetp0NSN/iZNyLsm0x0qbBohWL90uNjxp5ToeW7y
         r7WlUcBsNxkUIN+XdAg9USXLKonZHbYMEBK1Y0FA9swgzX1PbpDOVKP/xS/5EFrdq8Bn
         OSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777200580; x=1777805380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ep7scWKVDqquDfjlRMHGlmqZl4NIrLMdEyZJu2mgSNY=;
        b=jV5OSnjIWccTMOXTXzQyuJ3s+VJNvvpwXleay7aQRJIBrhYLSOcDdrrc3jcqbPt3LW
         J/b+caBtwlaZZAGHyQymlJxAlvL7L3xRc8bgJUw3wMt/svNHuv3vfonkhncZy7i8w1Kv
         lJlXoitn1fVJghraUOLXHbp5uE0pogT5+DiovEM0nPL3ERGbM+tXQNbZ7gCrNx8NvfoA
         28RAiLIUImpEwkcMOWJS5Nr+Jedv9Z05QZ/HFUEXe9hMeNp8LPQhXqygMO8SmhhejXuj
         JJPl4Rxkv6UHJ9e8Vqp+yZtnwMFmQ634jdh34xczctpjgaN6YZxNdaGM+x4P/OQ1w0Cq
         0/7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8AJ2k2iBMekKBOiMK1ILNCi+1KFHam6HaqtHaoWdItCSbut84lDcHNcB+ak4nm5jpjeWwozKZlLaR4@vger.kernel.org
X-Gm-Message-State: AOJu0YxsghXrA41I0fskPiBTzdXR5D9DKDXQdbOjEXOCvC3quEKUX+T5
	IZ1uVNCt8L235Z23FbYNnLyrU8zttycGefF/G8Xl0PbFYby6NcTboNco
X-Gm-Gg: AeBDietuWdggs4kt+fsSDAs85yIGF8Yvn52HEsvK30I02JhLg5F5+AhL0Fv9SNxiars
	/cj8ERmhkWXrpVO3/Tqf7RxOxpLnZ6DKP0iBVBKdHu9vNLFDOAC6DFzMZo1LqRznw3Y+IWvpCLy
	l0XC7jRECYmew6KS/aZKLgs0W0iiqmdn3iUcTbPcAnTUFkdxOYJ8uYjpaAvhRfoMvdphr1gF91d
	uoCR4bX2Pa8mPn7FA0ZkBycpeXG6Rg0LXH/VlygMxijjQeGdBKOyfplhe/r5jOAgD3vO40fPsH8
	/No4yS/FU90bAl8tU8A9Zk7XndZDcOLA8m7r/Li4ThsR2LygZUF8SR2YGlDYK6JtrKwxwfudmEV
	aH+A0d+L3ugECvr4vHyo4tciCKP9ulsVjAbkkkEyCnTT8mmn76ORhdkOfpAsCZqr/z2KotAUt81
	U1XJbFbGfkK/cbZjHWClbxg2fsZIGi8aHofG34Tco2A9KuRHlx6ToydBhEfmHvuZBOZa7us89Mz
	3s=
X-Received: by 2002:a05:600c:154e:b0:488:9ed3:1492 with SMTP id 5b1f17b1804b1-488fb74fc02mr518917135e9.10.1777200579989;
        Sun, 26 Apr 2026 03:49:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1393f5sm666871765e9.9.2026.04.26.03.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 03:49:39 -0700 (PDT)
Date: Sun, 26 Apr 2026 11:49:38 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Min-Hsun Chang <chmh0624@gmail.com>, arnd@arndb.de, msalter@redhat.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: replace ________addr with
 __UNIQUE_ID(addr)
Message-ID: <20260426114938.4dff28c8@pumpkin>
In-Reply-To: <20260425151240.2a46e3a8640fde3902461d41@linux-foundation.org>
References: <20260307092119.20733-1-chmh0624@gmail.com>
	<20260322144032.7353997c@pumpkin>
	<20260425135737.e79c4b546d22b5ebfd96c0b5@linux-foundation.org>
	<20260425230134.5449498a@pumpkin>
	<20260425151240.2a46e3a8640fde3902461d41@linux-foundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Apr 2026 15:12:40 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sat, 25 Apr 2026 23:01:34 +0100 David Laight <david.laight.linux@gmail.com> wrote:
> 
> > > > The real problem with this define is that both idx and phys are
> > > > expanded twice.    
> > > 
> > > The real problem with this define is that it's a define.  Why oh why do
> > > we keep doing this to ourselves?  
> > 
> > Sometimes #defines generate better code because they are expanded earlier,
> > and sometimes you want type-agnostic 'functions'.
> > But neither is true here.
> > 
> > But I think I'd go for 'always_inline'.
> > Sometimes the compilers make silly decisions.  
> 
> Gee, if `static inline' misbehaves then we have big problems!
> 
> What's special about the fixmap code anyway?  It's not exactly
> fastpath.  Perhaps this stuff can simply be uninlined.

Some of the inlines are trivial - just adding an extra parameter.
But this set would be simpler if the last function
(__native_set_fixmap() for x86) returned (address & ~PAGE_MASK)

> 
> Pet peeves:
> 
> We use too many macros.

Indeed, I get fed up of looking things up to find they are trivial.
Some of the 'helpers' do nothing for core readability.
Even things like BIT() can have unexpected consequences.

Not to say I haven't got the pre-processor to do odd things in the past.
But it is usually trying to avoid having to keep multiple definitions
aligned with each other.

> We inline too much stuff.

True - don't look at what strlcpy() can generate.
The inline code should just get the constants from the compiler and
then call the appropriate function.

As does the compiler.
pixpaper_panel_hw_init() repeatedly calls two static functions that
contain sleeps. They all get inlined bloating the code size and
exploding the stack when clang separately allocates all the buffers
in the called functions.

	David


