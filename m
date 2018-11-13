Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33270 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeKNJPB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Nov 2018 04:15:01 -0500
Received: by mail-yb1-f196.google.com with SMTP id i78-v6so6168512ybg.0
        for <linux-arch@vger.kernel.org>; Tue, 13 Nov 2018 15:14:32 -0800 (PST)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id 205-v6sm5647326ywd.1.2018.11.13.15.14.31
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 15:14:31 -0800 (PST)
Received: by mail-yw1-f48.google.com with SMTP id t13so2345054ywe.13
        for <linux-arch@vger.kernel.org>; Tue, 13 Nov 2018 15:14:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <df3e029b-51b3-51a0-70f7-3239234373e2@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <CAGXu5jLtxRitee143FE37PYkPCs0UArGgNEsiU8fzsQL9N8S-Q@mail.gmail.com> <df3e029b-51b3-51a0-70f7-3239234373e2@arm.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 13 Nov 2018 17:09:00 -0600
Message-ID: <CAGXu5jJMfCz4qFY8y1Uf7BdP961ZeBotFVUb5owaksxnz26akg@mail.gmail.com>
Subject: Re: [PATCH 00/17] ARMv8.3 pointer authentication support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Adam Wallis <awallis@codeaurora.org>, Amit Kachhap <Amit.Kachhap@arm.com>, Andrew Jones <drjones@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, Dave P Martin <Dave.Martin@arm.com>, Jacob Bramley <jacob.bramley@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>, "Suzuki K . Poulose" <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181113230900.oRq5kmJkkeJuN4z2OLF4kXgUIIga7F9nPmCo3zJUBiw@z>

On Tue, Nov 13, 2018 at 10:17 AM, Kristina Martsenko
<kristina.martsenko@arm.com> wrote:
> When the PAC authentication fails, it doesn't actually generate an
> exception, it just flips a bit in the high-order bits of the pointer,
> making the pointer invalid. Then when the pointer is dereferenced (e.g.
> as a function return address), it generates the usual type of exception
> for an invalid address.

Ah! Okay, thanks. I missed that detail. :)

What area of memory ends up being addressable with such bit flips?
(i.e. is the kernel making sure nothing executable ends up there?)

> So when a function return fails in user mode, the exception is handled
> in __do_user_fault and a forced SIGSEGV is delivered to the task. When a
> function return fails in kernel mode, the exception is handled in
> __do_kernel_fault and the task is killed.
>
> This is different from stack protector as we don't panic the kernel, we
> just kill the task. It would be difficult to panic as we don't have a
> reliable way of knowing that the exception was caused by a PAC
> authentication failure (we just have an invalid pointer with a specific
> bit flipped). We also don't print out any PAC-related warning.

There are other "guesses" in __do_kernel_fault(), I think? Could a
"PAC mismatch?" warning be included in the Oops if execution fails in
the address range that PAC failures would resolve into?

-Kees

-- 
Kees Cook
