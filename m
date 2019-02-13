Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728231AbfBMVla (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Feb 2019 16:41:30 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1DLchlO019127
        for <linux-arch@vger.kernel.org>; Wed, 13 Feb 2019 16:41:29 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qmt752uxg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 13 Feb 2019 16:41:28 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 13 Feb 2019 21:41:22 -0000
Date: Wed, 13 Feb 2019 23:41:15 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 7/8] initramfs: proide a generic free_initrd_mem
 implementation
References: <20190213174621.29297-1-hch@lst.de>
 <20190213174621.29297-8-hch@lst.de>
 <20190213184139.GC15270@rapoport-lnx>
 <20190213184448.GB20399@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213184448.GB20399@lst.de>
Message-ID: <20190213214114.GE15270@rapoport-lnx>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190213214115.aU4DQLuBtI6MQ0ygelA2zSFjHlMuGidVAbwcrMm-Txc@z>

On Wed, Feb 13, 2019 at 07:44:48PM +0100, Christoph Hellwig wrote:
> On Wed, Feb 13, 2019 at 08:41:40PM +0200, Mike Rapoport wrote:
> > csky seems to open-code free_reserved_page with the only
> > difference that it's also increments totalram_pages for the freed pages,
> > which doesn't seem correct anyway...
> > 
> > That said, I suppose arch/csky can be also added to the party.
> 
> Yes, I noticed that.  But I'd rather move it over manually in
> another patch post rc1 or for the next merge window.

Fair enough.
 
> > > +void __weak free_initrd_mem(unsigned long start, unsigned long end)
> > > +{
> > > +	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> > 
> > Some architectures have pr_info("Freeing initrd memory..."), I'd add it for
> > the generic version as well.
> 
> Well, if we think such a printk is useful it should probably be
> moved to the caller in init/initramfs.c instead.  I can include a
> patch for that in the next iteration of the series.

I found it useful during board bring ups, this gave some starting point
when everything hangs and you are out to catch the lion in the desert.

> > Another thing that I was thinking of is that x86 has all those memory
> > protection calls in its free_initrd_mem, maybe it'd make sense to have them
> > in the generic version as well?
> 
> Maybe.  But I'd rather keep it out of the initial series as it looks
> a little more complicated.  Having a single implementation
> of free_initrd_mem would be great, though.

Ok.

BTW, the memblock_free() arm64 does, seems to be relevant for architectures
with CONFIG_ARCH_DISCARD_MEMBLOCK=n.
On powerpc the freed initrd region shows up in
/sys/kernel/debug/memblock/reserved.

-- 
Sincerely yours,
Mike.
