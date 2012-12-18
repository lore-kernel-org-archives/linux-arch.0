Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-da0-f51.google.com ([209.85.210.51]:55504 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278Ab2LRCnT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 17 Dec 2012 21:43:19 -0500
Received: by mail-da0-f51.google.com with SMTP id i30so57193dad.38
        for <linux-arch@vger.kernel.org>; Mon, 17 Dec 2012 18:43:19 -0800 (PST)
Date: Mon, 17 Dec 2012 18:21:30 -0800
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/7] move debugfs to filesystems menu (fs/Kconfig)
Message-ID: <20121218022130.GA16839@kroah.com>
References: <20121217182206.91AA150A@kernel.stglabs.ibm.com>
 <20121217182207.4CF51258@kernel.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121217182207.4CF51258@kernel.stglabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20121218022130.PjnKaOfw7wuE3eGLAJa9ZRB0VqA9kdH3QVCdDCjwBP8@z>

On Mon, Dec 17, 2012 at 01:22:07PM -0500, Dave Hansen wrote:
> 
> debugfs may have started out as a kernel hacking kind of option.  But,
> today, it is an integral part of lots of facilities like tracing that
> are far from kernel hacking.  Let's move it out of the very cluttered
> "Kernel Hacking" menu and but it next to its real family: other
> filesystems like sysfs, configfs, or /proc.
> 
> Also, "Debug filesystem" sounds like a debugging option _for_
> filesystems code, not a filesystem for debugging.  We also never call
> it "the debug filesystem."  We always say "debugfs", so reflect the
> fact that we _call_ it debugfs in the menu text.
> 
> Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
