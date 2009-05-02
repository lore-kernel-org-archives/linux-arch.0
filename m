From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: Re: "N" symbols and System.map
Date: Fri, 01 May 2009 17:00:39 -0700
Message-ID: <49FB8D27.3000305@linux.intel.com>
References: <49FB7692.2000508@linux.intel.com> <m2preso1wl.fsf@igel.home> <20090501232149.GA28888@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:45210 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752703AbZEBAAj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 20:00:39 -0400
In-Reply-To: <20090501232149.GA28888@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

Sam Ravnborg wrote:
> On Sat, May 02, 2009 at 01:10:18AM +0200, Andreas Schwab wrote:
>> "H. Peter Anvin" <hpa@linux.intel.com> writes:
>>
>>> right now, we filter out symbols that nm tag N, meaning "debugging
>>> symbols", from System.map.  However, at least on x86, the linker-generated
>>> symbol _end is tagged N, and in fact is the only N in the entire image.
>>>
>>> Are there other architectures which would suffer if N were included in
>>> System.map, or would that be a reasonable thing to do?
>> There should not be any N symbols unless you are using stabs debugging.
> 
> We have in vmlinux:
>         .end : AT(ADDR(.end) - LOAD_OFFSET) {
>                 _end = .;
>         }
> 
> 
> And I see:
> c1834000 N _end
> 
> This is the _only_ 'N' symbol in my vmlinux.
> 

Yup, this is what happens.  I don't know why the linker does this, and 
if there is a way around it.

	-hpa
