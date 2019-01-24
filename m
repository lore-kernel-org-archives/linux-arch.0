Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbfAXCc0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Jan 2019 21:32:26 -0500
Date: Thu, 24 Jan 2019 10:31:57 +0800
From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] riscv: fixup max_low_pfn with PFN_DOWN.
Message-ID: <20190124023157.GA22934@guoren-Inspiron-7460>
References: <20190116010738.GA4817@guoren-Inspiron-7460>
 <mhng-7c486840-63d3-4645-84ff-8c89660fc552@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-7c486840-63d3-4645-84ff-8c89660fc552@palmer-si-x1c4>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, ren_guo@c-sky.com, mao_han@c-sky.com
Message-ID: <20190124023157.hf-SZ1ZED4H_AHAmsmoJxaf37-e848MBnlv5xVqhtNc@z>

On Wed, Jan 23, 2019 at 06:00:35PM -0800, Palmer Dabbelt wrote:
> On Tue, 15 Jan 2019 17:07:38 PST (-0800), guoren@kernel.org wrote:
> >Hi Christoph,
> >
> >I use PFN_DOWN() every where as possible and seems it's a habit
> >problem. So let risc-v maintainer to choose "PFN_DOW()" or
> >">> PAGE_SHIFT".
> >
> >Also the same with "end_of_DRAM & max_low_pfn".
> 
> PFN_DOWN makes sense to me, as that's what we're trying to do here (round a
> physical address down to page frame number).  Am a I misunderstanding
> something?
>
No, you got it :)

Best Regards
 Guo Ren
