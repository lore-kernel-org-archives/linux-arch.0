From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/18] asm-generic/barrier: add generic nospec helpers
Date: Fri, 5 Jan 2018 18:55:32 -0800
Message-ID: <CA+55aFxoU1B7VECQ3T9CRkX07Y8sw=fGg6Miry1GniqJOd68sA@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520099810.32271.11023910901471332353.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:41249 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753557AbeAFCzd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Jan 2018 21:55:33 -0500
In-Reply-To: <151520099810.32271.11023910901471332353.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>

On Fri, Jan 5, 2018 at 5:09 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> +#ifndef nospec_ptr
> +#define nospec_ptr(ptr, lo, hi)                                                \

Do we actually want this horrible interface?

It just causes the compiler - or inline asm - to generate worse code,
because it needs to compare against both high and low limits.

Basically all users are arrays that are zero-based, and where a
comparison against the high _index_ limit would be sufficient.

But the way this is all designed, it's literally designed for bad code
generation for the unusual case, and the usual array case is written
in the form of the unusual and wrong non-array case. That really seems
excessively stupid.

             Linus
