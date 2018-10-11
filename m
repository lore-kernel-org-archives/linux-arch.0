Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36048 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJKWgy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Oct 2018 18:36:54 -0400
MIME-Version: 1.0
In-Reply-To: <20181011150654.GB22118@asgard.redhat.com>
References: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org>
 <1539231895-4118-8-git-send-email-firoz.khan@linaro.org> <CAK8P3a3OS-aKFrb5g1i00-+G1+uZqEkH0C1FX08tTx=-89-hfQ@mail.gmail.com>
 <20181011150654.GB22118@asgard.redhat.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 11 Oct 2018 17:09:02 +0200
Message-ID: <CAK8P3a2EOb+_aOSUqPuFpMoZYSuZv0v89XB-pWf5C7X3rnfOrg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] ia64: wire up system calls
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Firoz Khan <firoz.khan@linaro.org>, linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181011150902.E9pb7E-LeWnwLEKzCZ0MCxLy-fayxmKxvAb6bEwejos@z>

On 10/11/18, Eugene Syromiatnikov <esyr@redhat.com> wrote:
> On Thu, Oct 11, 2018 at 09:24:43AM +0200, Arnd Bergmann wrote:
>> On Thu, Oct 11, 2018 at 6:26 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
>> > +# pkey_mprotect requires an architecture specific implementation
>> > +328    common  pkey_mprotect                   sys_pkey_mprotect
>> > +# pkey_alloc requires an architecture specific implementation
>> > +329    common  pkey_alloc                      sys_pkey_alloc
>> > +# pkey_free requires an architecture specific implementation
>> > +330    common  pkey_free                       sys_pkey_free
>>
>> One comment for all pkey calls would be sufficient. More importantly
>> it requires hardware support that ia64 does not have AFAICT.
>
> Except it has[1].
>

Ok, then we should definitely assign the system call numbers.

      Arnd
