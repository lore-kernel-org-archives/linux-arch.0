Return-Path: <arun.sharma@intel.com>
Received: from fmr03.intel.com ([143.183.121.5]:24714 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S266222AbUGASYe
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 Jul 2004 14:24:34 -0400
Message-ID: <40E456D7.5060906@intel.com>
Date: Thu, 01 Jul 2004 11:24:23 -0700
From: Arun Sharma <arun.sharma@intel.com>
MIME-Version: 1.0
Subject: Re: compat_sys_adjtimex
References: <40E30E8F.3000601@intel.com> <16611.20590.297525.314297@cargo.ozlabs.ibm.com> <40E362D6.7010908@intel.com> <200407011502.14131.arnd@arndb.de>
In-Reply-To: <200407011502.14131.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On 7/1/2004 6:02 AM, Arnd Bergmann wrote:

Hi Arnd,

As always, thanks for the review.

[...]
> As an alternative approach I can prepare patches that simply
> add the compat_sys_* functions and leave it to each arch maintainer
> to remove their own versions.

Sure, that'd be fine by me.

	-Arun
