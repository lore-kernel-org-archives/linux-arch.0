From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: asm-generic changes for 4.6
Date: Fri, 25 Mar 2016 16:17:01 +0100
Message-ID: <4835715.nQCP8sPCa9@wuerfel>
References: <11845534.Q9psV3m4LA@wuerfel> <CA+55aFxd28NSi=Tka=JyYB57mu96DNzikydS3C_O98arPDDMvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:62945 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbcCYPRI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Mar 2016 11:17:08 -0400
In-Reply-To: <CA+55aFxd28NSi=Tka=JyYB57mu96DNzikydS3C_O98arPDDMvw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thursday 24 March 2016 23:29:31 Linus Torvalds wrote:
> On Thu, Mar 24, 2016 at 2:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > asm-generic changes for 4.6
> 
> Btw, can you add "[GIT PULL]" to the subject line for your pulls? Or a
> "Please pull" in the body or similar.
> 
> When I do pulls, my email filter looks for (surprise surprise) the
> terms "git" and "pull".
> 
> And this didn't trigger either of those.
> 
> The normal git request-pull script has that "git" part, and some
> people just add the "Please pull" to the email, and my filter will
> pick that up too. But the easiest and preferred way for me to see pull
> requests ends up being that "[GIT PULL]" in the subject line. For the
> same reason I prefer "[PATCH x/y]" in the subject line for patches.
> 
> Not getting caught by my filter sometimes means that a pull gets
> delayed. Very seldom it might be overlooked entirely, but usually I do
> catch it later on after the other pulls (like happened now).
> 

Right. I realized my mistake the minute after sending the mail out,
but decided against sending it again immediately, assuming that you'd
either find it or I could resend the next day.

Thanks for pulling it in!

	Arnd
