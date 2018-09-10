Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:38979 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbeIJS2E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Sep 2018 14:28:04 -0400
MIME-Version: 1.0
References: <20180910044937.GJ19965@ZenIV.linux.org.uk> <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
 <20180910045227.9895-8-viro@ZenIV.linux.org.uk>
In-Reply-To: <20180910045227.9895-8-viro@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Sep 2018 03:33:45 -1000
Message-ID: <CA+55aFyzNWJJfHRMiEF8=Nto=O=jF6iuFTQEzEqF7rr6v_j8oQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 8/8] really consolidate INIT_C_CC definitions
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180910133345.6ntaNEDv6w3WJyTAuTA267EIcTCYrko3IOeKm7-3p0s@z>

On Sun, Sep 9, 2018 at 6:52 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>  */
> +#ifndef INIT_C_CC_VDISCARD
> +#define INIT_C_CC_VDISCARD 'O'-0x40
> +#endif

Just change everybody to do the same, nobody cares about VDISCARD.

We can change the value of VDISCARD because it doesn't actually have
anything connected to it, so don't worry about "we used to have odd
different values for it".

            Linus
