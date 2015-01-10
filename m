Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:57555 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbbAJBU3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jan 2015 20:20:29 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1416830039-21952-6-git-send-email-drysdale@google.com>
	<54AFF813.7050604@gmail.com>
	<20150109161302.GQ4574@brightrain.aerifal.cx>
	<CAHse=S88Jy5ZKM_VY5onfvxX7dTMngnxuHfuLeSuzvKvQNP19A@mail.gmail.com>
	<20150109204815.GR4574@brightrain.aerifal.cx>
	<20150109205626.GK22149@ZenIV.linux.org.uk>
	<20150109205926.GT4574@brightrain.aerifal.cx>
	<20150109210941.GL22149@ZenIV.linux.org.uk>
	<20150109212852.GU4574@brightrain.aerifal.cx>
	<87lhlbvbzs.fsf@x220.int.ebiederm.org>
	<20150109223843.GX4574@brightrain.aerifal.cx>
Date: Fri, 09 Jan 2015 19:17:41 -0600
In-Reply-To: <20150109223843.GX4574@brightrain.aerifal.cx> (Rich Felker's
	message of "Fri, 9 Jan 2015 17:38:43 -0500")
Message-ID: <87mw5rtowa.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCHv10 man-pages 5/5] execveat.2: initial man page for execveat(2)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rich Felker <dalias@aerifal.cx>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, David Drysdale <drysdale@google.com>, "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>, Andy Lutomirski <luto@amacapital.net>, Meredydd Luff <meredydd@senatehouse.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Stephen Rothwell <sfr@canb.auug.org.au>, Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, sparclinux@vger.kernel.org
Message-ID: <20150110011741.8JrgyMdv4e_MbBNZOm8nydTuSlZUi9mkHu_34lcqeRw@z>

Rich Felker <dalias@aerifal.cx> writes:

> I'm not proposing code because I'm a libc developer not a kernel
> developer. I know what's needed for userspace to provide a conforming
> fexecve to applications, not how to implement that on the kernel side,
> although I'm trying to provide constructive ideas. The hostility is
> really not necessary.

Conforming to what?

The open group fexecve says nothing about requiring a file descriptor
passed to fexecve to have O_CLOEXEC.

Further looking at open group specification of exec it seems to indicate
the preferred way to handle this is for the kernel to return O_NOEXEC
and then libc gets to figure out how to run the shell script.  Is that
the kind of ``conforming'' implementation you are looking for?

Eric
