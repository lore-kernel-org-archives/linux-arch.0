Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:45770 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576AbXGMM4z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Jul 2007 08:56:55 -0400
Received: from localhost.localdomain ([127.0.0.1]:42630 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023646AbXGMM4x (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Jul 2007 13:56:53 +0100
Date: Thu, 12 Jul 2007 22:36:40 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [patch] bitops: lock bitops
Message-ID: <20070712213639.GA26969@linux-mips.org>
References: <20070712031419.GF32414@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070712031419.GF32414@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paul Mackerras <paulus@samba.org>, tony.luck@intel.com, benh@kernel.crashing.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Jul 12, 2007 at 05:14:19AM +0200, Nick Piggin wrote:

> Not sure who else can take advantage of these. Sparc64 probably.

The default implementation is perfect for MIPS.

  Ralf
