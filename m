Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33418 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755888AbdGKPFR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2017 11:05:17 -0400
Received: by mail-vk0-f52.google.com with SMTP id r126so1560158vkg.0
        for <linux-arch@vger.kernel.org>; Tue, 11 Jul 2017 08:05:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499782590-31366-1-git-send-email-mark.rutland@arm.com>
References: <1499782590-31366-1-git-send-email-mark.rutland@arm.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 11 Jul 2017 08:04:50 -0700
Message-ID: <CALCETrX_T5=9Y77Z7VrM+YcpoFiJkhUGFNTOh2KbuG+7cey-bw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fatal signal handing within uaccess faults
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kerne@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>, Laura Abbott <labbott@redhat.com>, Russell King <linux@armlinux.org.uk>, stable <stable@vger.kernel.org>, steve.capper@arm.com, Will Deacon <will.deacon@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20170711150450.BoXeb96COIHq6Px5rwsyjTJaqob88QRb2ER3DCSTUJc@z>

On Tue, Jul 11, 2017 at 7:16 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> Arch maintainer tl;dr: most arch fault code doesn't handle fatal signals
> correctly, allowing unprivileged users to create an unkillable task which can
> lock up the system. Please check whether your arch is affected.

I haven't tested for real, but brief inspection of the code suggests
that x86 is okay.

--Andy
