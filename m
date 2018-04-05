Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45573 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbeDEL6O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Apr 2018 07:58:14 -0400
MIME-Version: 1.0
In-Reply-To: <e2290e35d919d46a6d45b0e47abb866e@codeaurora.org>
References: <1522886301-25955-1-git-send-email-okaya@codeaurora.org>
 <CAK8P3a0Noun+8AaRUcMdOX09KXxFXZxfcyUgJnezPkS2gVkg6w@mail.gmail.com> <e2290e35d919d46a6d45b0e47abb866e@codeaurora.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Apr 2018 13:58:12 +0200
Message-ID: <CAK8P3a2ovkToy5Yv=15_tyM8GUoZfSJ2QdhGev=fNSRCAj9bCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] io: define several IO & PIO barrier types for the
 asm-generic version
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Timur Tabi <timur@codeaurora.org>, sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180405115812.zLRpJsrI9ue1fxXz1gKZ2TrMsy6Lu9AIw7-aj5LcPCw@z>

On Thu, Apr 5, 2018 at 1:48 PM,  <okaya@codeaurora.org> wrote:
> On 2018-04-05 03:00, Arnd Bergmann wrote:

>> The other four patches look perfect already.  What's the timing we need
>> for
>> these patches? Are they 4.18 material, or do we need them in 4.17 and
>> stable kernels to work around known bugs?
>
>
> I was hoping to get all arch stuff in for 4.17.
>
> Driver developers started removing redundant wmb().

Ok, so 4.17 but no stable backports then.

     Arnd
