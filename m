Return-Path: <SRS0=c96G=4D=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgBOL42 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 15 Feb 2020 06:56:28 -0500
Date: Sat, 15 Feb 2020 11:56:24 +0000
From: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v6 10/11] KVM: arm64: BTI: Reset BTYPE when skipping
 emulated instructions
Message-ID: <20200215115624.2afbf55c@why>
In-Reply-To: <20200212192906.53366-11-broonie@kernel.org>
References: <20200212192906.53366-1-broonie@kernel.org>
        <20200212192906.53366-11-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H . J . Lu " <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?UTF-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20200215115624.y9bkbVTfkd4v0uFJdSisflzIYLa_kqfE0QBOizl6tmE@z>

On Wed, 12 Feb 2020 19:29:05 +0000
Mark Brown <broonie@kernel.org> wrote:

> From: Dave Martin <Dave.Martin@arm.com>
> 
> Since normal execution of any non-branch instruction resets the
> PSTATE BTYPE field to 0, so do the same thing when emulating a
> trapped instruction.
> 
> Branches don't trap directly, so we should never need to assign a
> non-zero value to BTYPE here.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Marc Zyngier <maz@kernel.org>

	M.
-- 
Jazz is not dead. It just smells funny...
