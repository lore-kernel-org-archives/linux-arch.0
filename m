Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34814 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfBZOfx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Feb 2019 09:35:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id u9so6345650pfn.1
        for <linux-arch@vger.kernel.org>; Tue, 26 Feb 2019 06:35:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550839937.git.andreyknvl@google.com> <a958e202cdbe6e1bac8a37b7f3d9881d1b22993d.1550839937.git.andreyknvl@google.com>
 <a38275b0-f6cd-20e1-3c48-544846586a16@intel.com>
In-Reply-To: <a38275b0-f6cd-20e1-3c48-544846586a16@intel.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 26 Feb 2019 15:35:40 +0100
Message-ID: <CAAeHK+wLm7zSUC8dJv3LgdyvpkBN8u_24ene6b91PgM570VWbQ@mail.gmail.com>
Subject: Re: [PATCH v10 06/12] fs, arm64: untag user pointers in copy_mount_options
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Message-ID: <20190226143540.BgEds2G4oCMrJsfj14nAiU_K0KD8QDBJpQG9PkZwVjI@z>

On Sat, Feb 23, 2019 at 12:03 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/22/19 4:53 AM, Andrey Konovalov wrote:
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -2730,7 +2730,7 @@ void *copy_mount_options(const void __user * data)
> >        * the remainder of the page.
> >        */
> >       /* copy_from_user cannot cross TASK_SIZE ! */
> > -     size = TASK_SIZE - (unsigned long)data;
> > +     size = TASK_SIZE - (unsigned long)untagged_addr(data);
> >       if (size > PAGE_SIZE)
> >               size = PAGE_SIZE;
>
> I would have thought that copy_from_user() *is* entirely capable of
> detecting and returning an error in the case that its arguments cross
> TASK_SIZE.  It will fail and return an error, but that's what it's
> supposed to do.
>
> I'd question why this code needs to be doing its own checking in the
> first place.  Is there something subtle going on?

The comment above exact_copy_from_user() states:

Some copy_from_user() implementations do not return the exact number of
bytes remaining to copy on a fault.  But copy_mount_options() requires that.
Note that this function differs from copy_from_user() in that it will oops
on bad values of `to', rather than returning a short copy.
