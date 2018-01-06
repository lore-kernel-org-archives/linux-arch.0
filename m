Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42209 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbeAFFXH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Jan 2018 00:23:07 -0500
Received: by mail-oi0-f66.google.com with SMTP id o64so4398811oia.9
        for <linux-arch@vger.kernel.org>; Fri, 05 Jan 2018 21:23:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+55aFxoU1B7VECQ3T9CRkX07Y8sw=fGg6Miry1GniqJOd68sA@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520099810.32271.11023910901471332353.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFxoU1B7VECQ3T9CRkX07Y8sw=fGg6Miry1GniqJOd68sA@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 5 Jan 2018 21:23:06 -0800
Message-ID: <CAPcyv4jAt5HTc5iB7603tnvDqdFZ1+JhpekekcZwuVR3g6jjVw@mail.gmail.com>
Subject: Re: [PATCH 01/18] asm-generic/barrier: add generic nospec helpers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>
Message-ID: <20180106052306.Cvb_-HY8y4VrEZJ78CqHFYVQRbajcRAB6mnLbMNmHC4@z>

On Fri, Jan 5, 2018 at 6:55 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jan 5, 2018 at 5:09 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>> +#ifndef nospec_ptr
>> +#define nospec_ptr(ptr, lo, hi)                                                \
>
> Do we actually want this horrible interface?
>
> It just causes the compiler - or inline asm - to generate worse code,
> because it needs to compare against both high and low limits.
>
> Basically all users are arrays that are zero-based, and where a
> comparison against the high _index_ limit would be sufficient.
>
> But the way this is all designed, it's literally designed for bad code
> generation for the unusual case, and the usual array case is written
> in the form of the unusual and wrong non-array case. That really seems
> excessively stupid.

Yes, it appears we can kill nospec_ptr() and move nospec_array_ptr()
to assume 0 based arrays rather than use nospec_ptr.
