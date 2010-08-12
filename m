From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: + drivers-acpi-apei-erst-dbgc-get_useru64-doesnt-work-on-i386.patch
 added to -mm tree
Date: Wed, 11 Aug 2010 23:10:43 -0700
Message-ID: <4C639063.6050505@zytor.com>
References: <201008112336.o7BNaNEj020805@imap1.linux-foundation.org>	<20100811164310.a4790773.randy.dunlap@oracle.com>	<20100811173327.3ae325ff.akpm@linux-foundation.org>	<4C63771B.6030005@zytor.com>	<20100811213013.ab501c6e.akpm@linux-foundation.org>	<4C638140.1080202@zytor.com> <20100811230353.6cb87afd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070507020802040506090606"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:33745 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755115Ab0HLGLM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Aug 2010 02:11:12 -0400
In-Reply-To: <20100811230353.6cb87afd.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org, gcosta@redhat.com, lenb@kernel.org, mingo@elte.hu, tglx@linutronix.de, ying.huang@intel.com, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

This is a multi-part message in MIME format.
--------------070507020802040506090606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 08/11/2010 11:03 PM, Andrew Morton wrote:
> <I suspect you can do get_user() on a 4-byte or 8-byte struct right now
> and it'll work>

Not so:

/home/hpa/kernel/linux-2.6-tip.urgent/arch/x86/lib/testuser.c:12: error: 
conversion to non-scalar type requested

	-hpa

--------------070507020802040506090606
Content-Type: text/x-csrc;
 name="testuser.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="testuser.c"

#include <linux/types.h>
#include <linux/uaccess.h>

struct foo {
	u16 a, b;
};

int bluttan(struct foo *foo)
{
	struct foo bar;

	if (get_user(bar, foo))
		return -1;

	return bar.a + bar.b;
}

--------------070507020802040506090606--
