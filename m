From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [RFC 01/32] fs: introduce new 'struct inode_time'
Date: Sat, 31 May 2014 10:39:02 +0200
Message-ID: <m2tx86l4ux.fsf@linux-m68k.org>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
	<1401480116-1973111-2-git-send-email-arnd@arndb.de>
	<CAMuHMdVgch4REGcYWFZXVToX2b8iCinFVV10Bz3VoeiZy_yBtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:58105 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbaEaIjI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 31 May 2014 04:39:08 -0400
In-Reply-To: <CAMuHMdVgch4REGcYWFZXVToX2b8iCinFVV10Bz3VoeiZy_yBtg@mail.gmail.com>
	(Geert Uytterhoeven's message of "Sat, 31 May 2014 09:56:29 +0200")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "Joseph S. Myers" <joseph@codesourcery.com>, John Stultz <john.stultz@linaro.org>, Christoph Hellwig <hch@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ley Foon Tan <lftan@altera.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux FS Devel <linux-fsdevel@vger.kernel.org>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Arnd,
>
> On Fri, May 30, 2014 at 10:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> + * The variant using bit fields is less efficient to access, but
>> + * small and has a wider range as the 32-bit one, plus it keeps
>> + * the signedness of the original timespec.
>> + */
>> +struct inode_time {
>> +       long long       tv_sec  : 34;
>> +       int             tv_nsec : 30;
>> +};
>
> Don't you need 31 bits for tv_nsec, to accommodate for the sign bit?
> I know you won't really store negative numbers there, but storing a large
> positive number will become negative on read out, won't it?

Only if the int bitfield is signed.  Bitfields are weird, aren't they? :-)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
