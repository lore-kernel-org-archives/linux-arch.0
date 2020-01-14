Return-Path: <SRS0=Pd00=3D=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34257 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANVtX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 16:49:23 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so11051133lfc.1
        for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2020 13:49:22 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id s4sm8248225ljd.94.2020.01.14.13.49.19
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 13:49:19 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id l18so11051046lfc.1
        for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2020 13:49:19 -0800 (PST)
MIME-Version: 1.0
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-5-vgupta@synopsys.com>
 <CAK8P3a2GUqmcA_q33=20OrK1+cU4f3mCrgci_bO3ho4B5PRODg@mail.gmail.com> <3734021d-1756-3a09-6595-14ca58c64bf9@synopsys.com>
In-Reply-To: <3734021d-1756-3a09-6595-14ca58c64bf9@synopsys.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 Jan 2020 13:49:03 -0800
Message-ID: <CAHk-=wjX-c9YpPhbQ073UPnTvELNQCN49vqK1yY7JGuHSn5-ew@mail.gmail.com>
Subject: Re: [RFC 4/4] ARC: uaccess: use optimized generic __strnlen_user/__strncpy_from_user
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Khalid Aziz <khalid.aziz@oracle.com>, Andrey Konovalov <andreyknvl@google.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian.brauner@ubuntu.com>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20200114214903.6SGarHJEUVX_5h96ABxUELTke3eFBaaXZusUgwsFP-Y@z>

On Tue, Jan 14, 2020 at 1:37 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> On 1/14/20 12:42 PM, Arnd Bergmann wrote:
> >
> > What's wrong with the generic version on little-endian? Any
> > chance you can find a way to make it work as well for you as
> > this copy?
>
> find_zero() by default doesn't use pop count instructions.

Don't you think the generic find_zero() is likely just as fast as the
pop count instruction? On 32-bit, I think it's like a shift and a mask
and a couple of additions.

The 64-bit case has a multiply that is likely expensive unless you
have a good multiplication unit (but what 64-bit architecture
doesn't?), but the generic 32-bit LE code should already be pretty
close to optimal, and it might not be worth it to worry about it.

(The big-endian case is very different, and architectures really can
do much better. But LE allows for bit tricks using the carry chain)

             Linus
