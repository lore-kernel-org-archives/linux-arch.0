Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46185 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105AbbFIG73 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 9 Jun 2015 02:59:29 -0400
Date: Tue, 9 Jun 2015 08:59:27 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 6/9] scatterlist: use sg_phys()
Message-ID: <20150609065927.GE10167@lst.de>
References: <20150605205052.20751.77149.stgit@dwillia2-desk3.amr.corp.intel.com> <20150605211935.20751.55654.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150605211935.20751.55654.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, boaz@plexistor.com, david@fromorbit.com, linux-arch@vger.kernel.org, arnd@arndb.de, ross.zwisler@linux.intel.com, linux-nvdimm@lists.01.org, benh@kernel.crashing.org, linux-fsdevel@vger.kernel.org, heiko.carstens@de.ibm.com, hch@lst.de, Julia Lawall <Julia.Lawall@lip6.fr>, tj@kernel.org, paulus@samba.org, hpa@zytor.com, schwidefsky@de.ibm.com, willy@linux.intel.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, mingo@kernel.org
Message-ID: <20150609065927.ZEqw5d2KpIlQRQHrsg7IvwfGLlgUXwd4IymfSGj6Aos@z>

Please send this and the next one to Jens for this cycle.
