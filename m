Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752720AbeBFUuB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Feb 2018 15:50:01 -0500
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com [209.85.223.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B646B217B8
        for <linux-arch@vger.kernel.org>; Tue,  6 Feb 2018 20:50:00 +0000 (UTC)
Received: by mail-io0-f171.google.com with SMTP id z6so3921247iob.11
        for <linux-arch@vger.kernel.org>; Tue, 06 Feb 2018 12:50:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+55aFzZVL=WVuhJAQDazj59jwnmhUrRRwNgzXS+c-q5yva0iw@mail.gmail.com>
References: <151632009605.21271.11304291057104672116.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151632014097.21271.16980532033566583357.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206192925.qkmghwsbaysr4iv2@hermes.olymp> <CAPcyv4ihN6fy5-vBtfA0PuwXvCAj8-rMhtQmevh5sdYxbH3Yfw@mail.gmail.com>
 <CA+55aFxYHX3=HN4P5M0ziSJ08WfjccyhE2T7epS-EC6ZJ6LyjQ@mail.gmail.com>
 <CAPcyv4i5oORdk-Fzypxw_+gCLUa8f=w1e_n0=47P7uHR-jT6GQ@mail.gmail.com> <CA+55aFzZVL=WVuhJAQDazj59jwnmhUrRRwNgzXS+c-q5yva0iw@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 6 Feb 2018 20:49:39 +0000
Message-ID: <CALCETrXV3rHb7Z8iaoieAJ5hRY0+UT7eTknxe4-FiOoke9XoGg@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] x86: narrow out of bounds syscalls to sys_read
 under speculation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Luis Henriques <lhenriques@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Greg KH <gregkh@linuxfoundation.org>, X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>
Message-ID: <20180206204939.7aF5MpXXIa5PTHptqzP-VIdibnXQEWHttzBIeeCDlgI@z>

On Tue, Feb 6, 2018 at 8:42 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Feb 6, 2018 at 12:37 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> Are there any compilers that would miscompile:
>>
>>     mask = 0 - (index < size);
>>
>> That might be a way to improve the assembly.
>
> Sadly, that is *very* easy to miscompile. In fact, I'd be very
> surprised indeed if any compiler worth its name wouldn't combine the
> comparison with the conditional branch it accompanies, and just turn
> that into a constant. IOW, you'd get
>
>         mask = 0 - (index < size);
>         if (index <= size) {
>                  ... use mask ..
>
> and the compiler would just turn that into
>
>         if (index <= size) {
>                 mask = -1;
>
> and be done with it.
>
>                Linus

Can you use @cc to make an asm statement that outputs both the masked
array index and the "if" condition?  I can never remember the syntax,
but something like:

asm ("cmp %[limit], %[index]\n\tcmovae %[zero], %[index]" : [index]
"+" (index), "@ccb" (result));

Then you shove this into a statement expression macro so you can do:

if (index_mask_nospec(&nr, NR_syscalls)) {
  ... sys_call_table[nr] ..;
}

(Caveat emptor: I can also *ever* remember which way the $*!& AT&T
syntax cmp instruction goes.)

A down side is that nr actually ends up containing zero outside the
if.  *That* could be avoided with jump labels.

--Andy
