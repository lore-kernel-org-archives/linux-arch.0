Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:57345 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbbAIWQO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jan 2015 17:16:14 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1416830039-21952-1-git-send-email-drysdale@google.com>
	<1416830039-21952-6-git-send-email-drysdale@google.com>
	<54AFF813.7050604@gmail.com>
	<20150109161302.GQ4574@brightrain.aerifal.cx>
	<CAHse=S88Jy5ZKM_VY5onfvxX7dTMngnxuHfuLeSuzvKvQNP19A@mail.gmail.com>
	<20150109204815.GR4574@brightrain.aerifal.cx>
	<20150109205626.GK22149@ZenIV.linux.org.uk>
	<20150109205926.GT4574@brightrain.aerifal.cx>
	<20150109210941.GL22149@ZenIV.linux.org.uk>
	<20150109212852.GU4574@brightrain.aerifal.cx>
Date: Fri, 09 Jan 2015 16:13:27 -0600
In-Reply-To: <20150109212852.GU4574@brightrain.aerifal.cx> (Rich Felker's
	message of "Fri, 9 Jan 2015 16:28:52 -0500")
Message-ID: <87lhlbvbzs.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCHv10 man-pages 5/5] execveat.2: initial man page for execveat(2)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rich Felker <dalias@aerifal.cx>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, David Drysdale <drysdale@google.com>, "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>, Andy Lutomirski <luto@amacapital.net>, Meredydd Luff <meredydd@senatehouse.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, sparclinux@vger.kernel.org
Message-ID: <20150109221327.Mfjj1XoCts2tIZ9atfvRd3inrjHytnsd6nvb_DOgL8o@z>

Rich Felker <dalias@aerifal.cx> writes:

> On Fri, Jan 09, 2015 at 09:09:41PM +0000, Al Viro wrote:

> The "magic open-once magic symlink" approach is really the cleanest
> solution I can find. In the case where the interpreter does not open
> the script, nothing terribly bad happens; the magic symlink just
> sticks around until _exit or exec. In the case where the interpreter
> opens it more than once, you get a failure, but as far as I know
> existing interpreters don't do this, and it's arguably bad design. In
> any case it's a caught error.

And it doesn't work without introducing security vulnerabilities into
the kernel, because it breaks close-on-exec semantics.

All you have to do is pick a file descriptor, good canidates are 0 and
255 and make it a convention that that file descriptor is used for
fexecve.  At least when you want to support scripts.  Otherwise you can
set close-on-exec.

That results in no accumulation of file descriptors  because everyone
always uses the same file descriptor.

Regardless you don't have a patch and you aren't proposing code and the
code isn't actually broken so please go away.

Eric
