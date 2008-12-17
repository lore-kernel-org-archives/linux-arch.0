From: "Cyrill Gorcunov" <gorcunov@gmail.com>
Subject: Re: [PATCH last/many] x86: checking framework for correct use of ENTRY/PROC
Date: Wed, 17 Dec 2008 14:51:53 +0300
Message-ID: <aa79d98a0812170351rb64c595gc933456c661317c5@mail.gmail.com>
References: <1229505475-10219-1-git-send-email-heukelum@fastmail.fm>
	 <1229505475-10219-2-git-send-email-heukelum@fastmail.fm>
	 <1229505475-10219-3-git-send-email-heukelum@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:39088 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbYLQLvz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Dec 2008 06:51:55 -0500
In-Reply-To: <1229505475-10219-3-git-send-email-heukelum@fastmail.fm>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander van Heukelum <heukelum@fastmail.fm>
Cc: linux-arch@vger.kernel.org, Alexander van Heukelum <heukelum@mailshack.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>

On Wed, Dec 17, 2008 at 12:17 PM, Alexander van Heukelum
<heukelum@fastmail.fm> wrote:
> [ DO NOT APPLY (yet...) At this point this patch will
> just cause the build to abort due to annotation errors
> found. ]
>
> Introduce a checking framework to check correct pairing
> of ENTRY/END and PROC/ENDPROC. It also checks that the
> annotations are not nested. I have used the ideas and
> most of the implementation from Cyrill Gorcunov who
> introduced the framework to check for mismatching
> KPROBE_ENTRY annotations, which was however soon made
> obsolete by the removal of KPROBE_ENTRY/KPROBE_END.
>
> Checks performed:
>  o  END must terminate an ENTRY annotation
>  o  ENDPROC must terminate a PROC annotation
>  o  ENTRY or PROC cannot be nested inside
>        another ENTRY or PROC section.
>
> Finally the macro ENTRY_PROC_FINAL is introduced to
> enable checking correct closing of PROC and ENTRY
> sections at the end of assembly files.
>
> Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>
> Cc: Cyrill Gorcunov <gorcunov@gmail.com>
...

Thanks Alexander!

You know I think you meant __ASSEMBLY__ while
were typing __ASSEMBLER__. Don't you? :)
