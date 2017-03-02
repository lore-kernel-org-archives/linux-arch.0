From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCHv2 08/14] intel_th: Use set_memory.h header
Date: Thu, 02 Mar 2017 13:06:21 +0200
Message-ID: <878too2b0y.fsf@ashishki-desk.ger.corp.intel.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com> <1488413706-9739-9-git-send-email-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:10861 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751055AbdCBLGa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Mar 2017 06:06:30 -0500
In-Reply-To: <1488413706-9739-9-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, "David S. Miller" <davem@davem>

Laura Abbott <labbott@redhat.com> writes:

> set_memory_* functions have moved to set_memory.h. Switch to this
> explicitly.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Thanks,
