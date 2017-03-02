Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44048 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752618AbdCBM0B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2017 07:26:01 -0500
Date: Thu, 2 Mar 2017 12:01:52 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCHv2 02/14] arm: Use set_memory.h header
Message-ID: <20170302120152.GJ21222@n2100.armlinux.org.uk>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-3-git-send-email-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488413706-9739-3-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Takashi Iwai <tiwai@suse.com>, Wim Van Sebroeck <wim@iguana.be>, "H. Peter Anvin" <hpa@zytor.com>, linux-watchdog@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Jessica Yu <jeyu@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, x86@kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Guenter Roeck <linux@roeck-us.net>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20170302120152.tBqMll3vfX1LKZg26NVlJs3I2NCuciersOQ4iS3HgeI@z>

On Wed, Mar 01, 2017 at 04:14:54PM -0800, Laura Abbott wrote:
> 
> set_memory_* functions have moved to set_memory.h. Switch to this
> explicitly
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks for doing this Laura.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
