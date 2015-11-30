Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60090 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753602AbbK3Vnu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 30 Nov 2015 16:43:50 -0500
Subject: Re: [kernel-hardening] [PATCH 0/2] introduce post-init read-only
 memory
References: <1448401114-24650-1-git-send-email-keescook@chromium.org>
 <CA+rthh-euk2hGGWjsDqXogWSmzmJNV1aiUVfnTfrzyQhndgbOQ@mail.gmail.com>
 <565595F5.32536.DB9FE75@pageexec.freemail.hu>
 <20151126085425.GA29848@gmail.com>
 <CALCETrXrvAY+mXx+JULw7W+xokcSPFgWm5-McJf9EKhYehPhbA@mail.gmail.com>
 <20151127075959.GA24991@gmail.com>
 <CA+55aFxH+Gy4U8WbGWXh+ybrvng8tw1=2CrjPnJSju3+c5XpbA@mail.gmail.com>
 <CAGXu5j+mvknX69Kk1S8u54LR4T+KED8zZdkqQWA9KMrOvtVQtQ@mail.gmail.com>
 <CALCETrVVYMUgxABoEVfJgLtE+nB44aijqG5saq8dTQSTVWxbMA@mail.gmail.com>
 <20151129080505.GA23721@gmail.com> <565CBC37.9090106@zytor.com>
 <CAGXu5jK+5UjQt+YZV_oe286+_5NrsZ7gTyVr-v+R7mF1uHskTg@mail.gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <565CC2F2.4020808@zytor.com>
Date: Mon, 30 Nov 2015 13:43:14 -0800
MIME-Version: 1.0
In-Reply-To: <CAGXu5jK+5UjQt+YZV_oe286+_5NrsZ7gTyVr-v+R7mF1uHskTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Linus Torvalds <torvalds@linux-foundation.org>, PaX Team <pageexec@freemail.hu>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Mathias Krause <minipli@googlemail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch <linux-arch@vger.kernel.org>, Emese Revfy <re.emese@gmail.com>
Message-ID: <20151130214314.itqlV_U2S-0eYhkFK71sFcb1WNmwzNW2FbIuWK5hX2c@z>

On 11/30/15 13:33, Kees Cook wrote:
>>
>> I think what should do is have a debug option which can be set to "rw",
>> "log" or "oops"; the latter should probably be the default.
> 
> Can someone write that patch, and then I will include it in the
> series? I haven't touched fault handler code, and it would be faster
> if someone more familiar with that area did it. :)
> 

The "log" option (the only hard one) can be added as a later
enhancement, and probably should be.  It shouldn't block the series.

	-hpa

