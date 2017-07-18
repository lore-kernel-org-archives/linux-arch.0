Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33114 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbdGRSXF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jul 2017 14:23:05 -0400
Subject: Re: [PATCH 1/7] signal/alpha: Document a conflict with SI_USER for
 SIGTRAP
References: <87o9shg7t7.fsf_-_@xmission.com>
 <20170718140651.15973-1-ebiederm@xmission.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e0e3c779-b00b-dc86-60f5-12f54e8d5f3a@twiddle.net>
Date: Tue, 18 Jul 2017 08:22:52 -1000
MIME-Version: 1.0
In-Reply-To: <20170718140651.15973-1-ebiederm@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, Andrei Vagin <avagin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <greg@kroah.com>, Andrey Vagin <avagin@openvz.org>, Serge Hallyn <serge@hallyn.com>, Pavel Emelyanov <xemul@virtuozzo.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Linux Containers <containers@lists.linux-foundation.org>, Michael Kerrisk <mtk.manpages@gmail.com>, Helge Deller <deller@gmx.de>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Message-ID: <20170718182252.kHtxy-DuLFsB25MWINafyVrBQ9iDpQziWbyLwwUQvSo@z>

On 07/18/2017 04:06 AM, Eric W. Biederman wrote:
> Setting si_code to __SI_FAULT results in a userspace seeing
> an si_code of 0.  This is the same si_code as SI_USER.  Posix
> and common sense requires that SI_USER not be a signal specific
> si_code.  As such this use of 0 for the si_code is a pretty
> horribly broken ABI.
> 
> Given that alpha is on it's last legs I don't know that it is worth
> fixing this, but it is worth documenting what is going on so that
> no one decides to copy this bad decision.
> 
> This was introduced during the 2.5 development cycle so this
> mess has had a long time for people to be able to depend upon it.
> 
> v2: Added FPE_FIXME for alpha as Helge Deller<deller@gmx.de>  pointed out
>      with his alternate patch one of the cases is SIGFPE not SIGTRAP.
> 
> Cc: Helge Deller<deller@gmx.de>
> Cc: Richard Henderson<rth@twiddle.net>
> Cc: Ivan Kokshaysky<ink@jurassic.park.msu.ru>
> Cc: Matt Turner<mattst88@gmail.com>
> Cc:linux-alpha@vger.kernel.org
> History Tree:https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> Ref: 0a635c7a84cf ("Fill in siginfo_t.")
> Signed-off-by: "Eric W. Biederman"<ebiederm@xmission.com>
> ---
>   arch/alpha/include/uapi/asm/siginfo.h | 14 ++++++++++++++
>   arch/alpha/kernel/traps.c             |  6 +++---
>   2 files changed, 17 insertions(+), 3 deletions(-)

Acked-by: Richard Henderson <rth@twiddle.net>


r~
