From: Christoph Hellwig <hch@lst.de>
Subject: USE_ELF_CORE_DUMP?
Date: Thu, 23 Apr 2009 20:33:31 +0200
Message-ID: <20090423183331.GA19899@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:38182 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757991AbZDWSdk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Apr 2009 14:33:40 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au
Cc: linux-kernel@vger.kernel.org

Currently all architectures but microblaze unconditionally define
USE_ELF_CORE_DUMP.  The microblaze ommision seems like an error to
me, so can we just kill this ifdef and make sure we are the same
everywhere?
