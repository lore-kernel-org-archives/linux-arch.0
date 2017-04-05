Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:35844 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932913AbdDESoY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2017 14:44:24 -0400
MIME-Version: 1.0
In-Reply-To: <20170405080857.GR29622@ZenIV.linux.org.uk>
References: <20170329055706.GH29622@ZenIV.linux.org.uk> <20170405050507.GQ29622@ZenIV.linux.org.uk>
 <20170405080857.GR29622@ZenIV.linux.org.uk>
From: Tony Luck <tony.luck@gmail.com>
Date: Wed, 5 Apr 2017 11:44:23 -0700
Message-ID: <CA+8MBbKVJ030N4fJ=jzXaMoEePV4v0PVAs_OJ0p9Lg+VTJDeLw@mail.gmail.com>
Subject: Re: ia64 exceptions (Re: [RFC][CFT][PATCHSET v1] uaccess unification)
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>
Message-ID: <20170405184423.DDjE44kGrta2s1qtBoKbI1el1taibpFmQYhwHIsvQ2g@z>

On Wed, Apr 5, 2017 at 1:08 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> ... and sure enough, on generic kernel (CONFIG_ITANIUM) that yields a nice
> shiny oops at precisely that insn.

The right fix here might be to delete all the CONFIG_ITANIUM paths. I
doubt that anyone is still running upstream kernels on Merced CPUs
(and if they are, it might be a kindness to them to make them stop).

> We really need tests for uaccess primitives.  That's not a recent regression,
> BTW - it had been that way since 2.3.48-pre2, as far as I can see.

Probably be handy for new architectures to test all the corner cases.

-Tony
