Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:35166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfJKPGg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 11:06:36 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [FIXUP 0/2] Fixups to patch 5
Date: Fri, 11 Oct 2019 16:06:27 +0100
Message-ID: <1570806389-16014-1-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1570733080-21015-6-git-send-email-Dave.Martin@arm.com>
References: <1570733080-21015-6-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Amit Kachhap <amit.kachhap@arm.com>, Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <richard.henderson@linaro.org>, Sudakshina Das <sudi.das@arm.com>, Suzuki Poulose <suzuki.poulose@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20191011150627.UuMxZyjFh8RkN9NsCoISetGh0S5bbR0HtJatZmFuXOQ@z>

Here are a couple of late-breaking fixups, which may be integrated in
the next posting.

The first is trivial; the second needs discussion.


Dave Martin (2):
  squash! arm64: Basic Branch Target Identification support
  squash! arm64: Basic Branch Target Identification support

 arch/arm64/Kconfig | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.1.4
