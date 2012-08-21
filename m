Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57799 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab2HUUOI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Aug 2012 16:14:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 17/31] arm64: System calls handling
Date: Tue, 21 Aug 2012 20:14:01 +0000
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <201208151422.16335.arnd@arndb.de> <20120821175122.GI12708@arm.com>
In-Reply-To: <20120821175122.GI12708@arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201208212014.01837.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>
Message-ID: <20120821201401.o9zhDoEZq_NQkL3qMdIThWWBrYN3LiacKAsuG3Q9zzI@z>

On Tuesday 21 August 2012, Catalin Marinas wrote:
> > > +asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
> > > +                    unsigned long prot, unsigned long flags,
> > > +                    unsigned long fd, off_t off)
> > > +{
> > > +   if (offset_in_page(off) != 0)
> > > +           return -EINVAL;
> > > +
> > > +   return sys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
> > > +}
> > 
> > I think
> > 
> > #define sys_mmap sys_mmap_pgoff 
> 
> There are slightly different semantics with the last argument of
> sys_mmap() which takes a byte offset. The sys_mmap_pgoff() function
> takes the offset shifted by PAGE_SHIFT (which is the same as sys_mmap2).
> 
> Looking at the other architectures, it makes sense to use a generic
> sys_mmap() implementation similar to the one above (or the ia-64, seems
> to be the most complete).
> 

Why that? The generic sys_mmap_pgoff was specifically added so new architectures
could just use that instead of having their own wrappers, see f8b72560.

	Arnd
