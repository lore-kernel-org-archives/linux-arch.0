From: Tony Luck <tony.luck@intel.com>
Subject: Re: [concept & "good taste" review] persistent store
Date: Mon, 20 Dec 2010 13:09:41 -0800
Message-ID: <AANLkTim51KRmJ66OwQ=EyZia8GojhX9TMikpgAMLXRgo@mail.gmail.com>
References: <AANLkTimA4x8oWyq71nOxB=Otp3Y0i3Kcu27DG0ajaXUG@mail.gmail.com>
	<AANLkTinCG+E6ZzpeRqsJP+-qvNDQXW4VZFgJ1c-sTryL@mail.gmail.com>
	<4D0BEE1F.7020008@zytor.com>
	<AANLkTinwFt+KDKNEYP9MWQ7wGb9qk=E2Xa3RJB3+MJnN@mail.gmail.com>
	<AANLkTinoV_pL=Ygqq4qt4f8c+wsdc9r9K7rcJ58aHjD1@mail.gmail.com>
	<AANLkTikhtWjFBQmA111Q+2JGRudrRNAmegGThMagr4vF@mail.gmail.com>
	<20101219091752.GA16150@liondog.tnic>
	<AANLkTi=9UZ5BYWo5xT=jh0upRP6PraH4S=t=tL49YRdr@mail.gmail.com>
	<20101220072632.GA28020@liondog.tnic>
	<AANLkTikhbxs-FU2qjpup17QDd67R78puMNvP4GNRwiKX@mail.gmail.com>
	<20101220185812.GA11285@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f194.google.com ([209.85.214.194]:43086 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933068Ab0LTVJm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Dec 2010 16:09:42 -0500
In-Reply-To: <20101220185812.GA11285@liondog.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Tony Luck <tony.luck@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>li

On Mon, Dec 20, 2010 at 10:58 AM, Borislav Petkov <bp@alien8.de> wrote:
> Yes, this was exactly what I was trying to say! Do something in a
> watchdog handler path that shows that we actually made progress. But
> you're right, we'd still need the notification. My look at "did we make
> a progress" was too simple and there _are_ nuances which need to be
> accounted for.

My view of the notification is:
1) Oops happens, gets written to persistent store.
2) fs/pstore code makes a file appear in /dev/pstore
3) Daemon that's watching /dev/pstore sees new file
4) File is read, copied some place safe and fsync'd
5) Daemon unlinks file from /dev/pstore
6) fs/pstore code tells platform level to erase record

-Tony
