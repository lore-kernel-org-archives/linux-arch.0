From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Generic syscall ABI support
Date: Thu, 28 Mar 2013 21:53:52 -0700
Message-ID: <51551E60.4070708@zytor.com>
References: <1364532097.18069.7@driftwood>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:34081 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641Ab3C2EyH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 29 Mar 2013 00:54:07 -0400
In-Reply-To: <1364532097.18069.7@driftwood>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Landley <rob@landley.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <lftan@altera.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 03/28/2013 09:41 PM, Rob Landley wrote:
> 
> You don't need a new glibc port, you need a new klibc or musl port.
> 
>   http://www.openwall.com/lists/musl/2012/07/08/1
> 
> Way less work than getting glibc working for your basic smoketest...
> 

Good point.  Average time to port klibc to a new architecture is about
four hours as long as the person porting knows the calling conventions
and assembly language involved.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
