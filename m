From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v6 17/28] x86/asm: use SYM_INNER_LABEL instead of GLOBAL
Date: Mon, 21 May 2018 09:13:15 +0200
Message-ID: <d8afbe9b-96e1-87ee-ba41-1e1dc77809f5@suse.cz>
References: <20180518091721.7604-1-jslaby@suse.cz>
 <20180518091721.7604-18-jslaby@suse.cz>
 <CALCETrXwc05073E7A8KG-2dKqNyz=C2zrAQfBqWhjuChfSd5fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrXwc05073E7A8KG-2dKqNyz=C2zrAQfBqWhjuChfSd5fQ@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Ingo Molnar <mingo@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>
List-Id: linux-arch.vger.kernel.org

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
