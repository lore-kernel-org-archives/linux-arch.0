Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:38391 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeAQTQw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jan 2018 14:16:52 -0500
MIME-Version: 1.0
In-Reply-To: <CAPcyv4g94iysWqz64KNk=HDdx6+b2e0O-rRrnFZDqfNSR3Xrjg@mail.gmail.com>
References: <151586744180.5820.13215059696964205856.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151586748981.5820.14559543798744763404.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzoAR+MYX+ub0xZ32OsT7WtD5Kru2t6LhwB1buLWPResQ@mail.gmail.com>
 <CA+55aFxsg5+u7bCHj1N8xyyVf7-RMm-5ACNp=ENNrKL78omaow@mail.gmail.com>
 <CAPcyv4hfUx8gLScuNewY3+BWi4YBS_Z9dhvYf1D+WEWDDCShXA@mail.gmail.com> <CAPcyv4g94iysWqz64KNk=HDdx6+b2e0O-rRrnFZDqfNSR3Xrjg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jan 2018 11:16:50 -0800
Message-ID: <CA+55aFxdxtScVaSHU9_8v+r719r03ZHJ7KLB0CTHm8NahRgt=A@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] x86: use __uaccess_begin_nospec and ASM_IFENCE in
 get_user paths
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@linux.intel.com>
Message-ID: <20180117191650.YyUucbXSBvgW7x-7RoL-H-WR1UK4wIULIz24EEod9gk@z>

On Tue, Jan 16, 2018 at 8:30 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>
> I think the access_ok() conversion to return a speculation sanitized
> pointer or NULL is the way to go unless I'm missing something simpler.

No, that's way too big of a conversion.

Just make get_user() and friends (that currently use ASM_STAC) use the
address masking.

The people who use uaccess_begin() can use the lfence there.

Basically, the rule is trivial: find all 'stac' users, and use address
masking if those users already integrate the limit check, and lfence
they don't.

                Linus
