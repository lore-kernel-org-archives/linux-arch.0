From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 1/1] KVM: add kvm_para_available to asm-generic/kvm_para.h
Date: Tue, 4 Jun 2013 12:33:19 +0100
Message-ID: <CAAG0J98B=TiJXkrK2dF8DaWQjoHwkk+k7CXiN1XJ5VHQFkowFA@mail.gmail.com>
References: <1369222162-4857-1-git-send-email-james.hogan@imgtec.com>
	<20130604090508.GL4725@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:51259 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888Ab3FDLdU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jun 2013 07:33:20 -0400
Received: by mail-bk0-f47.google.com with SMTP id jg9so63706bkc.6
        for <linux-arch@vger.kernel.org>; Tue, 04 Jun 2013 04:33:19 -0700 (PDT)
In-Reply-To: <20130604090508.GL4725@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>
Cc: kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>, Arnd Bergmann <arnd@arndb.de>

On 4 June 2013 10:05, Gleb Natapov <gleb@redhat.com> wrote:
> On Wed, May 22, 2013 at 12:29:22PM +0100, James Hogan wrote:
>> According to include/uapi/linux/kvm_para.h architectures should define
>> kvm_para_available, so add an implementation to asm-generic/kvm_para.h
>> which just returns false.
>>
> What is this fixing? The only user of kvm_para_available() that can
> benefit from this is in sound/pci/intel8x0.c, but I do not see follow up
> patch to use it there.

It was an unintentional config with mips + kvm + intel8x0 that hit it
(I think I accidentally based my mips config off an x86_64 config).
Kind of equivalent to a randconfig build failure I suppose.

Cheers
James
