From: Ley Foon Tan <lftan@altera.com>
Subject: Re: Generic syscall ABI support
Date: Fri, 29 Mar 2013 17:49:59 +0800
Message-ID: <1364550599.7481.8.camel@leyfoon-vm>
References: <1364532097.18069.7@driftwood> <51551E60.4070708@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db8lp0188.outbound.messaging.microsoft.com ([213.199.154.188]:9651
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752737Ab3C2KFL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 29 Mar 2013 06:05:11 -0400
In-Reply-To: <51551E60.4070708@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Rob Landley <rob@landley.net>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, 2013-03-28 at 21:53 -0700, H. Peter Anvin wrote:
> On 03/28/2013 09:41 PM, Rob Landley wrote:
> > 
> > You don't need a new glibc port, you need a new klibc or musl port.
> > 
> >   http://www.openwall.com/lists/musl/2012/07/08/1
> > 
> > Way less work than getting glibc working for your basic smoketest...
> > 
> 
> Good point.  Average time to port klibc to a new architecture is about
> four hours as long as the person porting knows the calling conventions
> and assembly language involved.
> 
> 	-hpa
> 
> 
Thanks for the suggestion.
Too bad we don't have in-house expert in klibc and musl port. 

Hi HPA,
I knew you are the developer of klibc. Do you have any documentation to
port a new architecture and also how to replace glibc with klibc in
build?

By the way, klibc or musl is easier to port?
Thanks.

Regards
lftan
