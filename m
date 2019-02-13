Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43280 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfBMUET (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2019 15:04:19 -0500
Received: by mail-lf1-f66.google.com with SMTP id j1so2744549lfb.10
        for <linux-arch@vger.kernel.org>; Wed, 13 Feb 2019 12:04:18 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id z85sm38942lff.80.2019.02.13.12.04.16
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 12:04:16 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id f24-v6so3164470ljk.0
        for <linux-arch@vger.kernel.org>; Wed, 13 Feb 2019 12:04:16 -0800 (PST)
MIME-Version: 1.0
References: <1549566446-27967-1-git-send-email-longman@redhat.com> <20190213091936.GA22829@shao2-debian>
In-Reply-To: <20190213091936.GA22829@shao2-debian>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Feb 2019 11:56:38 -0800
Message-ID: <CAHk-=wiF2qv4TdKOTaTYeMnmsn4h6z9ot+MRj1=s7dm5y1FUwQ@mail.gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Rong <rong.a.chen@intel.com>
Cc: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "IngoMolnar@shao2-debian" <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Andrew Morton <akpm@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <20190213195638.i_pKDFTrRdHUrXTy0A0ngM19xJ_Uw5DyzUijNGy5yLQ@z>

Ok, those test robot reports are hard to read, but trying to distill it dow=
n:

On Wed, Feb 13, 2019 at 1:19 AM Chen Rong <rong.a.chen@intel.com> wrote:
>
>          %stddev     %change         %stddev
>              \          |                \
>     196250 =C2=B1  8%     -64.1%      70494        will-it-scale.per_thre=
ad_ops

That's the original 64% regression..

And then with the patch set:

>          %stddev      change         %stddev
>              \          |                \
>      71190             180%     199232 =C2=B1  4%  will-it-scale.per_thre=
ad_ops

looks like it's back up where it used to be.

So I guess we have numbers for the regression now. Thanks.

And that closes my biggest question for the new model, and with the
new organization that gets ird of the arch-specific asm separately
first and makes it a bit more legible that way, I guess I'll just Ack
the whole series.

             Linus
