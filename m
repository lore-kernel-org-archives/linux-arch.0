Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33517 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfKTIdM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Nov 2019 03:33:12 -0500
Received: by mail-ot1-f65.google.com with SMTP id u13so20508131ote.0
        for <linux-arch@vger.kernel.org>; Wed, 20 Nov 2019 00:33:10 -0800 (PST)
MIME-Version: 1.0
References: <20190820024941.12640-1-dja@axtens.net> <877e6vutiu.fsf@dja-thinkpad.axtens.net>
 <878sp57z44.fsf@dja-thinkpad.axtens.net> <CANpmjNOCxTxTpbB_LwUQS5jzfQ_2zbZVAc4nKf0FRXmrwO-7sA@mail.gmail.com>
 <87a78xgu8o.fsf@dja-thinkpad.axtens.net> <87y2wbf0xx.fsf@dja-thinkpad.axtens.net>
In-Reply-To: <87y2wbf0xx.fsf@dja-thinkpad.axtens.net>
From: Marco Elver <elver@google.com>
Date: Wed, 20 Nov 2019 09:32:55 +0100
Message-ID: <CANpmjNN-=F6GK_jHPUx8OdpboK7nMV=i=sKKfSsKwKEHnMTG0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kasan: support instrumented bitops combined with
 generic bitops
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Axtens <dja@axtens.net>
Cc: christophe.leroy@c-s.fr, linux-s390@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linuxppc-dev@lists.ozlabs.org, kasan-dev <kasan-dev@googlegroups.com>
Message-ID: <20191120083255.fD1cvmN450wEUAZUDiGIaSIKpi5-iNkepSUDoMhh7d0@z>

On Wed, 20 Nov 2019 at 08:42, Daniel Axtens <dja@axtens.net> wrote:
>
> > But the docs do seem to indicate that it's atomic (for whatever that
> > means for a single read operation?), so you are right, it should live in
> > instrumented-atomic.h.
>
> Actually, on further inspection, test_bit has lived in
> bitops/non-atomic.h since it was added in 4117b02132d1 ("[PATCH] bitops:
> generic __{,test_and_}{set,clear,change}_bit() and test_bit()")
>
> So to match that, the wrapper should live in instrumented-non-atomic.h
> too.
>
> If test_bit should move, that would need to be a different patch. But I
> don't really know if it makes too much sense to stress about a read
> operation, as opposed to a read/modify/write...

That's fair enough. I suppose this can stay where it is because it's
not hurting anyone per-se, but the only bad thing about it is that
kernel-api documentation will present test_bit() in non-atomic
operations.

Thanks,
-- Marco
