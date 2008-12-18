From: "Cyrill Gorcunov" <gorcunov@gmail.com>
Subject: Re: [PATCH 1/many] PROC macro to annotate functions in assembly files
Date: Thu, 18 Dec 2008 15:03:25 +0300
Message-ID: <aa79d98a0812180403p47c6257r8e48afeff2e9b324@mail.gmail.com>
References: <1229505475-10219-1-git-send-email-heukelum@fastmail.fm>
	 <1229505475-10219-2-git-send-email-heukelum@fastmail.fm>
	 <20081217172640.GB5436@uranus.ravnborg.org>
	 <20081217173824.GF8078@localhost>
	 <20081217180023.GA5783@uranus.ravnborg.org>
	 <1229593918.31758.1290707307@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:39701 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbYLRMD2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Dec 2008 07:03:28 -0500
In-Reply-To: <1229593918.31758.1290707307@webmail.messagingengine.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander van Heukelum <heukelum@fastmail.fm>
Cc: Sam Ravnborg <sam@ravnborg.org>, Jan Beulich <jbeulich@novell.com>, linux-arch@vger.kernel.org, Alexander van Heukelum <heukelum@mailshack.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Thu, Dec 18, 2008 at 12:51 PM, Alexander van Heukelum
<heukelum@fastmail.fm> wrote:
[...]
>> >
>> > Sam, I think eventually we should get something like this:
>> >
>> > - KPROBE will be eliminated and explicit section descriptions
>> >   are to be used
>> > - ENTRY could be used / or renamed for something more descriptive
>> >   and being used aligned jmp targets or in case of procs with
>> >   shared body
>
> I don't think ENTRY should be used for nested procedures. If the
> author wants to do something like that, he better knew something
> about the assembler anyhow.

Author anyway have to knew something. We can't bring some kind
of lexical machine that eliminate this needing :)

>
>> > - PROC/ENDPROC are to replace old ENTRY/END for procs being called
>> >   mostly from C code
>
> Currently there is many different patterns. Some functions use ENTRY
> without END, some use ENTRY/ENDPROC, some use ENDPROC without annotation
> at the start...

Alexander, I was just trying to say Sam about what we're planning to get
at the end of all this procedure. I mean I know there are some issues to
be fixed first.

Fix me if I'm wrong.

>
>> So what prevents us from extending ENTRY/END instead of introducing
>> another set?
>
> ENTRY/END alone is not enough if one wants to be able to distinguish
> between code (functions) and non-executed data.
>
>> Let us try to extend what we have and not introduce something new.
>
> Agreed. I vote to complement the existing ENDPROC annotation with
> the proposed PROC annotation. Let's call that an extension, not
> something new ;). As it stands it is not impossible to go with
> ENTRY/ENDPROC for code and ENTRY/END for data. However, ENTRY
> implies alignment and the prefered alignment for code and data
> might differ.

If ENTRY will be used for data objects it shouldn't contain any kind of
alignment since in general we could have arrays of bytes, words and so on.

>
> Greetings,
>    Alexander
>
>>       Sam
> --
>  Alexander van Heukelum
>  heukelum@fastmail.fm
