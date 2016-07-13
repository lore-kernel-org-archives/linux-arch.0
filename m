Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:36129 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbcGMSnp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jul 2016 14:43:45 -0400
Received: by mail-vk0-f47.google.com with SMTP id j126so23910026vkg.3
        for <linux-arch@vger.kernel.org>; Wed, 13 Jul 2016 11:43:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160713075550.GA515@gmail.com>
References: <20160707144508.GZ11498@techsingularity.net> <577E924C.6010406@sr71.net>
 <20160708071810.GA27457@gmail.com> <577FD587.6050101@sr71.net>
 <20160709083715.GA29939@gmail.com> <CALCETrXJhVz6Za4=oidiM2Vfbb+XdggFBYiVyvOCcia+w064aQ@mail.gmail.com>
 <5783AE8F.3@sr71.net> <CALCETrW1qLZE_cq1CvmLkdnFyKRWVZuah29xERTC7o0eZ8DbwQ@mail.gmail.com>
 <5783BFB0.70203@intel.com> <CALCETrUZeZ00sFrTEqWSB-OxkCzGQxknmPTvFe4bv5mKc3hE+Q@mail.gmail.com>
 <20160713075550.GA515@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 13 Jul 2016 11:43:24 -0700
Message-ID: <CALCETrUxL2ZAn8-GDtpwQPhLeNRXXp7RM1EVX2JExE+gkWGj3g@mail.gmail.com>
Subject: Re: [PATCH 6/9] x86, pkeys: add pkey set/get syscalls
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, Al Viro <viro@zeniv.linux.org.uk>, X86 ML <x86@kernel.org>, Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linux API <linux-api@vger.kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <20160713184324.U6H6N55Gtpo8taMyiVb1zd3QMykwtxc6iP5VmMMjM6I@z>

On Wed, Jul 13, 2016 at 12:56 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Andy Lutomirski <luto@amacapital.net> wrote:
>
>> > If we push a PKRU value into a thread between the rdpkru() and wrpkru(), we'll
>> > lose the content of that "push".  I'm not sure there's any way to guarantee
>> > this with a user-controlled register.
>>
>> We could try to insist that user code uses some vsyscall helper that tracks
>> which bits are as-yet-unassigned.  That's quite messy, though.
>
> Actually, if we turned the vDSO into something more like a minimal user-space
> library with the ability to run at process startup as well to prepare stuff then
> it's painful to get right only *once*, and there will be tons of other areas where
> a proper per thread data storage on the user-space side would be immensely useful!

Doing this could be tricky: how exactly is the vDSO supposed to find
per-thread data without breaking existing glibc?
