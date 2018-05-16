Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45930 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752272AbeEPKrh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 May 2018 06:47:37 -0400
Date: Wed, 16 May 2018 11:47:32 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm64: remove no-op macro VMLINUX_SYMBOL()
Message-ID: <20180516104732.dxt7di6t4hcss23e@armageddon.cambridge.arm.com>
References: <1525851986-28631-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525851986-28631-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Steve Capper <steve.capper@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Message-ID: <20180516104732.tkGe8qierTqVpsfTXPO4UT3vm2_lXBByYLYaAnDNeKw@z>

On Wed, May 09, 2018 at 04:46:26PM +0900, Masahiro Yamada wrote:
> VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
> is defined.  It has ever been selected only by BLACKFIN and METAG.
> VMLINUX_SYMBOL() is unneeded for ARM64-specific code.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Queued for 4.18. Thanks.

-- 
Catalin
