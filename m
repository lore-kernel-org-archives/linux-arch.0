Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53098 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224Ab2DITjv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Apr 2012 15:39:51 -0400
Received: by mail-bk0-f46.google.com with SMTP id ik5so3626443bkc.19
        for <linux-arch@vger.kernel.org>; Mon, 09 Apr 2012 12:39:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1333999988.14260.9.camel@localhost>
References: <1333051320-30872-1-git-send-email-wad@chromium.org>
	<1333051320-30872-10-git-send-email-wad@chromium.org>
	<20120406141415.93f46bc6.akpm@linux-foundation.org>
	<CABqD9hZVZQXA5cyufwWirWVUYZwSkjRxHR2CBKW5V62qD-DGtA@mail.gmail.com>
	<1333999988.14260.9.camel@localhost>
Date: Mon, 9 Apr 2012 12:39:46 -0700
Message-ID: <CAGXu5jKdxiDD40TfhgMk_dAAL9ApX+JfrfKDgRhfRCCWvpiTpg@mail.gmail.com>
Subject: Re: [kernel-hardening] Re: [PATCH v17 09/15] seccomp: remove
 duplicated failure logging
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Paris <eparis@redhat.com>
Cc: kernel-hardening@lists.openwall.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org, arnd@arndb.de, davem@davemloft.net, hpa@zytor.com, mingo@redhat.com, oleg@redhat.com, peterz@infradead.org, rdunlap@xenotime.net, mcgrathr@chromium.org, tglx@linutronix.de, luto@mit.edu, serge.hallyn@canonical.com, djm@mindrot.org, scarybeasts@gmail.com, indan@nul.nu, pmoore@redhat.com, corbet@lwn.net, eric.dumazet@gmail.com, markus@chromium.org, coreyb@linux.vnet.ibm.com, jmorris@namei.org
Message-ID: <20120409193946.iW6JWJ93Oal9Wmk5OaInvnRtHDlFMjgDgR5NoWXu8wM@z>

On Mon, Apr 9, 2012 at 12:33 PM, Eric Paris <eparis@redhat.com> wrote:
> On Mon, 2012-04-09 at 14:26 -0500, Will Drewry wrote:
>> On Fri, Apr 6, 2012 at 4:14 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
>> > On Thu, 29 Mar 2012 15:01:54 -0500
>> > Will Drewry <wad@chromium.org> wrote:
>
>> >> -void __audit_seccomp(unsigned long syscall)
>> >> +void __audit_seccomp(unsigned long syscall, long signr, int code)
>> >>  {
>> >>       struct audit_buffer *ab;
>> >>
>> >>       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_ANOM_ABEND);
>> >> -     audit_log_abend(ab, "seccomp", SIGKILL);
>> >> +     audit_log_abend(ab, "seccomp", signr);
>> >>       audit_log_format(ab, " syscall=%ld", syscall);
>> >> +#ifdef CONFIG_COMPAT
>> >> +     audit_log_format(ab, " compat=%d", is_compat_task());
>> >> +#endif
>> >
>> > We don't need the ifdef for compilation reasons now.
>> >
>> > The question is: should we emit the compat= record on
>> > non-compat-capable architectures?  Doing so would be safer - making it
>> > conditional invites people to write x86-only usersapce.
>>
>> I'd certainly prefer it always being there for exactly that reason.
>>
>> Kees, Eric, any preferences?  Unless I hear one, I'll just drop the
>> ifdefs in the next revision.
>
> I'd just leave it in unconditionally.  The audit parse libraries would
> handle it just fine, but that doesn't mean everyone uses that tool to
> parse the text.

Related to this, can we get this patch into a tree as well?
https://lkml.org/lkml/2012/3/23/332

Thanks,

-Kees

-- 
Kees Cook
ChromeOS Security
