Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC13DEAEC
	for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2026 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669970; cv=none; b=KlpBmSpl9mQ+KaWXATafPAeprJYIAfUzacqZLcEBMAJyUz4omWHKp+MhvMAznY6ObcPJXisOJ+PFwY1Ms2jSDle5rdCaOdZiubn1nXFMSj6xv913sG3SHZ5offjFwSyIXmgmK+oqa4m6YcFhcHh11/N0bNxh3N6oHhG4FkpSWHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669970; c=relaxed/simple;
	bh=+O07iyphnPsMhbwdcZl/xEUDllR7WIMFNYTSmUuHDHk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=SKIMy0MCA75yWJE0kQDT24PhNPh/aqQoH2HnTGkDxGz7WmTiyMyJxJRPIS8usfFBFTari8+I5hu6ydJY6MDDJhTAj94lGMoloS493Aggd2xDyqNtA3otSg8SqlB5r+k6x3MhSeKnYE/6IZurxsmWHBQye81Fi4hpfuaE+bpkyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=phCDgbmF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phCDgbmF"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc61541f8cso23312875ad.0
        for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2026 00:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783669968; x=1784274768; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hBmrtvJxIONdnfaPYnlm/oDBvJlVXO+AfljQowycHCs=;
        b=phCDgbmFYIabUWS3GMYDH/KvmwvHnZtuUplOhDQEjP3K5yuPobZmcgQ7t03x7nG/ce
         S4z1Dq19hMrKgJaBgxsRbxfGnTQ+IVJbeSAsH1exWak+mLxpKLi5drEiiG1EokCGWWH3
         0C0DHthSC/KRQfKUgdbWTZWDUdsG7XjkNWyz3W8trbQM9fnnJJq3jWgLylggWLFeRXsy
         HrYWKXpYD0bvsJjMDFJnG4dgoqMtJRof/M7wZqufQe/YzLpokIv3ifWgdSJ0KquZ+RX/
         YkSp+6aMdOiy4vQnrpuaAAoPlae9+iYRO/fVxN9dffw4liNXtWRwtenyOptOKvIdBo6h
         O2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783669968; x=1784274768;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hBmrtvJxIONdnfaPYnlm/oDBvJlVXO+AfljQowycHCs=;
        b=SSY8GihVh4iYhY6pTupmmBg60EO8YEUPDbtezcXsX8h+JPQAJvAKL6GZ3aySHkrXpZ
         sFk5wd6RS3SaYSUJLj/Z2L8PsfCWAzat8OCl50U2k0eORQNLnn0lG7LONTQl+59l2eT7
         bJvj6Q7kfF3/QyCSTu7582UAxFoVc/KwbyMaQViVw6T+4d2mx3FfCF/XScBHAWzBzU6h
         HhIu+z14jSjvI4XNEc4Hwf/5mk5v6ltoVJxS2/fBga6dD1TPh7HDNXcB45Yz7FqzSPno
         aRlFmb8ZujYuBAfJQr6JZCfQvxAntCsRMr5Wzz1PgabjSy2Xd2wN7irJhv/bW06HQPdf
         Vw0g==
X-Forwarded-Encrypted: i=1; AHgh+RoFm4QJpia88nQkUr89HcfFLEN6l/vMEdQnIdeA3bf+Xc5S0dqHTzQDAhupvC8g6W8+4s07aaxbU+KS@vger.kernel.org
X-Gm-Message-State: AOJu0YzTk2L/n1E3zHRjJG0O8k2OM+gfcjvYthfG4DVNJop52Jiz4/ln
	8/qj8aKfkNwRQlFp1N6jmBarFtMfjpFOgRIHQgxyQfU30BJdP4n19Rcm
X-Gm-Gg: AfdE7cnaRBQWUgMz9mlAuu54kYJHCXJStnPlIxYmwma4Sjx1vQYi0vVPdS7AexjjqZL
	0DF+qRlC6pUJ897DTx3RNvCCYbxVV8831Yq0ZUQvAwmyeL0OdramsoxTQVoL3bjeECd/5g4sk5h
	/0gGJdU6HKtF9ujduflxw0QfpG86mm5RaQbY5BQONsGFvdhj74gaoa1M+pFNRq4pGzDhB9Aeo3R
	IwBEFDsxDYYpgU+IsiTDzGsoBjro3sAJ6AzxGW9IJvdfegHkxVMHdpNNAUgc5yvbGlNWPlUK9/p
	7wj+ZMJV9KbJ4S7u8gtMIMirJfDjmu9xvCgocqrnyT9xzxJMH2OIjAfAm7rCb6HomUymR6NiisV
	TYP5igAlbiiLorx0cwWEbfrCe6a6IfXW3YtTdA3/v17FSd8FB53B1ykY4aBIfUJGLe19/uRzRfk
	FbvaVjkQw41C2AitMWWA2dhcr1NAhvHA9UzB6FgpeG
X-Received: by 2002:a05:6300:6708:b0:3b5:445c:e483 with SMTP id adf61e73a8af0-3c0f085cde5mr3063429637.3.1783669968147;
        Fri, 10 Jul 2026 00:52:48 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm38555369eec.10.2026.07.10.00.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 3/8] arm64/runtime-const: Introduce
 runtime_const_mask_32()
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>
In-Reply-To: <20260630045531.3939-4-kprateek.nayak@amd.com>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-4-kprateek.nayak@amd.com>
Date: Fri, 10 Jul 2026 00:52:39 -0700
Message-Id: <178366995929.1208691.6493654690059057340.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783669964; l=605;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=+O07iyphnPsMhbwdcZl/xEUDllR7WIMFNYTSmUuHDHk=;
 b=cz9XXDbkR0SqPbqmjDnlzBYAVi5QXign/r4fxPETsJQjHLuhqKNi1lidC/VVBt9XeNDUNYCm6
 hNQu7cyMBW+DNBsieROPBZ33ez+ffYUCmOSl5oGIFtaAneSomqGU4B7
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Tue, 30 Jun 2026 04:55:26 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> Futex hash computation requires a mask operation with read-only after
> init data that will be converted to a runtime constant in the subsequent
> commit.
> 
> Introduce runtime_const_mask_32 to further optimize the mask operation
> in the futex hash computation hot path. Since all the current use-cases
> are of the form GENMASK(n, 0), with n > 0, a single:
> 
> [...]

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie

