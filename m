From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 14/16] x86, nvdimm, kexec: Use walk_iomem_res_desc()
 for iomem search
Date: Mon, 04 Jan 2016 12:45:49 -0700
Message-ID: <1451936749.19330.22.camel@hpe.com>
References: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
	 <1451081365-15190-14-git-send-email-toshi.kani@hpe.com>
	 <20151226103804.GB21988@pd.tnic> <567F315B.8080005@hpe.com>
	 <20151227021257.GA13560@dhcp-128-25.nay.redhat.com>
	 <20151227102406.GB19398@nazgul.tnic>
	 <20160104092937.GB7033@dhcp-128-65.nay.redhat.com>
	 <20160104122619.GH22941@pd.tnic> <1451930260.19330.21.camel@hpe.com>
	 <20160104194059.GM22941@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g1t5424.austin.hp.com ([15.216.225.54]:35506 "EHLO
	g1t5424.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbcADTqY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jan 2016 14:46:24 -0500
In-Reply-To: <20160104194059.GM22941@pd.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>, Minfei Huang <mhuang@redhat.com>, linux-arch@vger.kernel.org, linux-nvdimm@ml01.01.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>

On Mon, 2016-01-04 at 20:41 +0100, Borislav Petkov wrote:
> On Mon, Jan 04, 2016 at 10:57:40AM -0700, Toshi Kani wrote:
> > With this change, there will be no caller to walk_iomem_res().  Should 
> > we remove walk_iomem_res() altogether, or keep it for now as a 
> > deprecated func with the checkpatch check?
> 
> Yes, kill it on the spot so that people don't get crazy ideas.

Will do.  

Thanks!
-Toshi
