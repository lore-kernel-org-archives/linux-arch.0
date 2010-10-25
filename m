From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Partially revert patch that encloses asm-offset.h numbers
 in brackets
Date: Mon, 25 Oct 2010 09:37:26 -0700
Message-ID: <4CC5B246.5070909@zytor.com>
References: <4CC5B1A1020000780001EF7C@vpn.id2.novell.com> <20101025140218.5092.74117.stgit@warthog.procyon.org.uk> <28707.1288018465@redhat.com> <4CC5B8D3020000780001EFB4@vpn.id2.novell.com> <AANLkTi=mpKRQgZp5zCoCsBtkuWHrpkOq2Zch-OOGu4CC@mail.gmail.com> <4CC5A748.6050903@zytor.com> <AANLkTik1HB-P0x0e8ucHz7323F-_qAzkaHrHy1Yq4qwo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:48659 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755825Ab0JYQhy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Oct 2010 12:37:54 -0400
In-Reply-To: <AANLkTik1HB-P0x0e8ucHz7323F-_qAzkaHrHy1Yq4qwo@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jan Beulich <JBeulich@novell.com>, Alexander van Heukelum <heukelum@fastmail.fm>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, "H. Peter Anvin" <hpa@linux.intel.com>, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/25/2010 09:16 AM, Linus Torvalds wrote:
> On Mon, Oct 25, 2010 at 8:50 AM, H. Peter Anvin <hpa@zytor.com> wrote:
>>
>> As such, the only options I can really think about overriding the sed
>> expression for x86 or just saying gcc 2.16.90 or later is required...
> 
> gas, not gcc. But yeah, maybe we can do that. How long has this space
> breakage been going on? If it's a "we got a report from this one guy"
> kind of thing, then just saying "we don't support old gas versions
> because they are too broken" is probably the right thing to do.
> 
> No reason to make for maintenance problems and uglier code if we can
> just say "get a newer gas" to a few people. It's not like we haven't
> done that with gcc and other tools too.
> 
>                        Linus

The problem is that 2.16 isn't all that old; al lot of the "enterprise"
distros still ship it or AFAIK even older versions.  2.6.90 which I
*think* is the first fixed version dates from April 2005, so is
currently 5 years old; maybe that is within reason to kill off.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
