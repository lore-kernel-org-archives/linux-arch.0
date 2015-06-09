From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 3/9] dax: drop size parameter to ->direct_access()
Date: Tue, 9 Jun 2015 08:51:44 +0200
Message-ID: <20150609065144.GB10167@lst.de>
References: <20150605205052.20751.77149.stgit@dwillia2-desk3.amr.corp.intel.com> <20150605211918.20751.21557.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46131 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752240AbbFIGvq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 9 Jun 2015 02:51:46 -0400
Content-Disposition: inline
In-Reply-To: <20150605211918.20751.21557.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, boaz@plexistor.com, david@fromorbit.com, linux-arch@vger.kernel.org, arnd@arndb.de, ross.zwisler@linux.intel.com, linux-nvdimm@lists.01.org, benh@kernel.crashing.org, linux-fsdevel@vger.kernel.org, heiko.carstens@de.ibm.com, hch@lst.de, tj@kernel.org, paulus@samba.org, hpa@zytor.com, schwidefsky@de.ibm.com, willy@linux.intel.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, mingo@kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
