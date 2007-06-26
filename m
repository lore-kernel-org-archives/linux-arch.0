Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:52642 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522AbXFZDzt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jun 2007 23:55:49 -0400
Date: Tue, 26 Jun 2007 09:29:46 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH 1/3] Make struct jprobe.entry a void *
Message-ID: <20070626035946.GA20460@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <78935473b1f70c863ab0be7d6cf4bcb04922b20b.1182822366.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78935473b1f70c863ab0be7d6cf4bcb04922b20b.1182822366.git.michael@ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@lst.de>, anil.s.keshavamurthy@intel.com
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jun 26, 2007 at 11:48:50AM +1000, Michael Ellerman wrote:
> ---
> 
> It isn't obvious where kprobes patches should go, is anyone "the" maintainer?
> Instead I've just sent this to everyone who'd touched the code lately, or
> might be otherwise interested.

There isn't a single maintainer for the kprobes infrastructure as it
contains quite a bit of low level arch specific code. The working model
currently is that the patches are sent to lkml with a cc to the
maintainers listed, as you've rightly done.

Ananth
