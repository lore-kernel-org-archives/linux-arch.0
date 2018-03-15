From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 12/16] asm-generic: siginfo: remove obsolete #ifdefs
Date: Thu, 15 Mar 2018 05:06:29 -0500
Message-ID: <87po45hcuy.fsf@xmission.com>
References: <20180314143529.1456168-1-arnd@arndb.de>
        <20180314144614.1632190-1-arnd@arndb.de>
        <20180314144614.1632190-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314144614.1632190-2-arnd@arndb.de> (Arnd Bergmann's message
        of "Wed, 14 Mar 2018 15:43:47 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The frv, tile and blackfin architectures are being removed, so
> we can clean up this header by removing all the special cases
> except those for ia64.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/uapi/asm-generic/siginfo.h | 36 ++----------------------------------
>  1 file changed, 2 insertions(+), 34 deletions(-)
>

If I am reading siginfo.h correctly after this cleanup patch
we can perform another cleanup and unconditionally define
all of the ia64 si_codes except for __SEGV_PSTKOVF which
aliases SEGV_PKUERR.

Which has the advantage that no one is tempted to define any further
aliased si_codes.

Eric
