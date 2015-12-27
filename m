From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH v2 14/16] x86, nvdimm, kexec: Use walk_iomem_res_desc()
 for iomem search
Date: Sun, 27 Dec 2015 10:12:57 +0800
Message-ID: <20151227021257.GA13560@dhcp-128-25.nay.redhat.com>
References: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
 <1451081365-15190-14-git-send-email-toshi.kani@hpe.com>
 <20151226103804.GB21988@pd.tnic>
 <567F315B.8080005@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54828 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753387AbbL0CK3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 26 Dec 2015 21:10:29 -0500
Content-Disposition: inline
In-Reply-To: <567F315B.8080005@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-arch@vger.kernel.org, linux-nvdimm@ml01.01.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On 12/26/15 at 05:31pm, Toshi Kani wrote:
> + cc: kexec list
> 
> On 12/26/2015 3:38 AM, Borislav Petkov wrote:
> >On Fri, Dec 25, 2015 at 03:09:23PM -0700, Toshi Kani wrote:
> >>Change to call walk_iomem_res_desc() for searching resource entries
> >>with the following names:
> >>  "ACPI Tables"
> >>  "ACPI Non-volatile Storage"
> >>  "Persistent Memory (legacy)"
> >>  "Crash kernel"
> >>
> >>Note, the caller of walk_iomem_res() with "GART" is left unchanged
> >>because this entry may be initialized by out-of-tree drivers, which
> >>do not have 'desc' set to IORES_DESC_GART.
> >
> >There's this out-of-tree bogus argument again. :\
> >
> >Why do we care about out-of-tree drivers?
> >
> >You can just as well fix the "GART" case too and kill walk_iomem_res()
> >altogether...
> 
> Right, but I do not see any "GART" case in the upstream code, so I
> cannot change it...

Hi, Toshi.

You can refer the below link that you may get a clue about GART. This is
the fisrt time kexec-tools tried to support to ignore GART region in 2nd
kernel.

http://lists.infradead.org/pipermail/kexec/2008-December/003096.html

Thanks
Minfei
