From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH [ver #2] 31/39] UAPI: Fix arch/mips/include/asm/Kbuild to
 have separate header-y lines
Date: Fri, 8 Jul 2011 17:04:07 +0100
Message-ID: <20110708160407.GA8630@linux-mips.org>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
 <20110708142758.31344.86602.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37194 "EHLO linux-mips.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751818Ab1GHQL2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 12:11:28 -0400
Content-Disposition: inline
In-Reply-To: <20110708142758.31344.86602.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org

On Fri, Jul 08, 2011 at 03:27:58PM +0100, David Howells wrote:

> Fix arch/mips/include/asm/Kbuild to have a separate header-y line for each
> header to make them easier to delete individually.

Makes sense to have a consistent style with other architectures, even
without the rest of this series.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
