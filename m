From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 15/21] powerpc: Use generic posix_types.h
Date: Thu, 16 Feb 2012 12:58:14 -0800
Message-ID: <4F3D6DE6.4080209@zytor.com>
References: <1328677745-20121-16-git-send-email-hpa@zytor.com>  <1328677745-20121-1-git-send-email-hpa@zytor.com>  <3399.1329399884@redhat.com> <1329423997.2892.20.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:34475 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754089Ab2BPU6p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Feb 2012 15:58:45 -0500
In-Reply-To: <1329423997.2892.20.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Paul Mackerras <paulus@samba.org>

On 02/16/2012 12:26 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2012-02-16 at 13:44 +0000, David Howells wrote:
>> PowerPC exports __FD_SET() and co. to userspace under some circumstances,
>> therefore this patch potentially breaks the userspace ABI.  Is this okay, Ben?
>
> I don't know why we would need that in userspace, unless some tools I
> don't know about exploit them (hint: there shouldn't be)
>
> I'm happy to remove them and see if anybody complains.
>

I think they are cut-and-paste from the old libc5-enabled i386.  Note 
that __GNUC__ disables it.

	-hpa
