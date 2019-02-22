Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36942 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBVOJZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Feb 2019 09:09:25 -0500
Date: Fri, 22 Feb 2019 14:09:16 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v5 08/23] arm64: compat: Add KUSER_HELPERS config option
Message-ID: <20190222140916.cgnq22trogt4dnzc@shell.armlinux.org.uk>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-9-vincenzo.frascino@arm.com>
 <20190222140427.GI42419@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222140427.GI42419@lakrids.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190222140916.nztcFwNJaJU8TkhRO-ERA6ezw5AiXkLWxjmsQrI2ZPc@z>

On Fri, Feb 22, 2019 at 02:04:27PM +0000, Mark Rutland wrote:
> I believe that Will wanted to default the kuser helpers off, as applications
> using them need the instruction emulation which is also disabled by default.
> 
> I'm also not sure which binaries we expect to work on arm64, so I'm not sure if
> the ARMv4 reference is correct.

Do you expect ARMv4 - even ARMv4 OABI binaries to fail on ARM64?

(I've run my OABI ARMv4 distro under KVM on Macchiatobin when I've
needed to rebuild a RPM without problems - using its own gcc.  No
observable issues.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
