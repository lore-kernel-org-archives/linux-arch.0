Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f46.google.com ([209.85.128.46]:35474 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfEIIbR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 May 2019 04:31:17 -0400
Date: Thu, 9 May 2019 10:31:11 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] [v2] x86/mpx: fix recursive munmap() corruption
Message-ID: <20190509083111.GA75918@gmail.com>
References: <20190419194747.5E1AD6DC@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419194747.5E1AD6DC@viggo.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, rguenther@suse.de, hjl.tools@gmail.com, yang.shi@linux.alibaba.com, mhocko@suse.com, vbabka@suse.cz, luto@amacapital.net, x86@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linux-arch@vger.kernel.org, gxt@pku.edu.cn, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Message-ID: <20190509083111.ll3U2i2YJMqSwFYb65DI8QR5Pd05xihDP9efoCC18S4@z>


* Dave Hansen <dave.hansen@linux.intel.com> wrote:

> Reported-by: Richard Biener <rguenther@suse.de>
> Reported-by: H.J. Lu <hjl.tools@gmail.com>
> Fixes: dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in munmap")
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: x86@kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: stable@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-um@lists.infradead.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linux-arch@vger.kernel.org
> Cc: Guan Xuetao <gxt@pku.edu.cn>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>

I've also added your:

  Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>

Because I suppose you intended to sign off on it?

Thanks,

	Ingo
