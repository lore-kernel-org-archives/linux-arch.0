From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 3/3] truncate()/ftruncate() fix length argument on ia32
 emulation.
Date: Mon, 19 Sep 2011 15:16:31 +0200
Message-ID: <20110919131631.GA2355@osiris.boeblingen.de.ibm.com>
References: <1316282477.5814.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162]:41322 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200Ab1ISNQg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2011 09:16:36 -0400
Content-Disposition: inline
In-Reply-To: <1316282477.5814.19.camel@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Sat, Sep 17, 2011 at 08:01:17PM +0200, Thomas Meyer wrote:
> move signed-extended int to long, because of signed test.
> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>

[...]

> +asmlinkage long compat_sys_ftruncate(unsigned int fd, int length)
> +{
> +	return sys_ftruncate(fd, length);
> +}

That seems to be wrong... just look at this patch I sent two years
ago (which btw. introduced the compat truncate sign extension bug
on some architecutures).

http://www.spinics.net/lists/linux-arch/msg08633.html
