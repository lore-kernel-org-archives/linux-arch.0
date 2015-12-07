From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PSEUDOPATCH] rename is_compat_task
Date: Mon, 7 Dec 2015 23:42:52 +0000
Message-ID: <20151207234252.GI20997@ZenIV.linux.org.uk>
References: <CALCETrWkrtiwCVpqiWuD1Hf2BekCo+5F_orQdN2-K3osqze4Uw@mail.gmail.com>
 <11525805.FykVOSlruZ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37288 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932433AbbLGXm7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Dec 2015 18:42:59 -0500
Content-Disposition: inline
In-Reply-To: <11525805.FykVOSlruZ@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@amacapital.net>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Tue, Dec 08, 2015 at 12:16:51AM +0100, Arnd Bergmann wrote:

> As far as I know, x86 is the special case here, on all other architectures,
> this actually checks the task, and it's impossible to call a system call
> of the other kind.

sparc uses
	ta 0x10
for 32bit syscalls and
	ta 0x6d
for 64bit ones.  And yes, the same process can call both just fine.
