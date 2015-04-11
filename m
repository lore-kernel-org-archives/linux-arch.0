From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: Remove execution domain support
Date: Sat, 11 Apr 2015 22:04:14 +0100
Message-ID: <20150411210413.GI889@ZenIV.linux.org.uk>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
 <CA+55aFyXWGUYg7W5xZzh-3BT+NuCib-s5t_Ho3YTh3+QK26jSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37670 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438AbbDKVEn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 11 Apr 2015 17:04:43 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFyXWGUYg7W5xZzh-3BT+NuCib-s5t_Ho3YTh3+QK26jSA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Richard Weinberger <richard@nod.at>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, hskinnemoen@gmail.com, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Mark Salter <msalter@redhat.com>, "JACQUIOT-XID, Aurelien" <a-jacquiot@ti.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>

On Sat, Apr 11, 2015 at 01:52:21PM -0700, Linus Torvalds wrote:
> On Sat, Apr 11, 2015 at 1:47 PM, Richard Weinberger <richard@nod.at> wrote:
> >
> > The removal will make architecutre specific signal handling easier
> > and there is no need to keep execuction domains as this feature is
> > obviously incomplete and abandoned
> 
> Ack. The whole exec domain made some code code pretty inscrutable.
> 
> So I'd certainly be willing to pull this during the 4.1 merge window
> if nobody complains.
> 
> Anybody?

IIRC, only two places really used that thing - iBCS2 shite and RISCOS
compat one.  The former isnot in the tree at all, and I've no idea
how many users does the latter one have.  Probably not many, judging by this:
config ARTHUR
        tristate "RISC OS personality"
        depends on !AEABI
        help
          Say Y here to include the kernel code necessary if you want to run
          Acorn RISC OS/Arthur binaries under Linux. This code is still very
          experimental; if this sounds frightening, say N and sleep in peace.
          You can also say M here to compile this support as a module (which
          will be called arthur).

rmk might have a better idea of whether anyone gives a damn...
