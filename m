Return-Path: <SRS0=L8m+=2V=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbfLaXBW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Dec 2019 18:01:22 -0500
Date: Tue, 31 Dec 2019 15:01:21 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] proc: convert everything to "struct proc_ops"
Message-ID: <20191231150121.5b09e34205444f6c65277b73@linux-foundation.org>
In-Reply-To: <20191225172546.GB13378@avx2>
References: <20191225172228.GA13378@avx2>
        <20191225172546.GB13378@avx2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <20191231230121.sLHiKyNw0rKCdjCftUuONTrQeR4dacQDSV8yNOog6eU@z>

On Wed, 25 Dec 2019 20:25:46 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> The most notable change is DEFINE_SHOW_ATTRIBUTE macro split in
> seq_file.h.
> 
> Conversion rule is:
> 
> 	llseek		=> proc_lseek
> 	unlocked_ioctl	=> proc_ioctl
> 
> 	xxx		=> proc_xxx
> 
> 	delete ".owner = THIS_MODULE" line
> 
> ...
>
>  drivers/staging/isdn/hysdn/hysdn_procconf.c           |   15 +-
>  drivers/staging/isdn/hysdn/hysdn_proclog.c            |   17 +-

These seem to have disappeared in linux-next.
