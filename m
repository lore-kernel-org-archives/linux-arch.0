From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Making a universal list of syscalls?
Date: Thu, 06 Mar 2014 15:37:43 -0800
Message-ID: <531906C7.5030409@zytor.com>
References: <CALCETrWbjazg_kAY1uAB+cMTdaJqtyGrTwQWNFCSzZ56B0KEkw@mail.gmail.com> <15044.1394017702@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:52648 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081AbaCFXiI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Mar 2014 18:38:08 -0500
In-Reply-To: <15044.1394017702@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@amacapital.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, libseccomp-discuss@lists.sourceforge.net

On 03/05/2014 03:08 AM, David Howells wrote:
> It would be really nice if we could do this in such a manner that we could
> build strace from it.

strace, seccomp, klibc, ... we all need more or less the same stuff.

	-hpa
