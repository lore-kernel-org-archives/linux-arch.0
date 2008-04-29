Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:51160 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269AbYD2CqR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Apr 2008 22:46:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18454.35824.527711.355488@cargo.ozlabs.ibm.com>
Date: Tue, 29 Apr 2008 12:46:08 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Add fast little-endian switch system call
In-Reply-To: <20080428144332.GA17109@lst.de>
References: <18453.18943.906693.409245@cargo.ozlabs.ibm.com>
	<20080428144332.GA17109@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@ozlabs.org, mtk.manpages@gmail.com, linux-arch@vger.kernel.org
Message-ID: <20080429024608.oZQx8WOn4s3H2HqQaWIFkw3glcCSJLzTOj4OB3AVcMc@z>

Christoph Hellwig writes:

> Am I missing something here or does this add a branch for every normal
> syscall?

It does, but the impact is so small as to be unmeasurable with
lmbench, even on the null syscall measurement.  The overhead of the
easily-predicted not-taken branch is completely swamped by the amount
of time that the sc and rfid instructions take.  I had it under a
config option at one point but then decided not to bother with that
when I couldn't measure any difference.

Paul.
