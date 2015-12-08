Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33719 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932723AbbLHFwv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Dec 2015 00:52:51 -0500
Received: by oixx65 with SMTP id x65so5018764oix.0
        for <linux-arch@vger.kernel.org>; Mon, 07 Dec 2015 21:52:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151208051505.GL20997@ZenIV.linux.org.uk>
References: <CALCETrWkrtiwCVpqiWuD1Hf2BekCo+5F_orQdN2-K3osqze4Uw@mail.gmail.com>
 <11525805.FykVOSlruZ@wuerfel> <20151208043648.GA2182@gmail.com>
 <20151208044937.GK20997@ZenIV.linux.org.uk> <20151208050148.GA3968@gmail.com> <20151208051505.GL20997@ZenIV.linux.org.uk>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 7 Dec 2015 21:52:31 -0800
Message-ID: <CALCETrXSS3K8v_o18F50nmdUtZ1DAhnbmFtnLgrqwH1SXPxiOg@mail.gmail.com>
Subject: Re: [PSEUDOPATCH] rename is_compat_task
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>
Message-ID: <20151208055231.TrUuZjB5s7_WUCLOkgTuJSbnhbP40dICP4prawTJOCM@z>

On Mon, Dec 7, 2015 at 9:15 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, Dec 08, 2015 at 06:01:48AM +0100, Ingo Molnar wrote:
>
>> Hm, so if Sparc has no notion of compat-ness of the system call then how does it
>> implement runtime compat checks, such as AUDIT_ARCH et al?
>
> Badly.  Things like compat_sys_ioctl() vs. ioctl() work (we use different
> arrays of function pointers in 32bit and 64bit traps), but anything
> dynamic assumes that things match the task.  Not that we had a lot of
> such dynamic checks, actually...

I wouldn't take x86 as a shining example of how to do this, but it
does mostly work.  In 4.4, it's not even all that messy, modulo a
bunch of checks that check the wrong condition (hence, in part, this
proposal).

--Andy
