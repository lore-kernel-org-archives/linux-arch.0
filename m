Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfBEMNz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Feb 2019 07:13:55 -0500
Subject: Re: [PATCH] KVM: export <linux/kvm_para.h> and <asm/kvm_para.h> for
 all architectures
References: <1549252517-23834-1-git-send-email-yamada.masahiro@socionext.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb57fc25-0288-741b-8fb6-942124c0f6a6@redhat.com>
Date: Tue, 5 Feb 2019 13:13:47 +0100
MIME-Version: 1.0
In-Reply-To: <1549252517-23834-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, =?UTF-8?B?UmFkaW0gS3Lvv73vv73vv71t77+977+977+977+977+977+9?= <rkrcmar@redhat.com>, kvm@vger.kernel.org
Cc: linux-arch <linux-arch@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Christoffer Dall <christoffer.dall@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, Sam Ravnborg <sam@ravnborg.org>

On 04/02/19 04:55, Masahiro Yamada wrote:
> If you prefer [B] (or you have a better idea),
> please suggest.

I prefer [B] but this is already much better so feel free to do it on top.

Paolo
