Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751148AbdCBPHi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Mar 2017 10:07:38 -0500
Date: Thu, 2 Mar 2017 15:05:50 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCHv2 14/14] treewide: Decouple cacheflush.h and set_memory.h
Message-ID: <20170302150550.GC12157@e104818-lin.cambridge.arm.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-15-git-send-email-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488413706-9739-15-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Daniel Borkmann <daniel@iogearbox.net>, Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20170302150550.9mRmfnzrfH_r1prU9s6l4QruHqhA79hTecuEyhi9A7w@z>

On Wed, Mar 01, 2017 at 04:15:06PM -0800, Laura Abbott wrote:
> Now that all call sites, completely decouple cacheflush.h and
> set_memory.h
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
