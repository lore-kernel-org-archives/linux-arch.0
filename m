Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36641 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJEFb3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Oct 2018 01:31:29 -0400
MIME-Version: 1.0
References: <20181004222953.2229-1-hpa@zytor.com> <20181004222953.2229-6-hpa@zytor.com>
In-Reply-To: <20181004222953.2229-6-hpa@zytor.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 4 Oct 2018 15:35:33 -0700
Message-ID: <CAMo8BfJRvmNu=oHb4MaB_M7mdR5dMZRgfHb-Me8En3OoUe5m8g@mail.gmail.com>
Subject: Re: [PATCH 5/5] arch/xtensa, termios: use <asm-generic/termbits.h>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-serial@vger.kernel.org, Chris Zankel <chris@zankel.net>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, pombredanne@nexb.com, kstewart@linuxfoundation.org, linux-xtensa@linux-xtensa.org, Jiri Slaby <jslaby@suse.com>
Message-ID: <20181004223533.iLuA38_FAd8OCPugqZPEh0L9OD31RmN8FDBkWB5354E@z>

On Thu, Oct 4, 2018 at 3:30 PM H. Peter Anvin (Intel) <hpa@zytor.com> wrote:
>
> The Xtensa definition of termbits.h is identical to the generic one.
>
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: <linux-xtensa@linux-xtensa.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> ---
>  arch/xtensa/include/uapi/asm/termbits.h | 222 +-------------------------------
>  1 file changed, 1 insertion(+), 221 deletions(-)

Looks good. But why not removing the header entirely and adding
generic-y += termbits.h
to arch/xtensa/include/uapi/asm/Kbuild?

-- 
Thanks.
-- Max
