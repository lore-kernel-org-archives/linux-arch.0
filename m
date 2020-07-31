From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Fri, 31 Jul 2020 14:48:37 -0300
Message-ID: <20200731174837.GH24045@ziepe.ca>
References: <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
 <20200731152736.GP23808@casper.infradead.org>
 <9ba26063-0098-e796-9431-8c1d0c076ffc@oracle.com>
 <20200731165649.GG24045@ziepe.ca>
 <71ddd3c1-bb59-3e63-e137-99b88ace454d@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387529AbgGaRsj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 13:48:39 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60027C06174A
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 10:48:39 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j187so29497773qke.11
        for <linux-arch@vger.kernel.org>; Fri, 31 Jul 2020 10:48:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <71ddd3c1-bb59-3e63-e137-99b88ace454d@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com

On Fri, Jul 31, 2020 at 01:15:34PM -0400, Steven Sistare wrote:
> On 7/31/2020 12:56 PM, Jason Gunthorpe wrote:
> > On Fri, Jul 31, 2020 at 12:11:52PM -0400, Steven Sistare wrote:
> >>> Your preservation-across-exec use-case might or might not need the
> >>> VMA to be mapped at the same address.  
> >>
> >> It does.  qemu registers memory with vfio which remembers the va's in kernel
> >> metadata for the device.
> > 
> > Once the memory is registered with vfio the VA doesn't matter, vfio
> > will keep the iommu pointing at the same physical pages no matter
> > where they are mapped.
> 
> Yes, but there are other code paths that compute and use offsets between va and the
> base va.  Mapping at a different va in the new process breaks vfio; I have tried it.

Maybe you could fix vfio instead of having this adventure, if vfio is
the only motivation.

Jason
