Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:7759 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbXGLIXr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jul 2007 04:23:47 -0400
Date: Thu, 12 Jul 2007 10:23:46 +0200 (CEST)
From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: [PATCH] Pass -g to assembler under CONFIG_DEBUG_INFO
In-Reply-To: <20070711165308.551f0c6c.akpm@linux-foundation.org>
Message-ID: <Pine.LNX.4.64.0707121023280.11053@fbirervta.pbzchgretzou.qr>
References: <46955BB1.20200@windriver.com> <20070711224327.9B0ED4D0555@magilla.localdomain>
 <20070711160335.8705f742.akpm@linux-foundation.org>
 <alpine.LFD.0.999.0707111640030.20061@woody.linux-foundation.org>
 <20070711165308.551f0c6c.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


On Jul 11 2007 16:53, Andrew Morton wrote:
>On Wed, 11 Jul 2007 16:40:29 -0700 (PDT)
>Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> On Wed, 11 Jul 2007, Andrew Morton wrote:
>> >
>> > OK, thanks.  So I ended up with the below as a probably-2.6.23 thing:
>> > ...
>> > +AFLAGS		+= $(call as-option, -gdwarf)
>> 
>> "-gdwarf2?"
>> 
>
>yep, that's what the kgdb tree was using - I'll fix it up.

I am all for using -ggdb/-ggdb2/-ggdb3 instead.



	Jan
-- 
