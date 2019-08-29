Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfH2PX0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:26 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4A3923426
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2019 15:23:24 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id o184so4290493wme.3
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2019 08:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190829111843.41003-1-vincenzo.frascino@arm.com> <20190829111843.41003-3-vincenzo.frascino@arm.com>
In-Reply-To: <20190829111843.41003-3-vincenzo.frascino@arm.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 29 Aug 2019 08:23:11 -0700
Message-ID: <CALCETrWNbMhYwpsKtutCTW4M7rMmOF0YUy-k1QgGEpY-Gd1xQw@mail.gmail.com>
Subject: Re: [PATCH 2/7] lib: vdso: Build 32 bit specific functions in the
 right context
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrew Lutomirski <luto@kernel.org>
Message-ID: <20190829152311.Lh6T-Ka5msOgkwpPwlOSlB0AW_UeoS41bAg_kiBsclk@z>

On Thu, Aug 29, 2019 at 4:19 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> clock_gettime32 and clock_getres_time32 should be compiled only with a
> 32 bit vdso library.
>
> Exclude these symbols when BUILD_VDSO32 is not defined.

Reviewed-by: Andy Lutomirski <luto@kernel.org>

BTW, this is a great patch: it's either correct or it won't build.  I
like patches like that.
