From: Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCHv2 10/14] bpf: Use set_memory.h header
Date: Thu, 02 Mar 2017 21:26:17 +0100
Message-ID: <58B87FE9.3090206@iogearbox.net>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com> <1488413706-9739-11-git-send-email-labbott@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www62.your-server.de ([213.133.104.62]:58350 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbdCBU1g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2017 15:27:36 -0500
In-Reply-To: <1488413706-9739-11-git-send-email-labbott@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>, "David S. Miller" <davem@davemloft.net>
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, Jessica Yu <jeyu>

On 03/02/2017 01:15 AM, Laura Abbott wrote:
> set_memory_* functions have moved to set_memory.h. Switch to this
> explicitly.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
