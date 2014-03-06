From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Making a universal list of syscalls?
Date: Thu, 06 Mar 2014 15:44:58 -0800
Message-ID: <5319087A.8000109@zytor.com>
References: <CALCETrWbjazg_kAY1uAB+cMTdaJqtyGrTwQWNFCSzZ56B0KEkw@mail.gmail.com> <15044.1394017702@warthog.procyon.org.uk> <531906C7.5030409@zytor.com> <CALCETrXt7bqQxymOC0ke+4Uaqv7nGOHqw3YhVHf4YKvJ4b8WpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:52738 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbaCFXp0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Mar 2014 18:45:26 -0500
In-Reply-To: <CALCETrXt7bqQxymOC0ke+4Uaqv7nGOHqw3YhVHf4YKvJ4b8WpQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: David Howells <dhowells@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, libseccomp-discuss@lists.sourceforge.net

On 03/06/2014 03:40 PM, Andy Lutomirski wrote:
> On Thu, Mar 6, 2014 at 3:37 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> On 03/05/2014 03:08 AM, David Howells wrote:
>>> It would be really nice if we could do this in such a manner that we could
>>> build strace from it.
>>
>> strace, seccomp, klibc, ... we all need more or less the same stuff.
> 
> strace also needs to know what the pointed-to type is for pointer
> arguments, whether pointers are input, output, or both, and what kind
> of flags / constants fit in which integer slot.
> 

Yes.  That kind of information also needs to be annotated.

It might take a while to get there, but it should be part of the design.

	-hpa
