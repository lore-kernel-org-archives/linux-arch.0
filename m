From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: Re: "N" symbols and System.map
Date: Fri, 05 Jun 2009 15:49:39 -0700
Message-ID: <4A29A103.9050007@linux.intel.com>
References: <49FB7692.2000508@linux.intel.com> <20090605222650.GM29008@uranus.ravnborg.org> <4A299C00.1010307@linux.intel.com> <20090605223728.GP29008@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:33015 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751433AbZFEWth (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Jun 2009 18:49:37 -0400
In-Reply-To: <20090605223728.GP29008@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

Sam Ravnborg wrote:
> On Fri, Jun 05, 2009 at 03:28:16PM -0700, H. Peter Anvin wrote:
>> Sam Ravnborg wrote:
>>> On Fri, May 01, 2009 at 03:24:18PM -0700, H. Peter Anvin wrote:
>>>> Hi all,
>>>>
>>>> right now, we filter out symbols that nm tag N, meaning "debugging 
>>>> symbols", from System.map.  However, at least on x86, the 
>>>> linker-generated symbol _end is tagged N, and in fact is the only N in 
>>>> the entire image.
>>>>
>>>> Are there other architectures which would suffer if N were included in 
>>>> System.map, or would that be a reasonable thing to do?
>>> Peter - what is status here?
>>>
>>> Do you see _end tagged N with -tip?
>>> We landed a lot of changes to vmlinux.lds there.
>>>
>>> Needless to say I have not included N symbols for now.
>>>
>> I haven't checked it for a bit, as my immediate need for it disappeared,
>> but I don't think it's changed.
> We can revisit this if needed.
> 

FWIW:

c43e0000 N _end

	-hpa
