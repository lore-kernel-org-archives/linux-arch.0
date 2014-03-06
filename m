From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Making a universal list of syscalls?
Date: Thu, 6 Mar 2014 15:40:40 -0800
Message-ID: <CALCETrXt7bqQxymOC0ke+4Uaqv7nGOHqw3YhVHf4YKvJ4b8WpQ@mail.gmail.com>
References: <CALCETrWbjazg_kAY1uAB+cMTdaJqtyGrTwQWNFCSzZ56B0KEkw@mail.gmail.com>
 <15044.1394017702@warthog.procyon.org.uk> <531906C7.5030409@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:39573 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbaCFXlA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 18:41:00 -0500
Received: by mail-ve0-f175.google.com with SMTP id oz11so3423428veb.34
        for <linux-arch@vger.kernel.org>; Thu, 06 Mar 2014 15:41:00 -0800 (PST)
In-Reply-To: <531906C7.5030409@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Howells <dhowells@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, libseccomp-discuss@lists.sourceforge.net

On Thu, Mar 6, 2014 at 3:37 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 03/05/2014 03:08 AM, David Howells wrote:
>> It would be really nice if we could do this in such a manner that we could
>> build strace from it.
>
> strace, seccomp, klibc, ... we all need more or less the same stuff.

strace also needs to know what the pointed-to type is for pointer
arguments, whether pointers are input, output, or both, and what kind
of flags / constants fit in which integer slot.

--Andy

>
>         -hpa
>
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
