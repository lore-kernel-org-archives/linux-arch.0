Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:41771 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbXIMIKD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 Sep 2007 04:10:03 -0400
Date: Thu, 13 Sep 2007 17:09:50 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] Blackfin arch: add some missing syscall
Message-ID: <20070913080950.GA28055@linux-sh.org>
References: <1189670203.30686.15.camel@roc-desktop> <20070913080701.GB27871@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070913080701.GB27871@linux-sh.org>
Sender: linux-arch-owner@vger.kernel.org
To: Bryan Wu <bryan.wu@analog.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, uclinux-dist-devel@blackfin.uclinux.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Sep 13, 2007 at 05:07:01PM +0900, Paul Mundt wrote:
> On Thu, Sep 13, 2007 at 03:56:43PM +0800, Bryan Wu wrote:
> > +#define __NR_syscall		354
> >  #define NR_syscalls		__NR_syscall
> >  
> Err, why did you change __NR_syscall? This is going to break the ABI for
> anything using it, which is generally bad form.
> 
I can't read or think today, nevermind. The sys_fallocate() thing still
stands, though.
