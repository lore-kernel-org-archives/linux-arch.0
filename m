Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:43830 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeCOKHT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Mar 2018 06:07:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20180314143529.1456168-1-arnd@arndb.de>
        <20180314144614.1632190-1-arnd@arndb.de>
        <20180314144614.1632190-2-arnd@arndb.de>
Date: Thu, 15 Mar 2018 05:06:29 -0500
In-Reply-To: <20180314144614.1632190-2-arnd@arndb.de> (Arnd Bergmann's message
        of "Wed, 14 Mar 2018 15:43:47 +0100")
Message-ID: <87po45hcuy.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 12/16] asm-generic: siginfo: remove obsolete #ifdefs
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20180315100629.e4zUSBrSyfeg8mfRdX91NubPfQeEDqB6PTOY4_O5VUI@z>

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
