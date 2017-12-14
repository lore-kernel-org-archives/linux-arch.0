Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:41065 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753848AbdLNScX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Dec 2017 13:32:23 -0500
Received: by mail-pg0-f43.google.com with SMTP id o2so3960583pgc.8
        for <linux-arch@vger.kernel.org>; Thu, 14 Dec 2017 10:32:23 -0800 (PST)
Date: Thu, 14 Dec 2017 10:32:22 -0800 (PST)
Subject: Re: Adding init_task consolidation patches to linux-next
In-Reply-To: <18931.1513275676@warthog.procyon.org.uk>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-2979f9fd-a2ce-4e9c-902c-5f4afb2fb8bb@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, dhowells@redhat.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Message-ID: <20171214183222.q4AVnPL5gfBZcabsKMLikNRzupWCIaMmdinFmHZsXTc@z>

On Thu, 14 Dec 2017 10:21:16 PST (-0800), dhowells@redhat.com wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
>> I'd be much happier if these patches had any Reviewd-by or Tested-by tags ...
>
> They've now got:
>
> 	Tested-by: Tony Luck <tony.luck@intel.com>
> 	Tested-by: Will Deacon <will.deacon@arm.com> (arm64)
>
> attached.  I've also added riscv support.

Thanks!  It works for me.
