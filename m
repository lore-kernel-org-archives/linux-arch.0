From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: nios2: is the ptrace ABI correct?
Date: Tue, 24 Feb 2015 12:28:41 -0300
Message-ID: <54EC98A9.9080203@vanguardiasur.com.ar>
References: <CAAEAJfDjDYY-Z6cPyrddCXiFJzrjNx8jkSAJZuokeEM9NU6WWg@mail.gmail.com> <5636312.0WGrbVlVgB@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:34672 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbbBXPbC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Feb 2015 10:31:02 -0500
Received: by wghn12 with SMTP id n12so6022492wgh.1
        for <linux-arch@vger.kernel.org>; Tue, 24 Feb 2015 07:31:02 -0800 (PST)
In-Reply-To: <5636312.0WGrbVlVgB@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tobias Klauser <tklauser@distanz.ch>, Chung-Ling Tang <cltang@codesourcery.com>, Walter Goossens <waltergoossens@home.nl>, Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Arnd,

On 02/24/2015 05:54 AM, Arnd Bergmann wrote:
> On Tuesday 24 February 2015 00:04:21 Ezequiel Garcia wrote:
>> So, tried a different approach and removed pt_regs from the UAPI ptrace.h,
>> replacing it with a new user_regs that describes how registers are passed
>> to user. This however is also problematic, as pt_regs is already used
>> by glibc (not really sure what for).
>>
> 
> I've looked at glibc and could not find a use for pt_regs there. Where
> did you find it? It's quite possible that it's incorrect as well
> if the structures don't match.
> 

Gah, no, you are right. I got confused.

So it would be OK to avoid remove pt_regs from the uapi headers?
How does this affect the signal handling nios2 implementation?

-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
