Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:20681 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932558AbWHFOpM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 6 Aug 2006 10:45:12 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id k76EjAY20123
	for <linux-arch@vger.kernel.org>; Sun, 6 Aug 2006 10:45:11 -0400
Subject: Re: Proposed update to the kernel kmap/kunmap API [patch]
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <1154098166.9447.31.camel@mulgrave.il.steeleye.com>
References: <1154097354.9447.24.camel@mulgrave.il.steeleye.com>
	 <1154098166.9447.31.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Sun, 06 Aug 2006 09:45:03 -0500
Message-Id: <1154875504.3683.195.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2006-07-28 at 09:49 -0500, James Bottomley wrote:
> The simple part of the proposal is to give non-highmem architectures
> access to the kmap API for the purposes of overriding (this is what the
> attached patch does).
> 
> The more controversial part of the proposal is that we should now
> require all architectures with coherence issues to manage data coherence
> via the kmap/kunmap API.

I take silence to indicate assent, and everyone's fine with every aspect
of this, so I'll transfer the debate (or lack thereof) to lkml.

James


