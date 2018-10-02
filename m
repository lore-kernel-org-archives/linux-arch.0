Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f68.google.com ([209.85.166.68]:36134 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeJBUDR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Oct 2018 16:03:17 -0400
Received: by mail-io1-f68.google.com with SMTP id p4-v6so2035579iom.3
        for <linux-arch@vger.kernel.org>; Tue, 02 Oct 2018 06:19:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180928175013.GC193149@arrakis.emea.arm.com>
References: <cover.1535629099.git.andreyknvl@google.com> <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
 <CA+55aFyW9N2tSb2bQvkthbVVyY6nt5yFeWQRLHp1zruBmb5ocw@mail.gmail.com>
 <CA+55aFy2t_MHgr_CgwbhtFkL+djaCq2qMM1G+f2DwJ0qEr1URQ@mail.gmail.com>
 <20180907152600.myidisza5o4kdmvf@armageddon.cambridge.arm.com>
 <CA+55aFzQ+ykLu10q3AdyaaKJx8SDWWL9Qiu6WH2jbN_ugRUTOg@mail.gmail.com>
 <20180911164152.GA29166@arrakis.emea.arm.com> <CAAeHK+z4HOF_PobxSys8svftWt8dhbuUXEpq2sdXBTCXwTEH2g@mail.gmail.com>
 <20180928175013.GC193149@arrakis.emea.arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 2 Oct 2018 15:19:57 +0200
Message-ID: <CAAeHK+xK2Nb6J6YbvUJdXaZoecB0GS2UyY6pgGwrfCoOQJ34xg@mail.gmail.com>
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by sparse
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Kostya Serebryany <kcc@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Chintan Pandya <cpandya@codeaurora.org>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Evgenii Stepanov <eugenis@google.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Robin Murphy <robin.murphy@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, Dmitry Vyukov <dvyukov@google.com>, linux-mm <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20181002131957.2i4RrdgDItGzvz35A1ctKT2JP7G2AXsny1gG8q3OKUA@z>

On Fri, Sep 28, 2018 at 7:50 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Mon, Sep 17, 2018 at 07:01:00PM +0200, Andrey Konovalov wrote:

>> Looking at patch #8 ("usb, arm64: untag user addresses in devio") in
>> this series, it seems that that devio ioctl actually accepts a pointer
>> into a vma, so we shouldn't actually be untagging its argument and the
>> patch needs to be dropped.
>
> You are right, the pointer seems to have originated from the kernel as
> already untagged (mmap() on the driver), so we would expect the user to
> pass it back an untagged pointer.

OK, dropped this patch in v7.

>> As for case 1, the places where pointers are compared with TASK_SIZE
>> and others can be found with grep. Maybe it makes sense to introduce
>> some kind of routine like is_user_pointer() that handles tagged
>> pointers and refactor the existing code to use it? And maybe add a
>> rule to checkpatch.pl that forbids the direct usage of TASK_SIZE and
>> others.
>>
>> So I think detecting direct comparisons with TASK_SIZE and others
>> would more useful than finding __user pointer casts (it seems that the
>> latter requires a lot of annotations to be fixed/added), and I should
>> just drop this patch with annotations.
>
> I think point (1) is not too bad, usually found with grep.
>
> As I've said in my previous reply, I kind of came to the same conclusion
> that searching __user pointer casts to long may not actually scale. If
> we could add an __untagged annotation to ulong where it matters (e.g.
> find_vma()), we could identify a ulong (default tagged) and annotate
> some of those.
>
> However, this analysis on __user * casting was useful even if we don't
> end up using it. If we come up with a clearer definition of the ABI
> (which syscalls accept tagged pointers), we may conclude that the only
> places where untagging matters are a few find_vma() calls in the arch
> and mm code and can ignore the rest.

So what exactly should I do now?

For now I've posted v7 with the sparse annotation patch dropped (to
have the most up-do-date version posted).
