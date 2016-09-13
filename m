Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36265 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbcIMDto (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Sep 2016 23:49:44 -0400
Received: by mail-oi0-f48.google.com with SMTP id q188so242002239oia.3
        for <linux-arch@vger.kernel.org>; Mon, 12 Sep 2016 20:49:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160913121645.652e6512@roar.ozlabs.ibm.com>
References: <147361509579.17004.5258725187329709824.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20160912133536.1bdb57a9@roar.ozlabs.ibm.com> <CAPcyv4hS7i1DApKPDB5PkfBNZVbk321FgP94kUDjmuyGXDidZg@mail.gmail.com>
 <20160913121645.652e6512@roar.ozlabs.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 12 Sep 2016 20:49:43 -0700
Message-ID: <CAPcyv4hSs2M3LYscsepYat+FN9e3aUxSY3kGMFD6M9-9BCR5HQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] mm, mincore2(): retrieve dax and tlb-size
 attributes of an address range
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux MM <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, linux-api@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-arch@vger.kernel.org
Message-ID: <20160913034943.Te5JYmw6DWAygMzIOD2EGH8wm207HhzNc9gg2zfRfnU@z>

On Mon, Sep 12, 2016 at 7:16 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Mon, 12 Sep 2016 10:29:17 -0700
[..]
>> Certainly one of the new request flags can indicate that the vector is
>> made up of larger entries.
>
> Hmm. Changing prototype depending on flags. I thought I was having
> a nightmare about ioctls for a minute there :)

Heh :)

> In general, is this what we want for a new API? Should we be thinking
> about an extent API?

This probably fits better with the use cases I know that want to
consume this information, something like fiemap (mextmap, maybe?) for
memory.
