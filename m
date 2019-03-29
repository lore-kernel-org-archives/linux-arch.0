Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39240 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfC2RZU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Mar 2019 13:25:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id m13so1978744lfb.6
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2019 10:25:19 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id w22sm456453ljd.42.2019.03.29.10.25.14
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 10:25:15 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id t4so2680597ljc.2
        for <linux-arch@vger.kernel.org>; Fri, 29 Mar 2019 10:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230512.486297455@goodmis.org>
In-Reply-To: <20190328230512.486297455@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Mar 2019 10:24:58 -0700
Message-ID: <CAHk-=whtDB2HiEgyKcJPN7m8c83GrY=hQ=p-m-um1N6eSqxczg@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4 v2] sycalls: Remove args i and n from syscall_get_arguments()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20190329172458.YRE-3ZT5G-n6X1tG3fl5oq2mHrb8YNCfBvtXAyLuVZM@z>

The whole series looks fine to me.

I still suspect that we should just remove the syscall_set_arguments()
thing entirely, but even without that, the cleanup of the calling
convention is at least an improvement.

                     Linus
