From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Generic syscall ABI support
Date: Fri, 29 Mar 2013 10:42:52 +0000
Message-ID: <201303291042.52284.arnd@arndb.de>
References: <1364532097.18069.7@driftwood> <51551E60.4070708@zytor.com> <1364550599.7481.8.camel@leyfoon-vm>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55791 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab3C2Km6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Mar 2013 06:42:58 -0400
In-Reply-To: <1364550599.7481.8.camel@leyfoon-vm>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Friday 29 March 2013, Ley Foon Tan wrote:
> > 
> Thanks for the suggestion.
> Too bad we don't have in-house expert in klibc and musl port. 
> 
> Hi HPA,
> I knew you are the developer of klibc. Do you have any documentation to
> port a new architecture and also how to replace glibc with klibc in
> build?
> 
> By the way, klibc or musl is easier to port?

I have no experience with musl, but klibc is probably the easiest to
port that you can find. Doing a new port doesn't require any prior
knowledge of klibc itself, the code is so small that any experienced
C programmer can understand it entirely in short time and do a new
port. However, it is also not meant as a general purpose libc or a
glibc replacement, as there is a very limited set of code that can use
it. It's certainly complete enough to test that the ABI itself is
working.

	Arnd
