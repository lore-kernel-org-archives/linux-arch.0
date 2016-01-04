Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:55229 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752912AbcADM0k (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 4 Jan 2016 07:26:40 -0500
Date: Mon, 4 Jan 2016 13:26:20 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 14/16] x86, nvdimm, kexec: Use walk_iomem_res_desc()
 for iomem search
Message-ID: <20160104122619.GH22941@pd.tnic>
References: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
 <1451081365-15190-14-git-send-email-toshi.kani@hpe.com>
 <20151226103804.GB21988@pd.tnic>
 <567F315B.8080005@hpe.com>
 <20151227021257.GA13560@dhcp-128-25.nay.redhat.com>
 <20151227102406.GB19398@nazgul.tnic>
 <20160104092937.GB7033@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160104092937.GB7033@dhcp-128-65.nay.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Young <dyoung@redhat.com>
Cc: Minfei Huang <mhuang@redhat.com>, Toshi Kani <toshi.kani@hpe.com>, linux-arch@vger.kernel.org, linux-nvdimm@ml01.01.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>
Message-ID: <20160104122620.mqCcT2Cmx0sGUfPrp9AJyasYdK__8GwbAAQOUT54mEo@z>

On Mon, Jan 04, 2016 at 05:29:37PM +0800, Dave Young wrote:
> Replied to Toshi old kernel will export the "GART" region for amd cards.
> So for old kernel and new kexec-tools we will have problem.
> 
> I think add the GART desc for compitibility purpose is doable, no?

Just read your other mails too. If I see it correctly, there's only one
place which has "GART":

$ git grep -e \"GART\"
arch/x86/kernel/crash.c:235:    walk_iomem_res("GART", IORESOURCE_MEM, 0, -1,

So crash.c only excludes this region but the kernel doesn't create it.
Right?

So we can kill that walk_iomem_res(), as you say. Which would be even
nicer...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
