Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39552 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfAGCje (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jan 2019 21:39:34 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so36841856ljh.6
        for <linux-arch@vger.kernel.org>; Sun, 06 Jan 2019 18:39:33 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id j138sm12431640lfg.64.2019.01.06.18.39.29
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 18:39:30 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id s5-v6so36806427ljd.12
        for <linux-arch@vger.kernel.org>; Sun, 06 Jan 2019 18:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20190106180927.GA11993@roeck-us.net> <CAHk-=whyNbpBtPyoS=wh4nVgBtUBpihcOT+LFdEw369kYjATaQ@mail.gmail.com>
In-Reply-To: <CAHk-=whyNbpBtPyoS=wh4nVgBtUBpihcOT+LFdEw369kYjATaQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 6 Jan 2019 18:39:13 -0800
Message-ID: <CAHk-=wiSVm6j1Ga8gra6hSQQSK8WF5bW4DtRi4V7mCtCUkTaQw@mail.gmail.com>
Subject: Re: [PATCH] make 'user_access_begin()' do 'access_ok()'
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>, Matt Turner <mattst88@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Paul Burton <paul.burton@mips.com>, Greentime Hu <green.hu@gmail.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-kernel@vger.kenrel.org, linux-arch <linux-arch@vger.kernel.org>

On Sun, Jan 6, 2019 at 11:15 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I think I see what may be the problem. I think the alpha version
> of "access_ok()" is buggy.

Ok, so the alpha and SH cases got fixed (hopefully correctly) by
commit 94bd8a05cd4d ("Fix 'acccess_ok()' on alpha and SH") but I'm
looking around, and finding some suspicious access_ok() cases
elsewhere too.

Adding a few more people just to ask them to check their situation..

MIPS does a very similar

      return (get_fs().seg & (addr | (addr + size) | __ua_size(size))) == 0;

thing to what alpha used to do, where "addr+size" may have the same
off-by-one error. At least MIPS uses an inline function, so it doesn't
have the "arguments used twice" issue.

nds32 seems to get the range check right, but has the "macro arguments
used twice" problem.

nios2 seems to have all the bugs alpha had.

openrisc has the "macro arguments used twice" problem. And also gets
the parenthesis *completely* wrong when casting, resulting in random
behavior. This code:

  #define access_ok(addr, size) \
      __range_ok((unsigned long)addr, (unsigned long)size)

does all kinds of odd things if "addr" or "size" is not a simple
expression, since the cast tends to have higher precedence than pretty
much anything else.

xtensa has the "macro arguments used twice" problem.

So it looks like a lot of architectures have problems in access_ok.
Can we have people look at it?

See that commit 94bd8a05cd4d for a longer explanation of what alpha
and SH got wrong.

NOTE! I only took a very quick look, the above may be incomplete
and/or actively wrong. Maybe I claimed something was buggy that
wasn't, but please take a look.

              Linus
