Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:50033 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754303Ab2B0SJm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 27 Feb 2012 13:09:42 -0500
Received: by mail-tul01m020-f174.google.com with SMTP id va7so5767487obc.19
        for <linux-arch@vger.kernel.org>; Mon, 27 Feb 2012 10:09:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120227171132.GB10608@redhat.com>
References: <1330140111-17201-1-git-send-email-wad@chromium.org>
	<1330140111-17201-7-git-send-email-wad@chromium.org>
	<20120227171132.GB10608@redhat.com>
Date: Mon, 27 Feb 2012 10:09:38 -0800
Message-ID: <CAGXu5jJQhfSSwTU5fSGR_Q57LAQBFW25A_FtR2GFsxyT_ibnzQ@mail.gmail.com>
Subject: Re: [PATCH v11 07/12] seccomp: add SECCOMP_RET_ERRNO
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com, netdev@vger.kernel.org, x86@kernel.org, arnd@arndb.de, davem@davemloft.net, hpa@zytor.com, mingo@redhat.com, peterz@infradead.org, rdunlap@xenotime.net, mcgrathr@chromium.org, tglx@linutronix.de, luto@mit.edu, eparis@redhat.com, serge.hallyn@canonical.com, djm@mindrot.org, scarybeasts@gmail.com, indan@nul.nu, pmoore@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, eric.dumazet@gmail.com, markus@chromium.org, coreyb@linux.vnet.ibm.com
Message-ID: <20120227180938.gqI6SjR1LJ8XwKw6NZv9zklPbeVZiUgIV0Q5S5Ra-O8@z>

On Mon, Feb 27, 2012 at 9:11 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 02/24, Will Drewry wrote:
>>
>>  static u32 seccomp_run_filters(int syscall)
>>  {
>>       struct seccomp_filter *f;
>> -     u32 ret = SECCOMP_RET_KILL;
>>       static const struct bpf_load_fn fns = {
>>               bpf_load,
>>               sizeof(struct seccomp_data),
>>       };
>> +     u32 ret = SECCOMP_RET_ALLOW;
>>       const void *sc_ptr = (const void *)(uintptr_t)syscall;
>>
>> +     /* Ensure unexpected behavior doesn't result in failing open. */
>> +     if (unlikely(current->seccomp.filter == NULL))
>> +             ret = SECCOMP_RET_KILL;
>
> Is "seccomp.filter == NULL" really possible?

It should not be, but I'm much more comfortable with this failing
closed. I think it's important to be as defensive as possible with
this code given its intended use.

-Kees

-- 
Kees Cook
ChromeOS Security
