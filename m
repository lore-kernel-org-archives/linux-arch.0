Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34968 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757590AbdADKjY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2017 05:39:24 -0500
Received: by mail-lf0-f48.google.com with SMTP id b14so301945107lfg.2
        for <linux-arch@vger.kernel.org>; Wed, 04 Jan 2017 02:39:12 -0800 (PST)
Date: Wed, 4 Jan 2017 11:39:11 +0100
From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [PATCH 12/13] KVM: arm: avoid binary number literals for gcc-4.2
Message-ID: <20170104103911.GC20461@cbox>
References: <20161216105634.235457-1-arnd@arndb.de>
 <20161216105634.235457-13-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161216105634.235457-13-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, kernel-build-reports@lists.linaro.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@vger.kernel.org
Message-ID: <20170104103911.0BYK5-_y7ocqpBcexqDasuIbv-9ztoXwHJ42Cvpa8LI@z>

On Fri, Dec 16, 2016 at 11:56:33AM +0100, Arnd Bergmann wrote:
> Old gcc versions prior to 4.3 don't understand the 0b... syntax for
> numbers, and this seems to be the only instance in the kernel, so better
> use hexadecimal instead.
> 
> arch/arm/include/asm/kvm_mmu.h:127:38: error: invalid suffix "b101" on integer constant
> 
> Fixes: 159793001d7d ("ARM: KVM: force cache clean on page fault when caches are off")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Same as before:
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
