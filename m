Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:42474 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbbL0KYa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 27 Dec 2015 05:24:30 -0500
Date: Sun, 27 Dec 2015 11:24:06 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 14/16] x86, nvdimm, kexec: Use walk_iomem_res_desc()
 for iomem search
Message-ID: <20151227102406.GB19398@nazgul.tnic>
References: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
 <1451081365-15190-14-git-send-email-toshi.kani@hpe.com>
 <20151226103804.GB21988@pd.tnic>
 <567F315B.8080005@hpe.com>
 <20151227021257.GA13560@dhcp-128-25.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20151227021257.GA13560@dhcp-128-25.nay.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Minfei Huang <mhuang@redhat.com>, Toshi Kani <toshi.kani@hpe.com>
Cc: linux-arch@vger.kernel.org, linux-nvdimm@ml01.01.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>
Message-ID: <20151227102406.Diq4GfB84WBPamTA4-OgBm7xEht0Ildd_WfITXg_X8Y@z>

On Sun, Dec 27, 2015 at 10:12:57AM +0800, Minfei Huang wrote:
> You can refer the below link that you may get a clue about GART. This is
> the fisrt time kexec-tools tried to support to ignore GART region in 2nd
> kernel.
> 
> http://lists.infradead.org/pipermail/kexec/2008-December/003096.html

So theoretically we could export that IORES_DESC* enum in an uapi header and
move kexec-tools to use that.

However, I'm fuzzy on how exactly the whole compatibility thing is done
with kexec-tools and the kernel. We probably would have to support
newer kexec-tools on an older kernel and vice versa so I'd guess we
should mark walk_iomem_res() deprecated so that people are encouraged to
upgrade to newer kexec-tools...


Hmmm.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
