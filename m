From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: Re: "N" symbols and System.map
Date: Mon, 04 May 2009 14:26:14 -0700
Message-ID: <49FF5D76.8040204@linux.intel.com>
References: <49FB7692.2000508@linux.intel.com> <m2preso1wl.fsf@igel.home>	<20090501232149.GA28888@uranus.ravnborg.org>	<49FB8D27.3000305@linux.intel.com>	<20090504193336.GA10453@uranus.ravnborg.org> <m2skjkzhu6.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:53909 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752628AbZEDV0O (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2009 17:26:14 -0400
In-Reply-To: <m2skjkzhu6.fsf@igel.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

Andreas Schwab wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
> 
>> Andreas - can you explain what is happning here?
> 
> My best guess would be that it has to do with the fact that the _end
> symbol is attached to the .end section which is located before the debug
> sections, but the .end section is empty, so the symbol has the same
> address as the following debug section.  The ppc linker script does not
> attach the _end symbol to any section, so it becomes an absolute symbol.
> 

Yes; we used to do that in x86 too, but it messes up the post-processing 
for the relocatable kernel.

	-hpa
