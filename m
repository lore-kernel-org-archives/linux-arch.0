Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42217 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934542AbcLTJ7f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Dec 2016 04:59:35 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBK9xZ9T062397
        for <linux-arch@vger.kernel.org>; Tue, 20 Dec 2016 04:59:35 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 27ewc78p52-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 20 Dec 2016 04:59:34 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 20 Dec 2016 09:59:27 -0000
Date: Tue, 20 Dec 2016 10:59:20 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFC] minimum gcc version for kernel: raise to gcc-4.3 or 4.6?
References: <20161216105634.235457-1-arnd@arndb.de>
 <20161216170043.taaanbg5objnxjlh@breakpoint.cc>
 <2778134.jZdhGefl4B@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2778134.jZdhGefl4B@wuerfel>
Message-ID: <20161220095920.GD4893@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, kernel-build-reports@lists.linaro.org, kvmarm@lists.cs.columbia.edu, Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20161220095920.HtozE6c0tJHW_qN3HyaQVbA4M4oCm-E2eqakYFMsU5k@z>

On Fri, Dec 16, 2016 at 11:00:27PM +0100, Arnd Bergmann wrote:
> On Friday, December 16, 2016 6:00:43 PM CET Sebastian Andrzej Siewior wrote:
> > On 2016-12-16 11:56:21 [+0100], Arnd Bergmann wrote:
> > > The original gcc-4.3 release was in early 2008. If we decide to still
> > > support that, we probably want the first 10 quirks in this series,
> > > while gcc-4.6 (released in 2011) requires none of them.
> > 
> > It this min gcc thingy ARM only?
> 
> This is part of the question that I'm trying to figure out myself.
> 
> Clearly having the same minimum version across all architectures simplifies
> things a lot, because many of the bugs in old versions are architecture
> independent. Then again, some architectures implicitly require a new version
> because an old one never existed (e.g. arm64 or risc-v), while some other
> architectures may require an old version.

FWIW, s390 requires gcc 4.3 or newer since two years already. For older
compilers we enforce a compile error (see arch/s390/kernel/asm-offsets.c).

