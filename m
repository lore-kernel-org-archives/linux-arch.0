Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40850 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeKOIx2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Nov 2018 03:53:28 -0500
Received: by mail-yw1-f66.google.com with SMTP id l66-v6so7956721ywl.7
        for <linux-arch@vger.kernel.org>; Wed, 14 Nov 2018 14:48:16 -0800 (PST)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id q2-v6sm11900911ywa.24.2018.11.14.14.48.13
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:48:13 -0800 (PST)
Received: by mail-yw1-f41.google.com with SMTP id k6-v6so7925217ywa.11
        for <linux-arch@vger.kernel.org>; Wed, 14 Nov 2018 14:48:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181114214701.gdnrznakwtm76jlt@blommer>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <CAGXu5jLtxRitee143FE37PYkPCs0UArGgNEsiU8fzsQL9N8S-Q@mail.gmail.com>
 <df3e029b-51b3-51a0-70f7-3239234373e2@arm.com> <CAGXu5jJMfCz4qFY8y1Uf7BdP961ZeBotFVUb5owaksxnz26akg@mail.gmail.com>
 <20181114214701.gdnrznakwtm76jlt@blommer>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 14 Nov 2018 16:48:11 -0600
Message-ID: <CAGXu5jJun3CuUa12aQpy+m7Op-g9XwPv3CygwqYX2dy0A4qt5Q@mail.gmail.com>
Subject: Re: [PATCH 00/17] ARMv8.3 pointer authentication support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Adam Wallis <awallis@codeaurora.org>, Amit Kachhap <Amit.Kachhap@arm.com>, Andrew Jones <drjones@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, Dave P Martin <Dave.Martin@arm.com>, Jacob Bramley <jacob.bramley@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>, "Suzuki K . Poulose" <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181114224811.Uo_mx6xI9FdWjoiOEa71_XRCFvFRiaqtUjhAbPvrWrM@z>

On Wed, Nov 14, 2018 at 3:47 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Nov 13, 2018 at 05:09:00PM -0600, Kees Cook wrote:
>> On Tue, Nov 13, 2018 at 10:17 AM, Kristina Martsenko
>> <kristina.martsenko@arm.com> wrote:
>> > When the PAC authentication fails, it doesn't actually generate an
>> > exception, it just flips a bit in the high-order bits of the pointer,
>> > making the pointer invalid. Then when the pointer is dereferenced (e.g.
>> > as a function return address), it generates the usual type of exception
>> > for an invalid address.
>>
>> Ah! Okay, thanks. I missed that detail. :)
>>
>> What area of memory ends up being addressable with such bit flips?
>> (i.e. is the kernel making sure nothing executable ends up there?)
>>
>> > So when a function return fails in user mode, the exception is handled
>> > in __do_user_fault and a forced SIGSEGV is delivered to the task. When a
>> > function return fails in kernel mode, the exception is handled in
>> > __do_kernel_fault and the task is killed.
>> >
>> > This is different from stack protector as we don't panic the kernel, we
>> > just kill the task. It would be difficult to panic as we don't have a
>> > reliable way of knowing that the exception was caused by a PAC
>> > authentication failure (we just have an invalid pointer with a specific
>> > bit flipped). We also don't print out any PAC-related warning.
>>
>> There are other "guesses" in __do_kernel_fault(), I think? Could a
>> "PAC mismatch?" warning be included in the Oops if execution fails in
>> the address range that PAC failures would resolve into?
>
> I'd personally prefer that we didn't try to guess if a fault is due to a failed
> AUT*, even for logging.
>
> Presently, it's not possible to distinguish between a fault resulting from a
> failed AUT* and a fault which happens to have hte same bits/clear, so there are
> false positives. The architecture may also change the precise details of the
> faulting address, and we'd have false negatives in that case.
>
> Given that, I think suggesting that a fault is due to a failed AUT* is liable
> to make things more confusing.

Okay, no worries. It should be pretty clear from the back trace anyway. :)

As long as there isn't any way for the pointer bit flips to result in
an addressable range, I'm happy. :)

-Kees

-- 
Kees Cook
