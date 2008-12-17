From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH 1/many] PROC macro to annotate functions in assembly
	files
Date: Wed, 17 Dec 2008 21:33:18 +0300
Message-ID: <20081217183318.GG8078@localhost>
References: <1229505475-10219-1-git-send-email-heukelum@fastmail.fm> <1229505475-10219-2-git-send-email-heukelum@fastmail.fm> <20081217172640.GB5436@uranus.ravnborg.org> <20081217173824.GF8078@localhost> <20081217180023.GA5783@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:51123 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbYLQSdV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Dec 2008 13:33:21 -0500
Received: by fg-out-1718.google.com with SMTP id 19so15684fgg.17
        for <linux-arch@vger.kernel.org>; Wed, 17 Dec 2008 10:33:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081217180023.GA5783@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, linux-arch@vger.kernel.org, Alexander van Heukelum <heukelum@mailshack.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

[Sam Ravnborg - Wed, Dec 17, 2008 at 07:00:23PM +0100]
...
| > Sam, I think eventually we should get something like this:
| > 
| > - KPROBE will be eliminated and explicit section descriptions
| >   are to be used
| > - ENTRY could be used / or renamed for something more descriptive
| >   and being used aligned jmp targets or in case of procs with
| >   shared body
| > - PROC/ENDPROC are to replace old ENTRY/END for procs being called
| >   mostly from C code
| 
| So what prevents us from extending ENTRY/END instead of introducing
| another set?
| Let us try to extend what we have and not introduce something new.
| 
| 	Sam
| 

It could disable us to make such a conversion step-by-step I think.
Of course it would be better to just extend ENTRY/END (since already
there) and we could even restrict it to X86 only at the beginning
but even then we have to check all ENTRY/END that they are used properly
(ie like a procedure markers having @function attribute). Not sure
what would be better. And btw ENDPROC is more descriptive then plain END :)

		- Cyrill -
