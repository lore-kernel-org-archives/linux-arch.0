Return-Path: <SRS0=Pd00=3D=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:54502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgANQeJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 11:34:09 -0500
Date: Tue, 14 Jan 2020 16:34:03 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 02/12] ELF: Add ELF program property parsing support
Message-ID: <20200114163402.GH30444@arrakis.emea.arm.com>
References: <20191211154206.46260-1-broonie@kernel.org>
 <20191211154206.46260-3-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211154206.46260-3-broonie@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>, Sudakshina Das <sudi.das@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20200114163403.FnxYXv-UTU4ZeDPRkodYVmJzljUHB1z8ZgqQugSOLVs@z>

On Wed, Dec 11, 2019 at 03:41:56PM +0000, Mark Brown wrote:
> From: Dave Martin <Dave.Martin@arm.com>
> 
> ELF program properties will be needed for detecting whether to
> enable optional architecture or ABI features for a new ELF process.
> 
> For now, there are no generic properties that we care about, so do
> nothing unless CONFIG_ARCH_USE_GNU_PROPERTY=y.
> 
> Otherwise, the presence of properties using the PT_PROGRAM_PROPERTY
> phdrs entry (if any), and notify each property to the arch code.
> 
> For now, the added code is not used.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

As with the previous patch, this should also go to linux-fsdevel.

The logic looks fine to me but I'm not sure the choice of returning -EIO
is suitable in most cases. I think apart from kernel_read() returning an
error, there rest look like malformed ELF notes, so rather -ENOEXEC.

-- 
Catalin
