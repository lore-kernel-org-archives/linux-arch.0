Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:54537 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933056AbaKMOnU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Nov 2014 09:43:20 -0500
Received: by mail-qg0-f49.google.com with SMTP id z60so10478988qgd.22
        for <linux-arch@vger.kernel.org>; Thu, 13 Nov 2014 06:43:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141112135009.5a887d200be262d94ba50495@linux-foundation.org>
References: <1415379664-31555-1-git-send-email-drysdale@google.com> <20141112135009.5a887d200be262d94ba50495@linux-foundation.org>
From: David Drysdale <drysdale@google.com>
Date: Thu, 13 Nov 2014 14:42:58 +0000
Message-ID: <CAHse=S_uQGmzz+umKDfJPOaT2+TAdzbtjZeVZaj1i4NBVWy35g@mail.gmail.com>
Subject: Re: [PATCHv7 0/3] syscalls,x86: Add execveat() system call
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Rich Felker <dalias@aerifal.cx>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andy Lutomirski <luto@amacapital.net>, Alexander Viro <viro@zeniv.linux.org.uk>, Meredydd Luff <meredydd@senatehouse.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>
Message-ID: <20141113144258.4qwaGM4G2p4sidTWRVz6nfSzxL6mn_P9hmHc6HayvFE@z>

On Wed, Nov 12, 2014 at 9:50 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri,  7 Nov 2014 17:01:01 +0000 David Drysdale <drysdale@google.com> wrote:
>
>> This patch set adds execveat(2) for x86, and is derived from Meredydd
>> Luff's patch from Sept 2012 (https://lkml.org/lkml/2012/9/11/528).
>>
>> The primary aim of adding an execveat syscall is to allow an
>> implementation of fexecve(3) that does not rely on the /proc
>> filesystem, at least for executables (rather than scripts).  The
>> current glibc version of fexecve(3) is implemented via /proc, which
>> causes problems in sandboxed or otherwise restricted environments.
>
> Have the relevant glibc people seen/reviewed/liked this?

I think it's been mentioned in passing but not explicitly discussed over there
(https://sourceware.org/ml/libc-alpha/2014-10/msg00497.html,
https://sourceware.org/ml/libc-alpha/2014-10/msg00509.html)
and a couple of the participants in that thread (Christoph Hellwig, Rich Felker)
were also cc:ed here.

It sounded like execveat might be useful for another feature (O_EXEC) but
I'm not sure whether that amounts to the relevant glibc folk liking this...
