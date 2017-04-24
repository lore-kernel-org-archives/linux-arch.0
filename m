Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36990 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162318AbdDXWCE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Apr 2017 18:02:04 -0400
Received: by mail-wm0-f41.google.com with SMTP id m123so80307027wma.0
        for <linux-arch@vger.kernel.org>; Mon, 24 Apr 2017 15:02:04 -0700 (PDT)
Date: Tue, 25 Apr 2017 01:01:58 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: Question on the five-level page table support patches
Message-ID: <20170424220158.z67cir7sjfyn4wdt@node.shutemov.name>
References: <030ea57b-5f6c-13d8-02f7-b245a754a87d@physik.fu-berlin.de>
 <20170424161959.c5ba2nhnxyy57wxe@node.shutemov.name>
 <fdc80e3c-6909-cf39-fe0b-6f1c012571e4@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdc80e3c-6909-cf39-fe0b-6f1c012571e4@physik.fu-berlin.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20170424220158.hz4hCB4KhI8RBdJjisMXDCIA8iXjZielD31Sn04-jsg@z>

On Mon, Apr 24, 2017 at 10:37:40PM +0200, John Paul Adrian Glaubitz wrote:
> On 04/24/2017 06:19 PM, Kirill A. Shutemov wrote:
> > In proposed implementation, we also use hint address, but in different
> > way: by default, if hint address is NULL, kernel would not create mappings
> > above 47-bits, preserving compatibility.
> 
> Ooooh, that would solve a lot of problems actually if it were to be available
> on all architectures. On SPARC, the situation is really annoying and I have
> been discussing a solution with the Qt developers and they suggested a
> similar approach, just one that would also apply to brk() [1].
> 
> > If an application wants to have access to larger address space, it has to
> > specify hint addess above 47-bits.
> > 
> > See details here:
> > 
> > http://lkml.kernel.org/r/20170420162147.86517-10-kirill.shutemov@linux.intel.com
> 
> Thanks. I'll have a read. Although from your message I'm reading out that
> this particular proposal got rejected.

No. I just wasn't applied yet, so situation may change.

> Would be really nice to able to have a canonical solution for this issue,
> it's been biting us on SPARC for quite a while now due to the fact that
> virtual address space has been 52 bits on SPARC for a while now.

Power folks are going to implement similar approach. I don't see why Sparc
can't go the same route.

-- 
 Kirill A. Shutemov
