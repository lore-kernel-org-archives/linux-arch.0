Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36260 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeDTKlP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2018 06:41:15 -0400
Date: Fri, 20 Apr 2018 20:41:04 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4/4] powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be
 selected
Message-ID: <20180420204104.6e22b136@roar.ozlabs.ibm.com>
In-Reply-To: <CA+7wUswuyn+YgNe732rQAzVmgDBohTMEqwsd76nQ_CH5h7Y5WA@mail.gmail.com>
References: <20180420073414.23169-1-npiggin@gmail.com>
        <20180420073414.23169-5-npiggin@gmail.com>
        <CA+7wUswuyn+YgNe732rQAzVmgDBohTMEqwsd76nQ_CH5h7Y5WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arch@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, linux-kbuild@vger.kernel.org
Message-ID: <20180420104104.Nftv9aOaXUucO5jHbZYMvPBpa1BWjaD26NG1h0UTjSk@z>

On Fri, 20 Apr 2018 12:00:49 +0200
Mathieu Malaterre <malat@debian.org> wrote:

> On Fri, Apr 20, 2018 at 9:34 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > This requires further changes to linker script to KEEP some tables
> > and wildcard compiler generated sections into the right place. This
> > includes pp32 modifications from Christophe Leroy.
> >
> > When compiling powernv_defconfig with this option:
> >
> > text       data      bss       dec        filename
> > 11827621   4810490   1341080   17979191   vmlinux
> > 11752437   4598858   1338776   17690071   vmlinux.dcde
> >
> > Resulting kernel is almost 400kB smaller (and still boots).
> >
> > [ppc32 numbers here]  
> 
> ^^^
> 
> Do you want somebody else to provide those numbers ?

If you have a booting kernel, yes some more numbers would be good.

Thanks,
Nick
