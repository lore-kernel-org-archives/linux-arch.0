From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [concept & "good taste" review] persistent store
Date: Fri, 17 Dec 2010 13:38:12 -0800
Message-ID: <AANLkTimA4x8oWyq71nOxB=Otp3Y0i3Kcu27DG0ajaXUG@mail.gmail.com>
References: <4d0662e511688484b3@agluck-desktop.sc.intel.com>
 <AANLkTindPUkF7fCkdbqSstNHFjF3_7fEYh18nhQFx_AJ@mail.gmail.com>
 <AANLkTim3OpjPysjdCLDuFgFOipmcxyr2ay5cvUAu5PHi@mail.gmail.com> <AANLkTinpYJddhgbf7=Pw_TtGrnWaC8fwo2xv1XRsT1w7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33139 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755862Ab0LQVik (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Dec 2010 16:38:40 -0500
In-Reply-To: <AANLkTinpYJddhgbf7=Pw_TtGrnWaC8fwo2xv1XRsT1w7@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu, greg@kroah.com, akpm@linux-foundation.org, ying.huang@intel.com, Borislav Petkov <bp@alien8.de>, David Miller <davem@davemloft.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jim Keniston <jkenisto@linux.vnet.ibm.com>, Kyungmin Park <kmpark@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "H. Peter Anvin" <hpa@zytor.com>

On Fri, Dec 17, 2010 at 10:09 AM, Tony Luck <tony.luck@intel.com> wrote:
>
> So does fixing this stupidity provide a useful point for this?

Yes. However, I still question the "filesystem" part.

Technically, what I think any persistent storage should aim for is to
be a "journal" - not a filesystem. It's most useful as a temporary
area for data _before_ that data actually hits the disk, and once it
has hit the disk (or has been picked up by a network syslog server, of
course), the usefulness of the persistent storage immediately
vanishes.

So I don't really mind having a filesystem interface to that (the
whole "everything is a file" model), but I think it can end up
confusing people about what this thing is useful for. I fear that
people will try to write to it from user space as some kind of
mini-filesystem, and that seems pointless.

                    Linus
