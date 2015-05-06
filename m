From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/3] string: provide strscpy() and strscpy_truncate()
Date: Wed, 6 May 2015 18:01:40 +0300
Message-ID: <20150506150140.GB12986@mwanda>
References: <1430409677-13284-1-git-send-email-cmetcalf@ezchip.com>
 <1430409677-13284-3-git-send-email-cmetcalf@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:30659 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbbEFPCw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 May 2015 11:02:52 -0400
Content-Disposition: inline
In-Reply-To: <1430409677-13284-3-git-send-email-cmetcalf@ezchip.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Fabian Frederick <fabf@skynet.be>, Randy Dunlap <rdunlap@infradead.org>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, gregkh@linuxfoundation.org, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>, Grant Likely <grant.likely@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Thu, Apr 30, 2015 at 12:01:16PM -0400, Chris Metcalf wrote:
> +ssize_t strscpy(char *dest, const char *src, size_t count)
> +{
> +	ssize_t res = strscpy_truncate(dest, src, count);
> +	if (res < 0 && count != 0)
> +		dest[0] = '\0';

How is this better than returning a truncated string?  Is it just
because the caller was naughty so we give them a spanking?

> +	return res;
> +}

regards,
dan carpenter
