Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42867 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfAOPbE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jan 2019 10:31:04 -0500
Date: Tue, 15 Jan 2019 16:31:01 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 00/24] Unify vDSOs across more architectures
In-Reply-To: <20190115135539.24762-1-vincenzo.frascino@arm.com>
Message-ID: <alpine.DEB.2.21.1901151630120.1561@nanos.tec.linutronix.de>
References: <20190115135539.24762-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20190115153101.lemayGgUysDL8ULZczZbKduEAVQCY_fEZojcEYQNMLc@z>

On Tue, 15 Jan 2019, Vincenzo Frascino wrote:
> 
> This implementation contains the portings to the common library for: arm64,
> compat mode for arm64, arm and mips.

And as you already copied most of the implementation from x86, then why is
there no port of the x86 vdso ?

Thanks,

	tglx
