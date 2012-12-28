Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from kiruna.synopsys.com ([198.182.44.80]:52523 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab2L1EmR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Dec 2012 23:42:17 -0500
Message-ID: <50DD231C.4060301@synopsys.com>
Date: Fri, 28 Dec 2012 10:12:04 +0530
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
MIME-Version: 1.0
Subject: Re: [PATCH] modpost: Ignore ARC specific non-alloc sections
References: <1352720953-24321-21-git-send-email-vgupta@synopsys.com> <1356605240-4555-1-git-send-email-vgupta@synopsys.com> <1356605240-4555-2-git-send-email-vgupta@synopsys.com> <20121227204816.GA2068@merkur.ravnborg.org>
In-Reply-To: <20121227204816.GA2068@merkur.ravnborg.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20121228044204.WTfmauqHVUuQ5WXFIOsguhUPEvo0D3cNf9C1zxk2_NQ@z>

On Friday 28 December 2012 02:18 AM, Sam Ravnborg wrote:
> On Thu, Dec 27, 2012 at 04:17:20PM +0530, Vineet Gupta wrote:
>> ARC relocatable object files contain one/more .gnu.linkonce.arcextmap.*
>> sections (collated by kernel/vmlinux.lds into .arcextmap in final link).
>> This section is used by debuggers to display the extension instructions
>> and need-not be loaded by target (hence !SHF_ALLOC)
>>
>> The final kernel binary only needs .arcextmap entry in modpost's ignore
>> list (section_white_list[]). However when building modules, modpost scans
>> each object file individually, hence tripping on non-aggregated
>> .gnu.linkonce.arcextmap.* entries as well.
> 
> The list exist for this particular purpose.
> So acked.
> 
>>
>> Thus need for the 2 entires !
>>
>> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 
> 
> 	Sam
> 

Thx,
-Vineet
