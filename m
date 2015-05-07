From: Chris Metcalf <cmetcalf@ezchip.com>
Subject: Re: [PATCH 2/3] string: provide strscpy() and strscpy_truncate()
Date: Thu, 7 May 2015 11:10:55 -0400
Message-ID: <554B807F.60902@ezchip.com>
References: <1430409677-13284-1-git-send-email-cmetcalf@ezchip.com> <1430409677-13284-3-git-send-email-cmetcalf@ezchip.com> <20150506150140.GB12986@mwanda> <554A3161.3030609@ezchip.com> <20150506155951.GS16501@mwanda> <CAMuHMdUuaRGn10_k+Gm7vG5P_=QfSw7Mao3oB_u2Poy=PeiGtg@mail.gmail.com> <20150507090034.GV16501@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-am1on0100.outbound.protection.outlook.com ([157.56.112.100]:20000
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751040AbbEGPLR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 7 May 2015 11:11:17 -0400
In-Reply-To: <20150507090034.GV16501@mwanda>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Fabian Frederick <fabf@skynet.be>, Randy Dunlap <rdunlap@infradead.org>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Greg KH <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>, Grant Likely <grant.likely@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 05/07/2015 05:00 AM, Dan Carpenter wrote:
> On Wed, May 06, 2015 at 06:45:56PM +0200, Geert Uytterhoeven wrote:
>> On Wed, May 6, 2015 at 5:59 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>> We actually do have a __must_check tag so it's easy enough to force
>>> people to check.  A different option is we could make it trigger a
>> People tend to ignore compiler warnings...
> We're doing a lot better these days with zero day build testing.  There
> is not even one ignored __must_check return in my allmodconfig.

If we keep the strscpy/strscpy_truncate distinction, I agree that having
__must_check on strscpy seems like a good idea.

>>> WARN_ONCE().
>>>
>>> #define strXcpy(dest, src, len) (({                             \
>>>          ssize_t __ret = strscpy_truncate(dest, src, len);       \
>>>          WARN_ONCE(__ret < 0, "strXcpy trancates\n");            \
>>>          __ret; }))
>> Which will probably trigger only in extreme cases in the wild, not during
>> development.
> It's less subtle than just putting an empty string there so we're more
> likely to get bug reports than with the original code.

The problem with WARN_ONCE() here is that we may be using strscpy()
to take user input of some kind.  If so, we don't want to warn if we
are truncating the string - we just want to return a suitable error up
the call stack.

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com
