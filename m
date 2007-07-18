Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:58595 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764205AbXGRSpN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jul 2007 14:45:13 -0400
Message-ID: <469E5E90.3090702@zytor.com>
Date: Wed, 18 Jul 2007 11:40:16 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [patch 041/234] Report that kernel is tainted if there was an
 OOPS
References: <200707171103.l6HB3gDf013411@imap1.linux-foundation.org> <20070717181003.GA16147@flint.arm.linux.org.uk> <469DA543.2030601@openvz.org> <20070718071658.GA30270@flint.arm.linux.org.uk> <469DBFA2.7020608@openvz.org> <20070718072858.GB30270@flint.arm.linux.org.uk>
In-Reply-To: <20070718072858.GB30270@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Pavel Emelianov <xemul@openvz.org>, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

Russell King wrote:
>>>
>> Maybe. But the "tainted" mask is a common way to tell people that the 
>> kernel is not clean. Besides, the "D" taint flag and "non-zero" oops 
>> counter both mean the same thing, while "D" looks better.
> 
> The oops counter provides further (obvious) information.
> 
> However, if it's no longer needed due to adding the "D" taint flag, it
> can be removed entirely.
> 

I would say there is still a difference between oops [#2] or oops [#697]...

	-hpa
