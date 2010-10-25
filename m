From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: Re: [PATCH] Partially revert patch that encloses asm-offset.h numbers
 in brackets
Date: Mon, 25 Oct 2010 10:51:06 -0700
Message-ID: <4CC5C38A.8090508@linux.intel.com>
References: <4CC5A748.6050903@zytor.com> <4CC5B1A1020000780001EF7C@vpn.id2.novell.com> <20101025140218.5092.74117.stgit@warthog.procyon.org.uk> <28707.1288018465@redhat.com> <4CC5B8D3020000780001EFB4@vpn.id2.novell.com> <AANLkTi=mpKRQgZp5zCoCsBtkuWHrpkOq2Zch-OOGu4CC@mail.gmail.com> <30620.1288022370@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22941 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754522Ab0JYRvH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Oct 2010 13:51:07 -0400
In-Reply-To: <30620.1288022370@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jan Beulich <JBeulich@novell.com>, Alexander van Heukelum <heukelum@fastmail.fm>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/25/2010 08:59 AM, David Howells wrote:
> H. Peter Anvin <hpa@zytor.com> wrote:
> 
>> As such, the only options I can really think about overriding the sed
>> expression for x86 or just saying gcc 2.16.90 or later is required...
> 
> Do you mean binutils-2.16.90?

Yes, of course.

	-hpa
