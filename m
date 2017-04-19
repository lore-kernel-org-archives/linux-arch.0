From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 00/27] PCI resource mmap cleanup
Date: Wed, 19 Apr 2017 13:37:53 -0500
Message-ID: <CAErSpo4XzcDjd8pK_kFGgyiaCv8t1xyHMNcm2MQV3gAxKrFDfA@mail.gmail.com>
References: <cover.1491999859.git.dwmw2@infradead.org> <20170418182816.GB25295@bhelgaas-glaptop.roam.corp.google.com>
 <1492586617.17682.240.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35819 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968950AbdDSSiP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Apr 2017 14:38:15 -0400
Received: by mail-wr0-f177.google.com with SMTP id o21so21318790wrb.2
        for <linux-arch@vger.kernel.org>; Wed, 19 Apr 2017 11:38:15 -0700 (PDT)
In-Reply-To: <1492586617.17682.240.camel@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Apr 19, 2017 at 2:23 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 2017-04-18 at 13:28 -0500, Bjorn Helgaas wrote:
>>
>> Applied to pci/resource-mmap for v4.12, thanks!
>>
>> This consists of the email patches + the acks/etc so far.  It doesn't
>> include any updates from your git branch (but it doesn't look like it's
>> been updated recently).
>
> Thanks. Aside from merging the acks, I had also fixed a typo in
> include/linux/pci.h (s/aroudn/around) and re-ordered the later commits
> to put the three IA64 changes immediately after the ones you already
> merged. Tony said it was OK to take those through your tree too.
>
> I've taken your pci/resource-mmap branch, edited it to apply the typo
> fix, and added the three IA64 commits at
>
>  git://git.infradead.org/users/dwmw2/random-2.6.git for-bjorn
> http://git.infradead.org/users/dwmw2/random-2.6.git/shortlog/refs/heads/for-bjorn

I pulled this branch; it's on my pci/resource-mmap branch for v4.12.
