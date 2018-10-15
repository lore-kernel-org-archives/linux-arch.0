Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34967 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeJPGg4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Oct 2018 02:36:56 -0400
Received: by mail-yw1-f65.google.com with SMTP id y76-v6so8185130ywd.2
        for <linux-arch@vger.kernel.org>; Mon, 15 Oct 2018 15:49:38 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id q126-v6sm2909394ywf.7.2018.10.15.15.49.37
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 15:49:37 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id x5-v6so8139739ybl.11
        for <linux-arch@vger.kernel.org>; Mon, 15 Oct 2018 15:49:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181005084754.20950-1-kristina.martsenko@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 15 Oct 2018 15:42:31 -0700
Message-ID: <CAGXu5jLtxRitee143FE37PYkPCs0UArGgNEsiU8fzsQL9N8S-Q@mail.gmail.com>
Subject: Re: [PATCH 00/17] ARMv8.3 pointer authentication support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Adam Wallis <awallis@codeaurora.org>, Amit Kachhap <Amit.Kachhap@arm.com>, Andrew Jones <drjones@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, Dave P Martin <Dave.Martin@arm.com>, Jacob Bramley <jacob.bramley@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>, "Suzuki K . Poulose" <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20181015224231.Sqy5IgwCYnND5d0WFsfw5-DbaTPjmR5WgJKysbmiB6U@z>

On Fri, Oct 5, 2018 at 1:47 AM, Kristina Martsenko
<kristina.martsenko@arm.com> wrote:
> This series adds support for the ARMv8.3 pointer authentication
> extension. The series contains Mark's original patches to enable pointer
> authentication for userspace [1], followed by early RFC patches using
> pointer authentication in the kernel.

It wasn't obvious to me where the PAC mismatch exceptions will be
caught. I'm mainly curious to compare the PAC exception handling to
the existing stack-protector panic(). Can you point me to which
routines manage that? (Perhaps I just missed it in the series...)

Thanks for the series! I'm quite excited for ARMv8.3 hardware. :)

-Kees

-- 
Kees Cook
Pixel Security
