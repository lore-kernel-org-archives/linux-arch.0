Return-Path: <SRS0=hCVk=4O=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44529 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgBZFti (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 00:49:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id d9so824952plo.11
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 21:49:38 -0800 (PST)
Date: Tue, 25 Feb 2020 21:49:35 -0800
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v6 01/11] ELF: UAPI and Kconfig additions for ELF program
 properties
Message-ID: <202002252147.7BFF9EE@keescook>
References: <20200212192906.53366-1-broonie@kernel.org>
 <20200212192906.53366-2-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212192906.53366-2-broonie@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20200226054935.gBDBPiaRhUKBQO3bW6Ek9tVa1gYYsLYmHtt-OJtskik@z>

On Wed, Feb 12, 2020 at 07:28:56PM +0000, Mark Brown wrote:
> From: Dave Martin <Dave.Martin@arm.com>
> 
> Pull the basic ELF definitions relating to the
> NT_GNU_PROPERTY_TYPE_0 note from Yu-Cheng Yu's earlier x86 shstk
> series.

Both BTI and SHSTK depend on this. If BTI doesn't land soon, can this
and patch 2 land separately? I don't like seeing the older version in
the SHSTK series -- I worry there will be confusion and the BTI version
(which is more up to date) will get missed.

What's left to land BTI support?

-- 
Kees Cook
