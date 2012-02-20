From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 08/30] compat: Use COMPAT_USE_64BIT_TIME in the lp driver
Date: Sun, 19 Feb 2012 16:56:11 -0800
Message-ID: <CA+55aFwiV3N-9-pB6ofN-5GBS0mnPTBGAdPH1M70wK8qr-=PQg@mail.gmail.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com> <1329696488-16970-9-git-send-email-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35207 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225Ab2BTA4c (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2012 19:56:32 -0500
In-Reply-To: <1329696488-16970-9-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, akpm@linux-foundation.org, hjl.tools@gmail.com, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <greg@kroah.com>

On Sun, Feb 19, 2012 at 4:07 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> From: "H. J. Lu" <hjl.tools@gmail.com>
>
> Enable the lp driver to be used with a compat ABI with 64-bit time.

Ugh. Is this really the only case?

Because if it isn't, I suspect it would be much better off with a
helper function. In fact, even if this *does* end up being the only
place, a helper function to get/set a timeval from user space sounds
like a good idea, and makes things much more readable than that
ad-hoccery in the middle of code.

IOW, I'd like to see something like

   get_user_timeval(void __user *tv, struct timeval *res)

even if it would be only local to this file.

                   Linus
