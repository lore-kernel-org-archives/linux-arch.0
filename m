Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2973136CDEF
	for <linux-arch@vger.kernel.org>; Fri, 17 Apr 2026 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776451384; cv=none; b=HAsAqQfe6uNJ2E/AtZEQVbESo4VZ96c1+mVdoT5gjEDHdcrwT/xhREpt2TI+Bt77TcRBVbG1brTAaMi5s3huh7Ew9RT1dv818FzROoXpwymLnEkUZWM/U+Fmc6v5t3Nu52CogWlMkfr16AztT2qWN/1RzOKgNReMg+BHNoEkSx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776451384; c=relaxed/simple;
	bh=GrhKsJNuO0xmf8KxXAirnEOwtCWdYT04Tcyy1D7elhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H15pGTN7oLpchP2Mxye19qrGlDdN3yLV9WHUqnLO8PBOetA3KZ46JpYvLA/wcMG3dWtA689b8g4y2UB0uVS2I6xjb3QN0o9wdj7xfMUxiJnWI2doVAu5OlygognIrMYZ/VlgTZXoa6UKLAfEp7LxCvHQiRNHSnezokrvzSLPsPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qStLjIuW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qStLjIuW"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so13739875e9.2
        for <linux-arch@vger.kernel.org>; Fri, 17 Apr 2026 11:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776451381; x=1777056181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zrub1C4d7CDdCrR1P7BJnLdyF1FR8X46HxABz+9R31c=;
        b=qStLjIuWbzYThV4ib4VowIOzxGWuAun7qOAHFuyfwhCzTf3xGirAR9tLh50Nb06jD6
         Tjhe8IpxmGAfS2K3xMK+v1n1RSp3yswFwDFtOnY73+R0RZEVn1OTAsd6aP/+irJz+6Xp
         r7xEO51IN9+4d2iMy0VEXMhiv69AP2WCwxlWqIyY9sqFeqSDe7ZEebkDgxrj3dPrcaHq
         nrelqKejsBu8JHHGvNHpseVvDu8qG6WkMClBMUQdr06cG9ZZjneVIWYnpDkU/spmy0oy
         3vvYJnn29lvCKyPkM4nK8wNv7l56LFWyMecdDgLwznGHvgTG3UeVTMfTxJrD8zeeV84Y
         y4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776451381; x=1777056181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zrub1C4d7CDdCrR1P7BJnLdyF1FR8X46HxABz+9R31c=;
        b=rmG/bhaly7o9LhYTH3QNYXBh9+l/AYscRTlRKjibUGdRMBG5uq1bYh/FoOCbyMr5nh
         GAuGM1hFOwfp057RAwdmWxR+XPz55R6V30grUFqvOcj/dFrduH3vvqv683G7YYq5bJhV
         qBWK5DaZSWpSAesP2IdRY1eY/AL2KHy7YeKHO4hJV6xQ6stf36rxn/MNkDjElloAz1MG
         brgw+XXrKun7QOnk5j2ldUvM9AT3nIkOjESM3cZZaF5FrzCr+qe/E1E+qrzT6D6ENSpQ
         3mgy3UKaLGzLMAOcjrJC820bqWsCeCxyLJy1hP9FHLdi7RO1ndOSuZKp/elIFe7EE91h
         ZoBw==
X-Forwarded-Encrypted: i=1; AFNElJ+lFiyDSd6a3lLtN5nd5Aqs7t1hyCoPwx/MfdHY4pPx6dohxWhoc8dvPmM1kNaUSwVMUggvdxQSJNXR@vger.kernel.org
X-Gm-Message-State: AOJu0YycBbFeVKYiLrJUkcx9KF5tV67SO2Smiy/pwNk2p1Dgm2hiC+nL
	wGCz74soouTyOjVHGarLTMg7u4V+vvnnvwio/jRfx9gHj3fVa4VMZcdH
