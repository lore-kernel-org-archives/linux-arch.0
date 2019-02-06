Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-05.nifty.com ([210.131.2.90]:35795 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfBFFVy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Feb 2019 00:21:54 -0500
MIME-Version: 1.0
References: <1549252517-23834-1-git-send-email-yamada.masahiro@socionext.com> <fb57fc25-0288-741b-8fb6-942124c0f6a6@redhat.com>
In-Reply-To: <fb57fc25-0288-741b-8fb6-942124c0f6a6@redhat.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 6 Feb 2019 14:21:10 +0900
Message-ID: <CAK7LNARk3Ww8ty=BvYo=xeVwHEL8qPRxfeY_=sQxQqL9-KUnWA@mail.gmail.com>
Subject: Re: [PATCH] KVM: export <linux/kvm_para.h> and <asm/kvm_para.h> for
 all architectures
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?B?UmFkaW0gS3Lvv73vv73vv71t77+977+977+977+977+977+9?= <rkrcmar@redhat.com>, kvm@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Christoffer Dall <christoffer.dall@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, Sam Ravnborg <sam@ravnborg.org>

On Tue, Feb 5, 2019 at 9:13 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 04/02/19 04:55, Masahiro Yamada wrote:
> > If you prefer [B] (or you have a better idea),
> > please suggest.
>
> I prefer [B] but this is already much better so feel free to do it on top.
>
> Paolo


There is no point to move <asm/kvm_para.h> back and forth
between the kernel/user spaces.

We should choose [A] or [B].


Although [B] is not so clean in the code-diff PoV,
I will send it so that you can choose either one you prefer.


-- 
Best Regards
Masahiro Yamada
