Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33476 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbbJ2ScJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 Oct 2015 14:32:09 -0400
Received: by obbwb3 with SMTP id wb3so24928965obb.0
        for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2015 11:32:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1446081046.1856.55.camel@kernel.crashing.org>
References: <1445789224-28032-1-git-send-email-shamir.rabinovitch@oracle.com>
 <1445789224-28032-2-git-send-email-shamir.rabinovitch@oracle.com>
 <1446013801.3405.183.camel@infradead.org> <20151028111049.GA30785@shamir-ThinkPad-T430>
 <1446039110.3405.212.camel@infradead.org> <1446078721.1856.49.camel@kernel.crashing.org>
 <1446079332.3405.273.camel@infradead.org> <1446081046.1856.55.camel@kernel.crashing.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 29 Oct 2015 11:31:49 -0700
Message-ID: <CALCETrXrzq1f9sMAbKcmhpEtiyq5FE871=4+YspA=X+RjD7p8Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute - DMA_ATTR_IOMMU_BYPASS
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Shamir Rabinovitch <shamir.rabinovitch@oracle.com>, David Woodhouse <dwmw2@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Jonathan Corbet <corbet@lwn.net>, KVM <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
Message-ID: <20151029183149.W_B70VdbzdbjXtrBr7BeUTClsYw2FMwSLdDlpvy4xEE@z>

On Oct 28, 2015 6:11 PM, "Benjamin Herrenschmidt"
<benh@kernel.crashing.org> wrote:
>
> On Thu, 2015-10-29 at 09:42 +0900, David Woodhouse wrote:
> > On Thu, 2015-10-29 at 09:32 +0900, Benjamin Herrenschmidt wrote:
> >
> > > On Power, I generally have 2 IOMMU windows for a device, one at the
> > > bottom is remapped, and is generally used for 32-bit devices and the
> > > one at the top us setup as a bypass
> >
> > So in the normal case of decent 64-bit devices (and not in a VM),
> > they'll *already* be using the bypass region and have full access to
> > all of memory, all of the time? And you have no protection against
> > driver and firmware bugs causing stray DMA?
>
> Correct, we chose to do that for performance reasons.

Could this be mitigated using pools?  I don't know if the net code
would play along easily.

--Andy