X-Gm-Gg: AeBDietnBXuTw/0x6D6Y4hpoR/NVriUOQfM+9ThT86Q7XVthjVesUjn8xv0k4OmGL2q
	Rd6jGaWrZqEiSyoXgsGmJFXDwJSajiGUkqPlB3/whnbj8p/jsdLP8U3YEQsxohYIH0nPyFIzc4E
	FTfATs9A4uMGP9ZhNAprIuKriub8B7vKlT+RC1tdl/FocTY2pxaQJhAbS95iLWUFfyGXz0FqL0C
	/5HcP04WgUjspltO1r976Z67U0oTST6JDYO+8xBkIl+Xc1Ls1Vs+nVtIPi8hrjMFGQf7AgsZpwU
	lsLQOYk6emYp4OLR1rBGyUYkqGzVPT2ajb1CLm9inciZvuuM+5dGW3yhC5OelVvGgycGFFZVBYx
	Az76+ZO55b/AbLwd2Wh2Ppnp9m1fBDhDnrEo0hOu+LZmTimZFKTbw6BcUqJd/FRwqolf8qzaI38
	PrSvWoWnKfX27MRug9CkHXnRUOArKTgOKrojXshMzzbCGlhYfLC0r8coaQYFcvNnjU8J6MxWAHv
	5s=
X-Received: by 2002:a05:600c:1554:b0:488:9bf8:7f17 with SMTP id 5b1f17b1804b1-488fb77810bmr61308135e9.14.1776451381317;
        Fri, 17 Apr 2026 11:43:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c01cfsm68401345e9.10.2026.04.17.11.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 11:43:00 -0700 (PDT)
Date: Fri, 17 Apr 2026 19:42:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, yury.norov@gmail.com,
 linux@rasmusvillemoes.dk, arnd@arndb.de, akpm@linux-foundation.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, nathan@kernel.org
Subject: Re: [PATCH v3 0/2] arch/riscv: Add bitrev.h file to support rev8
 and brev8
Message-ID: <20260417194259.0c48d7ef@pumpkin>
In-Reply-To: <aeJbH7vfRpPuOGB0@yury>
References: <20260417093102.3812978-1-ruanjinjie@huawei.com>
	<aeJbH7vfRpPuOGB0@yury>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 12:09:03 -0400
Yury Norov <ynorov@nvidia.com> wrote:

> On Fri, Apr 17, 2026 at 05:31:00PM +0800, Jinjie Ruan wrote:
> > Add bitrev.h file to support rev8 and brev8 for riscv.
> > 
> > Tested functionally on riscv64 QEMU with:
> > 	"-M virt,acpi=on,zbkb=true,zbb=true"
> > 
> > Changes in v3:
> > - Fix the build issue by remving the CONFIG_HAVE_ARCH_BITREVERSE macro
> >   for byte_rev_table.  
> 
> No arch needs byte_rev_table, except risc-v under a very certain
> configuration. Please find a better approach that wouldn't bloat
> random victims' .data section.

Eh?
x86 doesn't have a bit-reverse instruction.
The only arch that 'select HAVE_ARCH_BITREVERSE' are arm64, arm32 (some cpu),
loongarch and mips (for CPU_MIPSR6).

I think you mean that no arch that sets CONFIG_HAVE_ARCH_BITREVERSE needs it
except riscv.

Could you globally have:
	select NEED_BYTE_REV_TABLE if !HAVE_ARCH_BITREVERSE
and then riscv could also select it?
(And isn't there a method of including files in the build based on
kconfig options rather than unconditionally compiling it and getting cpp
to throw the contents away?)

	David

> 
> > - Update the riscv implementation as David suggested.
> > - Add Reviwed-by.
> > 
> > Changes in v2:
> > - Define generic __bitrev8/16/32 for reuse in riscv.
> > 
> > Jinjie Ruan (2):
> >   bitops: Define generic __bitrev8/16/32 for reuse
> >   arch/riscv: Add bitrev.h file to support rev8 and brev8
> > 
> >  arch/riscv/Kconfig                    |  1 +
> >  arch/riscv/include/asm/bitrev.h       | 55 +++++++++++++++++++++++++++
> >  include/asm-generic/bitops/__bitrev.h | 22 +++++++++++
> >  include/linux/bitrev.h                | 20 ++--------
> >  lib/bitrev.c                          |  3 --
> >  5 files changed, 82 insertions(+), 19 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/bitrev.h
> >  create mode 100644 include/asm-generic/bitops/__bitrev.h
> > 
> > -- 
> > 2.34.1  

