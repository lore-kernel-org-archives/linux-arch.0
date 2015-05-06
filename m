From: Chris Metcalf <cmetcalf@ezchip.com>
Subject: Re: [PATCH 2/3] string: provide strscpy() and strscpy_truncate()
Date: Wed, 6 May 2015 11:21:05 -0400
Message-ID: <554A3161.3030609@ezchip.com>
References: <1430409677-13284-1-git-send-email-cmetcalf@ezchip.com> <1430409677-13284-3-git-send-email-cmetcalf@ezchip.com> <20150506150140.GB12986@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db3on0066.outbound.protection.outlook.com ([157.55.234.66]:43264
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752017AbbEFPVY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 6 May 2015 11:21:24 -0400
In-Reply-To: <20150506150140.GB12986@mwanda>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Fabian Frederick <fabf@skynet.be>, Randy Dunlap <rdunlap@infradead.org>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, gregkh@linuxfoundation.org, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>, Grant Likely <grant.likely@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On 5/6/2015 11:01 AM, Dan Carpenter wrote:
> On Thu, Apr 30, 2015 at 12:01:16PM -0400, Chris Metcalf wrote:
>> >+ssize_t strscpy(char *dest, const char *src, size_t count)
>> >+{
>> >+	ssize_t res = strscpy_truncate(dest, src, count);
>> >+	if (res < 0 && count != 0)
>> >+		dest[0] = '\0';
> How is this better than returning a truncated string?  Is it just
> because the caller was naughty so we give them a spanking?

There are basically two issues here:

1. A truncated string with an error return may still cause program errors,
even if the caller checks for the error return, if the buffer is later interpreted
as a valid string due to some other program error.  It's defensive programming.

2. Programmers are fond of ignoring error returns.  My experience with
truncated strings is that in too many cases, truncation causes program
errors down the line.  It's better to ensure that no partial string is returned
in this case.

In a perfect world, all error returns would be checked, and there would be
no need for this, but we definitely don't live in that world :-)

That said, although I think my approach is correct, I'm open to a consensus
that having strscpy() leave a truncated string in the dest buffer is better.

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com
