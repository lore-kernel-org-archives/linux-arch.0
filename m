Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268370AbUJOThp@vger.kernel.org>
Received: from [213.146.154.40] ([213.146.154.40]:51938 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S268200AbUJOThV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Oct 2004 15:37:21 -0400
Subject: Re: 4level page tables architecture porting
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20041015193215.GA9099@wotan.suse.de>
References: <20041015172112.73e884d9.ak@suse.de>
	 <1097863604.13633.431.camel@hades.cambridge.redhat.com>
	 <20041015193215.GA9099@wotan.suse.de>
Content-Type: text/plain
Message-Id: <1097869038.13633.582.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Fri, 15 Oct 2004 20:37:19 +0100
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, akpm@digeo.com
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2004-10-15 at 21:32 +0200, Andi Kleen wrote:
> Thanks. It looks like the TASK_SIZE there is not a multiple of PGDIR_MASK.
>
> Does it work with this patch?

Will try as soon as I've finished making ppc64 actually reserve initrd
pages :)

-- 
dwmw2
