Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:38098 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbaF0Tbj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jun 2014 15:31:39 -0400
Received: by mail-la0-f49.google.com with SMTP id gf5so3236340lab.22
        for <linux-arch@vger.kernel.org>; Fri, 27 Jun 2014 12:31:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140627192753.GA30752@redhat.com>
References: <CAGXu5jJkFxh4K=40xuh6tu3kUf4oJM8Dry+4upBdRieW3FNLgw@mail.gmail.com>
 <CALCETrUBNmLnpa+LM91om2RSpR6SjupP-EdefzhU1Me4nv3Dfw@mail.gmail.com>
 <CAGXu5j+J11zJnuFR8bYKAXizAHhCx4R+uJE_QH6zC3q2udkpaQ@mail.gmail.com>
 <CALCETrVrs8sb19+UUqyFEpAFzTih5dkAwn-WpQjfgPcPJMpP5g@mail.gmail.com>
 <20140625173245.GA17695@redhat.com> <CALCETrUc65H+fn6dtMdYnB_xR39wcmgDdTbdR3fFRjyrndJhgA@mail.gmail.com>
 <20140625175136.GA18185@redhat.com> <CAGXu5jL17k6=GXju6x+eLU20FMwBHhnuRiHoQD1Bzj_EmpiKjg@mail.gmail.com>
 <CALCETrVNwhWSPNiBiZmgP1nD9zLJPTk6cH0yo=85rbxTPTYFRg@mail.gmail.com>
 <CAGXu5jLavA8FJD8m-1y4wO0uzh3qvvMmajAg0Lrr1Cn_Om3a3w@mail.gmail.com> <20140627192753.GA30752@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 27 Jun 2014 12:31:16 -0700
Message-ID: <CALCETrVbJqfG6oBaZEjj7H3pPa1oVJx6QXAYc5zZ6o-niV=WKQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] seccomp: split mode set routines
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>, Alexei Starovoitov <ast@plumgrid.com>, Andrew Morton <akpm@linux-foundation.org>, Daniel Borkmann <dborkman@redhat.com>, Will Drewry <wad@chromium.org>, Julien Tinnes <jln@chromium.org>, David Drysdale <drysdale@google.com>, Linux API <linux-api@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org, linux-arch <linux-arch@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>
Message-ID: <20140627193116.Y80TaNNY-FWw7TSEmPSNbVm32Z6UutoCR6khNhK6fVA@z>

On Fri, Jun 27, 2014 at 12:27 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/27, Kees Cook wrote:
>>
>> It looks like SMP ARM issues dsb for rmb, which seems a bit expensive.
>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0204g/CIHJFGFE.htm
>>
>> ...
>>
>> I really want to avoid adding anything to the secure_computing()
>> execution path. :(
>
> I must have missed something but I do not understand your concerns.
>
> __secure_computing() is not trivial, and we are going to execute the
> filters. Do you really think rmb() can add the noticeable difference?
>
> Not to mention that we can only get here if we take the slow syscall
> enter path due to TIF_SECCOMP...
>

On my box, with my fancy multi-phase seccomp patches, the total
seccomp overhead for a very short filter is about 13ns.  Adding a full
barrier would add several ns, I think.

Admittedly, this is x86, not ARM, so comparisons here are completely
bogus.  And that read memory barrier doesn't even need an instruction
on x86.  But still, let's try to keep this fast.

--Andy
