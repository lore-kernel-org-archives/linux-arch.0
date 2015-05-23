From: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH v3 06/11] scatterlist: support "page-less" (__pfn_t
	only) entries
Date: Sat, 23 May 2015 16:12:09 +0200
Message-ID: <20150523141209.GA19414@lst.de>
References: <20150512042629.11521.70356.stgit@dwillia2-desk3.amr.corp.intel.com> <20150512043001.11521.3526.stgit@dwillia2-desk3.amr.corp.intel.com> <1431542149.31415.10.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:37514 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757864AbbEWOMM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 23 May 2015 10:12:12 -0400
Content-Disposition: inline
In-Reply-To: <1431542149.31415.10.camel@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Williams, Dan J" <dan.j.williams@intel.com>
Cc: "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>, "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "j.glisse@gmail.com" <j.glisse@gmail.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "riel@redhat.com" <riel@redhat.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "willy@linux.intel.com" <willy@linux.intel.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "mgorman@suse.de" <mgorman@suse.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "david@fromorbit.com" <david@fromorbit.com>

On Wed, May 13, 2015 at 06:35:55PM +0000, Williams, Dan J wrote:
> Jens, I'm wondering if you want to take this series(.) as patches or
> prepare a git branch to pull?

Honestly I don't think it should go anyway.  It makes a big mess of
a structure without providing a real user for it.  Given how we are
using the bio_vec for in-kernel page based I/O these days it seems
like a very dangerous idea.
