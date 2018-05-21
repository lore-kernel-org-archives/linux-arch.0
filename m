Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46342 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeEUHNS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 May 2018 03:13:18 -0400
Subject: Re: [PATCH v6 17/28] x86/asm: use SYM_INNER_LABEL instead of GLOBAL
References: <20180518091721.7604-1-jslaby@suse.cz>
 <20180518091721.7604-18-jslaby@suse.cz>
 <CALCETrXwc05073E7A8KG-2dKqNyz=C2zrAQfBqWhjuChfSd5fQ@mail.gmail.com>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <d8afbe9b-96e1-87ee-ba41-1e1dc77809f5@suse.cz>
Date: Mon, 21 May 2018 09:13:15 +0200
MIME-Version: 1.0
In-Reply-To: <CALCETrXwc05073E7A8KG-2dKqNyz=C2zrAQfBqWhjuChfSd5fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Ingo Molnar <mingo@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>
Message-ID: <20180521071315.NK9IjBxSl6-vHhPGuDuhLTyTwcVox-KGd8PDVIA13TU@z>

On 05/18/2018, 09:41 PM, Andy Lutomirski wrote:
> On Fri, May 18, 2018 at 2:17 AM Jiri Slaby <jslaby@suse.cz> wrote:
> 
>> GLOBAL had several meanings and is going away. In this patch, convert
>> all the inner function labels marked with GLOBAL to use SYM_INNER_LABEL
>> instead.
> 
>> Note that retint_user needs not be global, perhaps since commit
>> 2ec67971facc ("x86/entry/64/compat: Remove most of the fast system call
>> machinery"), where entry_64_compat's caller was removed. So mark the
>> label as LOCAL.
> 
> 
>> -GLOBAL(entry_SYSCALL_64_after_hwframe)
>> +SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
> 
> I've missed all the context here.   I agree that GLOBAL is misleading, and
> "inner label" is nice.  But this is a rather wordy macro.  Would:
> 
> INNER_LABEL_GLOBAL(name)
> 
> be better?  (With just INNER_LABEL(name) for the local version?)

All the macros have SYM_ prefix. Other macros look like this:
SYM_FUNC_START_LOCAL(name)
SYM_FUNC_START(name)

So I can make the inner one:
SYM_INNER_LABEL_LOCAL(name)
SYM_INNER_LABEL(name)

to be consistent with the rest, if that is OK?

thanks,
-- 
js
suse labs
