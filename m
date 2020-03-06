Return-Path: <SRS0=ZCnS=4X=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35648 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFLss (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 06:48:48 -0500
MIME-Version: 1.0
References: <20200306080905.173466-1-syq@debian.org> <87r1y53npd.fsf@mid.deneb.enyo.de>
 <8441f497-61eb-5c14-bf1e-c90a464105a7@vivier.eu> <87mu8t3mlw.fsf@mid.deneb.enyo.de>
 <40da389d-4e74-2644-2e7c-04d988fcc26f@vivier.eu> <CAKcpw6WEO5Rmsv+WFkOMrkH+0jwtFKKy7b2n3U9xgv-xGC0UUQ@mail.gmail.com>
 <87v9nhzp6w.fsf@mid.deneb.enyo.de>
In-Reply-To: <87v9nhzp6w.fsf@mid.deneb.enyo.de>
From: YunQiang Su <syq@debian.org>
Date: Fri, 6 Mar 2020 19:48:35 +0800
Message-ID: <CAKcpw6VF1N2gTVXeWLU4aVOuARf5oN6yPg9O=RCzgkMrjXmxYQ@mail.gmail.com>
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Laurent Vivier <laurent@vivier.eu>, torvalds@linux-foundation.org, Greg KH <gregkh@linuxfoundation.org>, akpm@linux-foundation.org, Al Viro <viro@zeniv.linux.org.uk>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, libc-alpha@sourceware.org
Message-ID: <20200306114835.5pzkhyrpATGjCUWf9H5KGap8oNFFJdAHPd-Auko5ltA@z>

Florian Weimer <fw@deneb.enyo.de> 于2020年3月6日周五 下午7:42写道：
>
> * YunQiang Su:
>
> > AT_* only has 32 slot and now. I was afraid that maybe we shouldn't take one.
> >    /* AT_* values 18 through 22 are reserved */
> >    27,28,29,30 are not used now.
> > Which should we use?
>
> Where does this limit of 32 tags come from?  I don't see it from a
> userspace perspective.

Sorry it is my mistake: In linux/auxvec.h, I saw

#define AT_RANDOM 25    /* address of 16 random bytes */
#define AT_HWCAP2 26    /* extension of AT_HWCAP */

#define AT_EXECFN  31   /* filename of program */

The number jump to 31 from 26.

It is my fault: in x86_64-linux-gnu/bits/auxv.h, the max number is 47 now.
