From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCHv3 15/16] video: vermilion: Use set_memory.h header
Date: Mon, 20 Mar 2017 18:20:33 +0100
Message-ID: <2793672.rAfjMbnPi9@amdc3058>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
 <CGME20170307205649epcas3p416380b3e38150b3532dcf1742aad56ae@epcas3p4.samsung.com>
 <1488920133-27229-16-git-send-email-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:42068 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbdCTRUk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2017 13:20:40 -0400
In-reply-to: <1488920133-27229-16-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>

On Tuesday, March 07, 2017 12:55:32 PM Laura Abbott wrote:
> 
> set_memory_* functions have moved to set_memory.h. Switch to this
> explicitly.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
